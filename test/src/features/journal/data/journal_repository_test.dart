import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/features/journal/data/journal_repository.dart';
import 'package:confessionapp/src/features/journal/domain/models/journal_models.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_app.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;
  late JournalRepository repository;

  setUp(() {
    db = TestAppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    repository = container.read(journalRepositoryProvider);
  });

  tearDown(() async {
    await db.close();
    container.dispose();
  });

  Future<void> writeDay(DateTime day, {String reflection = 'a day'}) {
    return repository.saveEntry(day, reflection: Value(reflection));
  }

  group('entries', () {
    test('one row per calendar day — a second save updates it', () async {
      final day = DateTime(2026, 7, 12, 9);

      await repository.saveEntry(day, gratitude: const Value('morning light'));
      // Same day, different time of day: must land on the same row.
      await repository.saveEntry(
        DateTime(2026, 7, 12, 22),
        reflection: const Value('an honest day'),
      );

      final entries = await db.select(db.journalEntries).get();
      expect(entries, hasLength(1));
      expect(entries.single.gratitude, 'morning light');
      // Saving reflection must not wipe the gratitude typed earlier.
      expect(entries.single.reflection, 'an honest day');
    });

    test('the day is stored as a timezone-independent date key', () async {
      // Storing local midnight as an instant would let the entry slide onto the
      // previous/next calendar day after a timezone change. It must be pinned to
      // UTC midnight of the calendar date instead.
      await repository.saveEntry(
        DateTime(2026, 7, 16, 14, 30),
        gratitude: const Value('an afternoon grace'),
      );

      final stored = (await db.select(db.journalEntries).get()).single;
      expect(stored.entryDate.toUtc(), DateTime.utc(2026, 7, 16));
    });

    test('concurrent saves do not create duplicate entries', () async {
      final day = DateTime(2026, 7, 12);

      // Without serialisation both writes would see no entry and both insert
      // one.
      await Future.wait([
        repository.saveEntry(day, gratitude: const Value('a')),
        repository.saveEntry(day, reflection: const Value('b')),
        repository.saveEntry(day, resolution: const Value('c')),
      ]);

      expect(await db.select(db.journalEntries).get(), hasLength(1));
    });

    test('watchDay re-emits without any invalidation', () async {
      final day = DateTime(2026, 7, 12);
      final sub = container.listen(journalDayProvider(day), (_, _) {});

      await writeDay(day, reflection: 'first');
      await waitUntil(
        () =>
            container
                .read(journalDayProvider(day))
                .valueOrNull
                ?.entry
                .reflection ==
            'first',
        reason: 'the day stream never emitted the saved entry',
      );

      sub.close();
    });
  });

  group('streams re-emit on a MARK write, not just an entry write', () {
    // Drift re-emits a stream only when a table in the watched statement
    // changes, so watchDay/watchMonth/watchStreak must watch journal_sin_marks
    // too; fetching marks inside an asyncMap would miss mark, unmark and
    // absolve updates.
    test('watchDay emits a mark added to an existing entry', () async {
      final day = DateTime(2026, 7, 12);
      await repository.saveEntry(day, reflection: const Value('a day'));

      final emissions = <int>[];
      final sub = repository
          .watchDay(day)
          .listen((d) => emissions.add(d?.marks.length ?? -1));

      await waitUntil(() => emissions.isNotEmpty);

      // This writes journal_sin_marks ONLY — the entry row already exists.
      await repository.addSinMark(day, questionKey: '01-001');

      await waitUntil(
        () => emissions.last == 1,
        reason: 'watchDay never re-emitted after a sin was marked',
      );

      await sub.cancel();
    });

    test('watchDay emits when a mark is removed', () async {
      final day = DateTime(2026, 7, 12);
      await repository.saveEntry(day, reflection: const Value('a day'));
      await repository.addSinMark(day, questionKey: '01-001');

      JournalDay? latest;
      final sub = repository.watchDay(day).listen((d) => latest = d);
      await waitUntil(() => latest?.marks.length == 1);

      await repository.removeSinMark(latest!.marks.single.id);

      await waitUntil(
        () => latest?.marks.isEmpty ?? false,
        reason: 'watchDay never re-emitted after a sin was unmarked',
      );

      await sub.cancel();
    });

    test('watchDay emits when a mark is absolved by a confession', () async {
      final day = DateTime(2026, 7, 12);
      await repository.addSinMark(day, questionKey: '01-001');

      JournalDay? latest;
      final sub = repository.watchDay(day).listen((d) => latest = d);
      await waitUntil(() => latest?.marks.length == 1);

      final confessionId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(day),
              isFinished: const Value(true),
            ),
          );
      await repository.markAsConfessed([latest!.marks.single.id], confessionId);

      await waitUntil(
        () => latest?.marks.single.confessedInConfessionId == confessionId,
        reason: 'the absolved stamp never reached an open journal screen',
      );

      await sub.cancel();
    });

    test('a mark-only day counts toward the streak as soon as it is marked',
        () async {
      final day = DateTime(2026, 7, 12);

      var streak = -1;
      final sub = repository
          .watchStreak(now: day)
          .listen((value) => streak = value);
      await waitUntil(() => streak == 0);

      await repository.addSinMark(day, questionKey: '01-001');

      await waitUntil(
        () => streak == 1,
        reason: 'the streak never re-emitted after a sin was marked',
      );

      await sub.cancel();
    });

    test('watchMonth emits a mark added to an existing entry', () async {
      final day = DateTime(2026, 7, 12);
      await repository.saveEntry(day, reflection: const Value('a day'));

      Map<DateTime, JournalDay>? month;
      final sub = repository
          .watchMonth(DateTime(2026, 7, 1))
          .listen((m) => month = m);
      await waitUntil(() => month?.isNotEmpty ?? false);

      await repository.addSinMark(day, questionKey: '01-001');

      await waitUntil(
        () => month?[DateTime(2026, 7, 12)]?.marks.length == 1,
        reason: 'watchMonth never re-emitted after a sin was marked',
      );

      await sub.cancel();
    });
  });

  group('sin marks', () {
    test('marking the same sin twice is a no-op', () async {
      final day = DateTime(2026, 7, 12);

      await repository.addSinMark(day, questionKey: '01-001');
      await repository.addSinMark(day, questionKey: '01-001');

      expect(await db.select(db.journalSinMarks).get(), hasLength(1));
    });

    test('marks are stored against the day and cascade with it', () async {
      final day = DateTime(2026, 7, 12);
      await repository.addSinMark(day, questionKey: '01-001', commandmentNo: 1);
      await repository.addSinMark(day, freeText: 'something else');

      final marks = await db.select(db.journalSinMarks).get();
      expect(marks, hasLength(2));

      await repository.deleteDay(day);
      expect(await db.select(db.journalSinMarks).get(), isEmpty);
    });

    test('unconfessed marks exclude ones already confessed', () async {
      final day = DateTime(2026, 7, 12);
      await repository.addSinMark(day, questionKey: '01-001');
      await repository.addSinMark(day, questionKey: '02-003');

      final all = await db.select(db.journalSinMarks).get();
      final confessionId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime(2026, 7, 12)),
              isFinished: const Value(true),
            ),
          );

      await repository.markAsConfessed([all.first.id], confessionId);

      final unconfessed = await repository.watchUnconfessedMarks().first;
      expect(unconfessed, hasLength(1));
      expect(unconfessed.single.questionKey, '02-003');
    });

    test('with history off, the free text is cleared when confessed', () async {
      final day = DateTime(2026, 7, 12);
      await repository.addSinMark(day, freeText: 'something private');
      final mark = (await db.select(db.journalSinMarks).get()).single;

      final confessionId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime(2026, 7, 12)),
              isFinished: const Value(true),
            ),
          );

      await repository.markAsConfessed(
        [mark.id],
        confessionId,
        keepHistory: false,
      );

      final updated = (await db.select(db.journalSinMarks).get()).single;
      expect(updated.freeText, isNull);
      expect(updated.confessedInConfessionId, confessionId);
    });
  });

  group('absolving marks when a confession is finished', () {
    /// A confession holding the items [build] makes for it, as the confess
    /// screen holds them when the user taps "finish".
    Future<int> confessionWith(
      List<ConfessionItemsCompanion> Function(int confessionId) build,
    ) async {
      final id = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime(2026, 7, 12)),
              isFinished: const Value(false),
            ),
          );

      for (final item in build(id)) {
        await db.into(db.confessionItems).insert(item);
      }
      return id;
    }

    Future<List<ConfessionItem>> itemsOf(int confessionId) {
      return (db.select(db.confessionItems)
            ..where((t) => t.confessionId.equals(confessionId)))
          .get();
    }

    test('stamps the marks the confession carried, and only those', () async {
      final day = DateTime(2026, 7, 12);

      await repository.addSinMark(day, questionKey: '01-001');
      await repository.addSinMark(day, customSinId: 3);
      await repository.addSinMark(day, freeText: 'said too much');
      // Marked, but not carried into this confession.
      await repository.addSinMark(day, questionKey: '05-002');

      final marks = await db.select(db.journalSinMarks).get();
      final freeTextMark = marks.firstWhere((m) => m.freeText != null);

      final confessionId = await confessionWith(
        (id) => [
          ConfessionItemsCompanion.insert(
            confessionId: id,
            content: 'A question',
            // Legacy language-scoped id: it must still match the neutral mark.
            questionId: const Value('en-01-001'),
          ),
          ConfessionItemsCompanion.insert(
            confessionId: id,
            content: 'My own sin',
            isCustom: const Value(true),
            customSinId: const Value(3),
          ),
          ConfessionItemsCompanion.insert(
            confessionId: id,
            content: 'said too much',
            questionId: Value('journal-${freeTextMark.id}'),
          ),
        ],
      );

      final stamped = await repository.markConfessedFromItems(
        confessionId,
        await itemsOf(confessionId),
      );
      expect(stamped, hasLength(3));

      final absolved = await db.select(db.journalSinMarks).get();
      for (final mark in absolved) {
        if (mark.questionKey == '05-002') {
          // Never confessed, so it stays available for the next examination.
          expect(mark.confessedInConfessionId, isNull);
        } else {
          expect(mark.confessedInConfessionId, confessionId);
        }
      }

      // And the untouched one is still offered up next time.
      final remaining = await repository.unconfessedMarks();
      expect(remaining, hasLength(1));
      expect(remaining.single.questionKey, '05-002');
    });

    test('with history off, the free text of a stamped mark is cleared', () async {
      final day = DateTime(2026, 7, 12);
      await repository.addSinMark(day, freeText: 'something private');
      final mark = (await db.select(db.journalSinMarks).get()).single;

      final confessionId = await confessionWith(
        (id) => [
          ConfessionItemsCompanion.insert(
            confessionId: id,
            content: 'something private',
            questionId: Value('journal-${mark.id}'),
          ),
        ],
      );

      await repository.markConfessedFromItems(
        confessionId,
        await itemsOf(confessionId),
        keepHistory: false,
      );

      final updated = (await db.select(db.journalSinMarks).get()).single;
      expect(updated.confessedInConfessionId, confessionId);
      // The fact of the confession survives; the words do not.
      expect(updated.freeText, isNull);
    });

    test('a mark already confessed is not re-stamped', () async {
      final day = DateTime(2026, 7, 12);
      await repository.addSinMark(day, questionKey: '01-001');
      final mark = (await db.select(db.journalSinMarks).get()).single;

      final first = await confessionWith(
        (id) => [
          ConfessionItemsCompanion.insert(
            confessionId: id,
            content: 'A question',
            questionId: const Value('01-001'),
          ),
        ],
      );
      await repository.markConfessedFromItems(first, await itemsOf(first));

      // The same sin, ticked by hand in a later confession: the old mark belongs
      // to the confession that actually absolved it.
      final second = await confessionWith(
        (id) => [
          ConfessionItemsCompanion.insert(
            confessionId: id,
            content: 'A question',
            questionId: const Value('01-001'),
          ),
        ],
      );
      final stamped = await repository.markConfessedFromItems(
        second,
        await itemsOf(second),
      );

      expect(stamped, isEmpty);
      final updated = (await db.select(db.journalSinMarks).get()).single;
      expect(updated.id, mark.id);
      expect(updated.confessedInConfessionId, first);
    });

    test('a custom sin whose id is still in the legacy note column matches', () async {
      final day = DateTime(2026, 7, 12);
      await repository.addSinMark(day, customSinId: 4);

      final confessionId = await confessionWith(
        (id) => [
          ConfessionItemsCompanion.insert(
            confessionId: id,
            content: 'My own sin',
            isCustom: const Value(true),
            note: const Value('4'),
          ),
        ],
      );

      final stamped = await repository.markConfessedFromItems(
        confessionId,
        await itemsOf(confessionId),
      );

      expect(stamped, hasLength(1));
    });
  });

  group('struggle areas', () {
    test('is empty when nothing has been marked', () async {
      expect(await repository.watchStruggleAreas().first, isEmpty);
    });

    test('groups marks by commandment, most marked first', () async {
      await repository.addSinMark(
        DateTime(2026, 7, 10),
        questionKey: '06-001',
        commandmentNo: 6,
      );
      await repository.addSinMark(
        DateTime(2026, 7, 11),
        questionKey: '06-002',
        commandmentNo: 6,
      );
      await repository.addSinMark(
        DateTime(2026, 7, 12),
        questionKey: '06-003',
        commandmentNo: 6,
      );
      await repository.addSinMark(
        DateTime(2026, 7, 11),
        questionKey: '02-001',
        commandmentNo: 2,
      );
      await repository.addSinMark(
        DateTime(2026, 7, 12),
        questionKey: '02-002',
        commandmentNo: 2,
      );
      await repository.addSinMark(
        DateTime(2026, 7, 12),
        questionKey: '08-001',
        commandmentNo: 8,
      );
      // A free-text mark with no commandment must not become a phantom group.
      await repository.addSinMark(DateTime(2026, 7, 12), freeText: 'no idea');

      final areas = await repository.watchStruggleAreas().first;

      expect(areas.map((a) => a.commandmentNo).toList(), [6, 2, 8]);
      expect(areas.map((a) => a.count).toList(), [3, 2, 1]);
    });

    test('counts marks across days, absolved ones included', () async {
      // Insights are about the shape of a life over time, not about what is
      // still outstanding, so a confessed mark still counts.
      await repository.addSinMark(
        DateTime(2026, 7, 11),
        questionKey: '05-001',
        commandmentNo: 5,
      );
      final mark = (await db.select(db.journalSinMarks).get()).single;

      final confessionId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime(2026, 7, 12)),
              isFinished: const Value(true),
            ),
          );
      await repository.markAsConfessed([mark.id], confessionId);

      final areas = await repository.watchStruggleAreas().first;
      expect(areas, hasLength(1));
      expect(areas.single.commandmentNo, 5);
      expect(areas.single.count, 1);
    });

    test('re-emits when a sin is marked, without an invalidation', () async {
      final emissions = <int>[];
      final sub = repository.watchStruggleAreas().listen((areas) {
        emissions.add(areas.length);
      });

      await repository.addSinMark(
        DateTime(2026, 7, 12),
        questionKey: '07-001',
        commandmentNo: 7,
      );

      await waitUntil(
        () => emissions.isNotEmpty && emissions.last == 1,
        reason: 'the struggle areas stream never re-emitted after a new mark',
      );

      await sub.cancel();
    });
  });

  group('streak', () {
    Future<int> streakOn(DateTime now) =>
        repository.watchStreak(now: now).first;

    test('is zero with no entries', () async {
      expect(await streakOn(DateTime(2026, 7, 12)), 0);
    });

    test('counts consecutive days ending today', () async {
      await writeDay(DateTime(2026, 7, 10));
      await writeDay(DateTime(2026, 7, 11));
      await writeDay(DateTime(2026, 7, 12));

      expect(await streakOn(DateTime(2026, 7, 12, 21)), 3);
    });

    test('still counts when today is not yet written', () async {
      await writeDay(DateTime(2026, 7, 10));
      await writeDay(DateTime(2026, 7, 11));

      // A streak is not broken merely because the evening entry is not in yet.
      expect(await streakOn(DateTime(2026, 7, 12, 9)), 2);
    });

    test('breaks on a missed day', () async {
      await writeDay(DateTime(2026, 7, 8));
      // 9th missed.
      await writeDay(DateTime(2026, 7, 10));
      await writeDay(DateTime(2026, 7, 11));

      expect(await streakOn(DateTime(2026, 7, 11)), 2);
    });

    test('counts across a month boundary', () async {
      await writeDay(DateTime(2026, 6, 29));
      await writeDay(DateTime(2026, 6, 30));
      await writeDay(DateTime(2026, 7, 1));

      expect(await streakOn(DateTime(2026, 7, 1)), 3);
    });

    test('the yesterday anchor survives a spring-forward', () async {
      // The day after spring-forward is 23 hours long. Anchoring on
      // "yesterday" by subtracting a Duration of 24h lands on the day BEFORE
      // yesterday, and reports an unbroken streak as broken.
      await writeDay(DateTime(2026, 3, 7));
      await writeDay(DateTime(2026, 3, 8));

      // Morning of the 9th, today not yet written.
      expect(await streakOn(DateTime(2026, 3, 9, 9)), 2);
    });

    test('counts across a DST transition', () async {
      // Stepping back by a Duration would slip an hour here and miss a day.
      await writeDay(DateTime(2026, 3, 7));
      await writeDay(DateTime(2026, 3, 8));
      await writeDay(DateTime(2026, 3, 9));

      expect(await streakOn(DateTime(2026, 3, 9, 12)), 3);
    });

    test('an empty entry row does not count', () async {
      // The row is created as soon as the user opens the day and autosave runs,
      // so an untouched day must not earn a streak.
      await repository.saveEntry(DateTime(2026, 7, 12));

      expect(await streakOn(DateTime(2026, 7, 12)), 0);
    });
  });

  group('month view', () {
    test('returns only that month, keyed by day', () async {
      await writeDay(DateTime(2026, 6, 30));
      await writeDay(DateTime(2026, 7, 1));
      await writeDay(DateTime(2026, 7, 31));
      await writeDay(DateTime(2026, 8, 1));

      final july = await repository.watchMonth(DateTime(2026, 7, 1)).first;

      expect(july.keys, hasLength(2));
      expect(july.containsKey(DateTime(2026, 7, 1)), isTrue);
      expect(july.containsKey(DateTime(2026, 7, 31)), isTrue);
      expect(july.containsKey(DateTime(2026, 6, 30)), isFalse);
    });
  });
}
