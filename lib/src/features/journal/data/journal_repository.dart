import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/utils/date_utils.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart'
    show kJournalSinKeyPrefix, neutralSelectionKey;
import 'package:confessionapp/src/features/journal/domain/models/journal_models.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'journal_repository.g.dart';

@riverpod
JournalRepository journalRepository(Ref ref) {
  return JournalRepository(ref.watch(appDatabaseProvider));
}

/// The entry for a given day, or null if the user has not written one.
@riverpod
Stream<JournalDay?> journalDay(Ref ref, DateTime day) {
  return ref.watch(journalRepositoryProvider).watchDay(day);
}

/// Every entry in the given month, keyed by day, for the calendar.
@riverpod
Stream<Map<DateTime, JournalDay>> journalMonth(Ref ref, DateTime month) {
  return ref.watch(journalRepositoryProvider).watchMonth(month);
}

/// Consecutive days, ending today or yesterday, with a non-empty entry.
@riverpod
Stream<int> journalStreak(Ref ref) {
  return ref.watch(journalRepositoryProvider).watchStreak();
}

/// Sins marked in the journal that have not yet been carried into a confession.
@riverpod
Stream<List<JournalSinMark>> unconfessedSinMarks(Ref ref) {
  return ref.watch(journalRepositoryProvider).watchUnconfessedMarks();
}

/// Journal sin marks grouped by commandment, most-marked first.
@riverpod
Stream<List<StruggleArea>> journalStruggleAreas(Ref ref) {
  return ref.watch(journalRepositoryProvider).watchStruggleAreas();
}

/// The ids of the [marks] whose sin appears among the [items] of a confession.
///
/// A mark is stamped confessed only when its sin was actually carried into the
/// confession, via "Prepare from Journal" or by ticking the same question.
List<int> journalMarkIdsIn(
  List<JournalSinMark> marks,
  List<ConfessionItem> items,
) {
  final questionKeys = <String>{};
  final customSinIds = <int>{};
  final freeTextMarkIds = <int>{};

  for (final item in items) {
    if (item.isCustom) {
      // Falls back to the legacy `note` for rows predating schema 3.
      final id = item.customSinId ?? int.tryParse(item.note ?? '');
      if (id != null) customSinIds.add(id);
      continue;
    }

    final questionId = item.questionId;
    if (questionId == null) continue;

    if (questionId.startsWith(kJournalSinKeyPrefix)) {
      final id = int.tryParse(
        questionId.substring(kJournalSinKeyPrefix.length),
      );
      if (id != null) freeTextMarkIds.add(id);
      continue;
    }

    // Legacy items stored language-scoped ids; marks are always neutral.
    questionKeys.add(neutralSelectionKey(questionId));
  }

  return [
    for (final mark in marks)
      if (freeTextMarkIds.contains(mark.id) ||
          (mark.questionKey != null &&
              questionKeys.contains(mark.questionKey)) ||
          (mark.customSinId != null && customSinIds.contains(mark.customSinId)))
        mark.id,
  ];
}

class JournalRepository {
  JournalRepository(this._db);

  final AppDatabase _db;

  /// Serializes every write.
  ///
  /// Autosave fires on each debounced keystroke and every sin toggle; racing
  /// writes would insert duplicate entry rows.
  Future<void> _writes = Future.value();

  Future<T> _serialize<T>(Future<T> Function() action) {
    final result = _writes.then((_) => action());
    // Keep the chain alive even if this write fails, while still handing the
    // error to the caller.
    _writes = result.then<void>((_) {}, onError: (_) {});
    return result;
  }

  // ---------------------------------------------------------------- reading

  /// Entries joined to their marks.
  ///
  /// Must stay a JOIN rather than marks fetched in an `asyncMap`: Drift only
  /// re-emits for tables in the watched statement, so otherwise changes to
  /// `journal_sin_marks` would never reach the screen.
  JoinedSelectStatement _entriesWithMarksQuery() {
    return _db.select(_db.journalEntries).join([
      leftOuterJoin(
        _db.journalSinMarks,
        _db.journalSinMarks.entryId.equalsExp(_db.journalEntries.id),
      ),
    ]);
  }

