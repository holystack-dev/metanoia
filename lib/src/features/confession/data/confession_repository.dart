import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'confession_repository.g.dart';

@riverpod
ConfessionRepository confessionRepository(Ref ref) {
  return ConfessionRepository(ref.watch(appDatabaseProvider));
}

/// The most recent finished confession, or null.
///
/// A Drift stream: it re-emits whenever the confessions table changes, so no
/// call site has to remember to invalidate it after finishing or deleting a
/// confession.
@riverpod
Stream<Confession?> lastFinishedConfession(Ref ref) {
  return ref.watch(confessionRepositoryProvider).watchLastFinishedConfession();
}

/// Represents an active (unfinished) examination draft
class ActiveExaminationDraft {
  final Confession confession;
  final int itemCount;

  ActiveExaminationDraft({
    required this.confession,
    required this.itemCount,
  });
}

/// The unfinished confession currently being examined, if it has any items.
@riverpod
Stream<ActiveExaminationDraft?> activeExaminationDraft(Ref ref) {
  return ref.watch(confessionRepositoryProvider).watchActiveExaminationDraft();
}

/// The unfinished confession (with its items) shown on the confess screen.
@riverpod
Stream<ConfessionWithItems?> activeConfession(Ref ref) {
  return ref.watch(confessionRepositoryProvider).watchActiveConfession();
}

/// All finished confessions that still have items, newest first.
@riverpod
Stream<List<ConfessionWithItems>> finishedConfessions(Ref ref) {
  return ref.watch(confessionRepositoryProvider).watchFinishedConfessions();
}

class ConfessionRepository {
  final AppDatabase _db;

  ConfessionRepository(this._db);

  /// Finished confessions joined with their items, in one query.
  ///
  /// A LEFT join, so a confession with no items (saved with "Keep confession
  /// history" off) still appears, matching what analytics counts.
  JoinedSelectStatement _finishedConfessionsQuery() {
    return _db.select(_db.confessions).join([
      leftOuterJoin(
        _db.confessionItems,
        _db.confessionItems.confessionId.equalsExp(_db.confessions.id),
      ),
    ])
      ..where(_db.confessions.isFinished.equals(true))
      ..orderBy([
        OrderingTerm(
          expression: _db.confessions.date,
          mode: OrderingMode.desc,
        ),
      ]);
  }

  /// The latest unfinished confession, joined with its items (which may be
  /// none — a draft can exist with nothing selected yet).
  JoinedSelectStatement _activeConfessionQuery() {
    return _db.select(_db.confessions).join([
      leftOuterJoin(
        _db.confessionItems,
        _db.confessionItems.confessionId.equalsExp(_db.confessions.id),
      ),
    ])
      ..where(_db.confessions.isFinished.equals(false))
      ..orderBy([
        OrderingTerm(
          expression: _db.confessions.date,
          mode: OrderingMode.desc,
        ),
      ]);
  }

  /// Collapses joined confession/item rows into one entry per confession,
  /// keeping the order the rows came back in.
  List<ConfessionWithItems> _group(List<TypedResult> rows) {
    final confessions = <int, Confession>{};
    final items = <int, List<ConfessionItem>>{};
    final order = <int>[];

    for (final row in rows) {
      final confession = row.readTable(_db.confessions);
      if (!confessions.containsKey(confession.id)) {
        confessions[confession.id] = confession;
        items[confession.id] = <ConfessionItem>[];
        order.add(confession.id);
      }

      // Null for a left join against a confession with no items.
      final item = row.readTableOrNull(_db.confessionItems);
      if (item != null) items[confession.id]!.add(item);
    }

    return [
      for (final id in order) ConfessionWithItems(confessions[id]!, items[id]!),
    ];
  }

  /// Get all finished confessions ordered by date (newest first)
  Future<List<ConfessionWithItems>> getFinishedConfessions() async {
    return _group(await _finishedConfessionsQuery().get());
  }

  /// Watch all finished confessions ordered by date (newest first)
  Stream<List<ConfessionWithItems>> watchFinishedConfessions() {
    return _finishedConfessionsQuery().watch().map(_group);
  }