  /// Collapses joined entry/mark rows into one [JournalDay] per entry.
  List<JournalDay> _groupDays(List<TypedResult> rows) {
    final entries = <int, JournalEntry>{};
    final marks = <int, List<JournalSinMark>>{};
    final order = <int>[];

    for (final row in rows) {
      final entry = row.readTable(_db.journalEntries);
      if (!entries.containsKey(entry.id)) {
        entries[entry.id] = entry;
        marks[entry.id] = <JournalSinMark>[];
        order.add(entry.id);
      }

      // Null for a day with no marks (the left join).
      final mark = row.readTableOrNull(_db.journalSinMarks);
      if (mark != null) marks[entry.id]!.add(mark);
    }

    return [
      for (final id in order)
        JournalDay(
          entry: entries[id]!,
          marks: marks[id]!..sort((a, b) => a.createdAt.compareTo(b.createdAt)),
        ),
    ];
  }

  Stream<JournalDay?> watchDay(DateTime day) {
    final date = journalDateKey(day);

    return (_entriesWithMarksQuery()
          ..where(_db.journalEntries.entryDate.equals(date)))
        .watch()
        .map((rows) {
          final days = _groupDays(rows);
          return days.isEmpty ? null : days.first;
        });
  }

  Stream<Map<DateTime, JournalDay>> watchMonth(DateTime month) {
    // Match the UTC-midnight keys entries are stored under (journalDateKey).
    final start = DateTime.utc(month.year, month.month, 1);
    final end = DateTime.utc(month.year, month.month + 1, 1);

    return (_entriesWithMarksQuery()..where(
          _db.journalEntries.entryDate.isBiggerOrEqualValue(start) &
              _db.journalEntries.entryDate.isSmallerThanValue(end),
        ))
        .watch()
        .map((rows) {
          return {
            for (final day in _groupDays(rows))
              journalDayOf(day.entry.entryDate): day,
          };
        });
  }

  /// Consecutive days with a non-empty entry, counting back from today.
  ///
  /// Yesterday still counts as the anchor: a streak should not be reported as
  /// broken simply because the user has not yet written today's entry.
  Stream<int> watchStreak({DateTime? now}) {
    return _entriesWithMarksQuery().watch().map((rows) {
      final days = <DateTime>{
        for (final day in _groupDays(rows))
          if (day.isNotEmpty) journalDayOf(day.entry.entryDate),
      };
      if (days.isEmpty) return 0;

      final today = startOfDay(now ?? DateTime.now());
      var cursor = today;

      // Anchor on yesterday when today is not written. Dates are built from
      // components, not by subtracting a Duration, which lands on the wrong
      // day across a DST change.
      if (!days.contains(cursor)) {
        cursor = DateTime(today.year, today.month, today.day - 1);
        if (!days.contains(cursor)) return 0;
      }

      var streak = 0;
      while (days.contains(cursor)) {
        streak++;
        cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
      }

      return streak;
    });
  }

  Stream<List<JournalSinMark>> watchUnconfessedMarks() {
    return _unconfessedMarksQuery().watch();
  }

  /// One-shot form of [watchUnconfessedMarks], for the finish-confession flow.
  Future<List<JournalSinMark>> unconfessedMarks() =>
      _unconfessedMarksQuery().get();

  SimpleSelectStatement<$JournalSinMarksTable, JournalSinMark>
  _unconfessedMarksQuery() {
    return _db.select(_db.journalSinMarks)
      ..where((t) => t.confessedInConfessionId.isNull())
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
  }

  /// How often each commandment has been marked, most-marked first.

  Stream<List<StruggleArea>> watchStruggleAreas() {
    final marks = _db.journalSinMarks;
    final count = marks.id.count();

    final query = _db.selectOnly(marks)
      ..addColumns([marks.commandmentNo, count])
      ..where(marks.commandmentNo.isNotNull())
      ..groupBy([marks.commandmentNo])
      ..orderBy([
        OrderingTerm.desc(count),
        OrderingTerm.asc(marks.commandmentNo),
      ]);

    return query.watch().map(
      (rows) => [
        for (final row in rows)
          StruggleArea(
            commandmentNo: row.read(marks.commandmentNo)!,
            count: row.read(count)!,
          ),
      ],
    );
  }

  // ---------------------------------------------------------------- writing

  /// The entry for [day], creating it if this is the first write.
  Future<int> _ensureEntry(DateTime day) async {
    final date = journalDateKey(day);

    final existing =
        await (_db.select(_db.journalEntries)
              ..where((t) => t.entryDate.equals(date)))
            .getSingleOrNull();
    if (existing != null) return existing.id;

    return _db
        .into(_db.journalEntries)
        .insert(JournalEntriesCompanion.insert(entryDate: date));
  }

  /// Writes the text and mood fields of [day]'s entry.
  ///
  /// Only the fields passed are touched, so autosaving one field cannot wipe
  /// another that is still being typed.
  Future<void> saveEntry(
    DateTime day, {
    Value<String?> gratitude = const Value.absent(),
    Value<String?> reflection = const Value.absent(),
    Value<String?> resolution = const Value.absent(),
    Value<int?> mood = const Value.absent(),
  }) {
    return _serialize(() async {
      final entryId = await _ensureEntry(day);

      await (_db.update(_db.journalEntries)
        ..where((t) => t.id.equals(entryId))).write(
        JournalEntriesCompanion(
          gratitude: gratitude,
          reflection: reflection,
          resolution: resolution,
          mood: mood,
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  /// Marks a sin on [day]. Marking the same sin twice is a no-op.
  Future<void> addSinMark(
    DateTime day, {
    String? questionKey,
    int? customSinId,
    String? freeText,
    String? sinText,
    int? commandmentNo,
  }) {
    return _serialize(() async {
      final entryId = await _ensureEntry(day);

      final duplicate =
          await (_db.select(_db.journalSinMarks)..where(
            (t) =>
                t.entryId.equals(entryId) &
                (questionKey != null
                    ? t.questionKey.equals(questionKey)
                    : customSinId != null
                    ? t.customSinId.equals(customSinId)
                    : t.freeText.equals(freeText ?? '')),
          )).getSingleOrNull();
      if (duplicate != null) return;

      await _db
          .into(_db.journalSinMarks)
          .insert(
            JournalSinMarksCompanion.insert(
              entryId: entryId,
              questionKey: Value(questionKey),
              customSinId: Value(customSinId),
              freeText: Value(freeText),
              // The display text as it read when marked, so the mark survives
              // its source custom sin being edited or deleted.
              sinTextSnapshot: Value(sinText ?? freeText),
              commandmentNo: Value(commandmentNo),
            ),
          );
    });
  }

  Future<void> removeSinMark(int markId) {
    return _serialize(
      () =>
          (_db.delete(_db.journalSinMarks)
            ..where((t) => t.id.equals(markId))).go(),
    );
  }

  /// Deletes a whole day. Its marks go with it, via the cascade.
  Future<void> deleteDay(DateTime day) {
    final date = journalDateKey(day);
    return _serialize(
      () =>
          (_db.delete(_db.journalEntries)
            ..where((t) => t.entryDate.equals(date))).go(),
    );
  }

  /// Stamps every unconfessed mark whose sin appears among [items] as having
  /// been carried into [confessionId].
  ///
  /// Pass the items read before finishing the confession: with history off
  /// they are discarded by the finish.
  ///
  /// Returns the ids stamped.
  Future<List<int>> markConfessedFromItems(
    int confessionId,
    List<ConfessionItem> items, {
    bool keepHistory = true,
  }) async {
    final markIds = journalMarkIdsIn(await unconfessedMarks(), items);
    await markAsConfessed(markIds, confessionId, keepHistory: keepHistory);
    return markIds;
  }

  /// Stamps [markIds] as having been carried into [confessionId].
  ///
  /// [keepHistory] mirrors the user's privacy setting: with history off, the
  /// free text they typed is cleared, keeping only the fact that something was
  /// confessed that day.
  Future<void> markAsConfessed(
    List<int> markIds,
    int confessionId, {
    bool keepHistory = true,
  }) {
    if (markIds.isEmpty) return Future.value();

    return _serialize(() async {
      await (_db.update(_db.journalSinMarks)
        ..where((t) => t.id.isIn(markIds))).write(
        JournalSinMarksCompanion(
          confessedInConfessionId: Value(confessionId),
          freeText: keepHistory ? const Value.absent() : const Value(null),
        ),
      );
    });
  }
}