  /// Watch the active (unfinished) confession and its items.
  Stream<ConfessionWithItems?> watchActiveConfession() {
    return _activeConfessionQuery().watch().map((rows) {
      final grouped = _group(rows);
      return grouped.isEmpty ? null : grouped.first;
    });
  }

  /// Watch the active examination draft, which is the active confession once it
  /// has at least one item.
  Stream<ActiveExaminationDraft?> watchActiveExaminationDraft() {
    return watchActiveConfession().map((active) {
      if (active == null || active.items.isEmpty) return null;
      return ActiveExaminationDraft(
        confession: active.confession,
        itemCount: active.items.length,
      );
    });
  }

  /// Watch the most recent finished confession.
  Stream<Confession?> watchLastFinishedConfession() {
    return (_db.select(_db.confessions)
          ..where((tbl) => tbl.isFinished.equals(true))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ])
          ..limit(1))
        .watchSingleOrNull();
  }

  /// Delete a specific confession, its items and its penances
  ///
  /// The child rows are deleted explicitly rather than left to the declared
  /// `onDelete: KeyAction.cascade`, so that deletion stays complete even if
  /// foreign-key enforcement is ever off.
  Future<void> deleteConfession(int confessionId) async {
    await _db.transaction(() async {
      await (_db.delete(_db.confessionItems)
        ..where((tbl) => tbl.confessionId.equals(confessionId))).go();

      // Penances hold the priest-assigned text.
      await (_db.delete(_db.penances)
        ..where((tbl) => tbl.confessionId.equals(confessionId))).go();

      await (_db.delete(_db.confessions)
        ..where((tbl) => tbl.id.equals(confessionId))).go();
    });
  }

  /// Delete all finished confessions, their items and their penances
  Future<void> deleteAllFinishedConfessions() async {
    await _db.transaction(() async {
      final finishedIds =
          await (_db.select(_db.confessions)..where(
            (tbl) => tbl.isFinished.equals(true),
          )).map((c) => c.id).get();

      if (finishedIds.isEmpty) return;

      await (_db.delete(_db.confessionItems)
        ..where((tbl) => tbl.confessionId.isIn(finishedIds))).go();

      await (_db.delete(_db.penances)
        ..where((tbl) => tbl.confessionId.isIn(finishedIds))).go();

      await (_db.delete(_db.confessions)
        ..where((tbl) => tbl.isFinished.equals(true))).go();
    });
  }

  /// Discards the recorded sins of every finished confession, keeping the
  /// confessions themselves.
  ///
  /// Applies "Keep confession history" off retroactively. The dates survive,
  /// so streaks and analytics are preserved.
  ///
  /// Returns the number of items discarded.
  Future<int> discardStoredSins() async {
    return _db.transaction(() async {
      final finishedIds =
          await (_db.select(_db.confessions)..where(
            (tbl) => tbl.isFinished.equals(true),
          )).map((c) => c.id).get();

      if (finishedIds.isEmpty) return 0;

      return (_db.delete(_db.confessionItems)
        ..where((tbl) => tbl.confessionId.isIn(finishedIds))).go();
    });
  }

  /// Mark a confession as finished
  Future<void> markConfessionAsFinished(
    int confessionId, {
    bool keepHistory = true,
  }) async {
    await _db.transaction(() async {
      if (!keepHistory) {
        // Delete items if history is not kept
        await (_db.delete(_db.confessionItems)
          ..where((tbl) => tbl.confessionId.equals(confessionId))).go();
      }

      await (_db.update(_db.confessions)
        ..where((tbl) => tbl.id.equals(confessionId))).write(
        ConfessionsCompanion(
          isFinished: const Value(true),
          finishedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  /// Update the date of a confession
  Future<void> updateConfessionDate(int confessionId, DateTime newDate) async {
    await (_db.update(_db.confessions)
      ..where((tbl) => tbl.id.equals(confessionId))).write(
      ConfessionsCompanion(date: Value(newDate)),
    );
  }
}

class ConfessionWithItems {
  final Confession confession;
  final List<ConfessionItem> items;

  ConfessionWithItems(this.confession, this.items);
}
