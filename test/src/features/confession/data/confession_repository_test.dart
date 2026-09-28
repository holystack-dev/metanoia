import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/features/confession/data/confession_analytics_repository.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../helpers/test_app.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = TestAppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
  });

  tearDown(() async {
    await db.close();
    container.dispose();
  });

  group('ConfessionRepository', () {
    test('markConfessionAsFinished updates confession', () async {
      final repository = container.read(confessionRepositoryProvider);

      // Create active confession
      final confessionId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );

      await repository.markConfessionAsFinished(confessionId);

      final confession =
          await (db.select(db.confessions)
            ..where((t) => t.id.equals(confessionId))).getSingle();

      expect(confession.isFinished, true);
      expect(confession.finishedAt, isNotNull);
    });

    test('activeConfession returns correct confession', () async {
      // Create finished confession
      await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now().subtract(const Duration(days: 1))),
              isFinished: const Value(true),
              finishedAt: Value(DateTime.now()),
            ),
          );

      // Create active confession
      final activeId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );

      // Add items to active confession
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: activeId,
              questionId: const Value('en-01-001'),
              content: 'Test Item',
            ),
          );

      final activeConfession = await container.read(
        activeConfessionProvider.future,
      );

      expect(activeConfession, isNotNull);
      expect(activeConfession!.confession.id, activeId);
      expect(activeConfession.items.length, 1);
      expect(activeConfession.items.first.content, 'Test Item');
    });

    test('deleteConfession removes confession and items', () async {
      final repository = container.read(confessionRepositoryProvider);

      final confessionId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(true),
            ),
          );
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: confessionId,
              questionId: const Value('en-01-001'),
              content: 'Test Item',
            ),
          );

      await repository.deleteConfession(confessionId);

      final confessions = await db.select(db.confessions).get();
      expect(confessions, isEmpty);

      final items = await db.select(db.confessionItems).get();
      expect(items, isEmpty);
    });

    test('markConfessionAsFinished with keepHistory=false deletes items', () async {
      final repository = container.read(confessionRepositoryProvider);

      final confessionId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: confessionId,
              questionId: const Value('en-01-001'),
              content: 'Test Item',
            ),
          );

      await repository.markConfessionAsFinished(confessionId, keepHistory: false);

      final confession = await (db.select(db.confessions)
        ..where((t) => t.id.equals(confessionId))).getSingle();
      expect(confession.isFinished, true);

      final items = await db.select(db.confessionItems).get();
      expect(items, isEmpty);
    });

    test('updateConfessionDate changes the date', () async {
      final repository = container.read(confessionRepositoryProvider);
      final originalDate = DateTime(2024, 1, 1);
      final newDate = DateTime(2024, 6, 15);

      final confessionId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(originalDate),
              isFinished: const Value(true),
            ),
          );

      await repository.updateConfessionDate(confessionId, newDate);

      final confession = await (db.select(db.confessions)
        ..where((t) => t.id.equals(confessionId))).getSingle();
      expect(confession.date.month, 6);
      expect(confession.date.day, 15);
    });

    test('deleteAllFinishedConfessions removes only finished confessions', () async {
      final repository = container.read(confessionRepositoryProvider);

      // Create finished confession with items
      final finishedId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(true),
            ),
          );
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: finishedId,
              content: 'Finished item',
            ),
          );

      // Create unfinished confession (draft) with items
      final draftId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: draftId,
              content: 'Draft item',
            ),
          );

      await repository.deleteAllFinishedConfessions();

      final confessions = await db.select(db.confessions).get();
      expect(confessions.length, 1);
      expect(confessions.first.isFinished, false);

      final items = await db.select(db.confessionItems).get();
      expect(items.length, 1);
      expect(items.first.content, 'Draft item');
    });

    test('getFinishedConfessions returns only finished confessions', () async {
      final repository = container.read(confessionRepositoryProvider);

      // Create finished confession
      final finishedId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(true),
            ),
          );
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: finishedId,
              content: 'Finished item',
            ),
          );

      // Create draft
      await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );

      final finished = await repository.getFinishedConfessions();

      expect(finished.length, 1);
      expect(finished.first.confession.id, finishedId);
      expect(finished.first.items.length, 1);
    });

    test('getFinishedConfessions excludes confessions with no items', () async {
      final repository = container.read(confessionRepositoryProvider);

      // Create confession 1 with items (keepHistory=true)
      final confessionId1 = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: confessionId1,
              questionId: const Value('en-01-001'),
              content: 'Test sin 1',
            ),
          );
      await repository.markConfessionAsFinished(confessionId1, keepHistory: true);

      // Create confession 2 with items, then delete them (keepHistory=false)
      final confessionId2 = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: confessionId2,
              questionId: const Value('en-01-002'),
              content: 'Test sin 2',
            ),
          );
      await repository.markConfessionAsFinished(confessionId2, keepHistory: false);

      final confessions = await repository.getFinishedConfessions();

      // Both appear. The keepHistory=false confession keeps only its date, and
      // analytics counts it, so hiding it here would make the home total and
      // Insights disagree with this screen.
      expect(confessions.length, 2);

      final withHistory = confessions.firstWhere(
        (c) => c.confession.id == confessionId1,
      );
      expect(withHistory.items, hasLength(1));
      expect(withHistory.items.first.content, 'Test sin 1');

      // Date only — the sins themselves really were discarded.
      final dateOnly = confessions.firstWhere(
        (c) => c.confession.id == confessionId2,
      );
      expect(dateOnly.items, isEmpty);
      expect(dateOnly.confession.isFinished, isTrue);
    });

    test('discardStoredSins drops the sins but keeps the dates', () async {
      final repository = container.read(confessionRepositoryProvider);

      final id = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: id,
              content: 'a sin',
            ),
          );
      await repository.markConfessionAsFinished(id, keepHistory: true);

      final discarded = await repository.discardStoredSins();

      expect(discarded, 1);
      expect(await db.select(db.confessionItems).get(), isEmpty);

      // The confession itself survives, so streaks and insights are not
      // destroyed along with the sins.
      final confessions = await db.select(db.confessions).get();
      expect(confessions, hasLength(1));
      expect(confessions.single.isFinished, isTrue);
    });

    test('history and analytics agree on the total', () async {
      final repository = container.read(confessionRepositoryProvider);
      final analytics = container.read(confessionAnalyticsRepositoryProvider);

      // One confession keeping its history, one keeping only its date.
      for (final keepHistory in [true, false]) {
        final id = await db
            .into(db.confessions)
            .insert(
              ConfessionsCompanion.insert(
                date: Value(DateTime.now()),
                isFinished: const Value(false),
              ),
            );
        await db
            .into(db.confessionItems)
            .insert(
              ConfessionItemsCompanion.insert(
                confessionId: id,
                content: 'a sin',
              ),
            );
        await repository.markConfessionAsFinished(id, keepHistory: keepHistory);
      }

      final history = await repository.getFinishedConfessions();
      final stats = await analytics.getAnalytics();

      expect(history.length, stats.totalConfessions);
    });
  });

  group('activeExaminationDraftProvider', () {
    test('returns null when no draft exists', () async {
      final draft = await container.read(activeExaminationDraftProvider.future);
      expect(draft, isNull);
    });

    test('returns null when draft has no items', () async {
      // Create draft without items
      await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );

      final draft = await container.read(activeExaminationDraftProvider.future);
      expect(draft, isNull);
    });

    test('returns draft with item count when draft has items', () async {
      final draftId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );

      // Add items to draft
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: draftId,
              content: 'Item 1',
            ),
          );
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: draftId,
              content: 'Item 2',
            ),
          );
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: draftId,
              content: 'Item 3',
            ),
          );

      final draft = await container.read(activeExaminationDraftProvider.future);

      expect(draft, isNotNull);
      expect(draft!.confession.id, draftId);
      expect(draft.itemCount, 3);
    });

    test('ignores finished confessions', () async {
      // Create finished confession with items
      final finishedId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(true),
            ),
          );
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: finishedId,
              content: 'Finished item',
            ),
          );

      final draft = await container.read(activeExaminationDraftProvider.future);
      expect(draft, isNull);
    });
  });

  group('lastFinishedConfessionProvider', () {
    test('returns null when no finished confessions exist', () async {
      final last = await container.read(lastFinishedConfessionProvider.future);
      expect(last, isNull);
    });

    test('returns most recent finished confession', () async {
      // Create older confession
      await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now().subtract(const Duration(days: 7))),
              isFinished: const Value(true),
            ),
          );

      // Create newer confession
      final newerId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(true),
            ),
          );

      final last = await container.read(lastFinishedConfessionProvider.future);

      expect(last, isNotNull);
      expect(last!.id, newerId);
    });
  });

  group('deleting a confession removes its penance', () {
    /// Deleting a confession removes its priest-assigned penance through the
    /// declared cascade, which needs foreign keys on.
    Future<int> insertFinishedConfessionWithPenance(String description) async {
      final confessionId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(true),
            ),
          );
      await db
          .into(db.penances)
          .insert(
            PenancesCompanion.insert(
              confessionId: confessionId,
              description: description,
            ),
          );
      return confessionId;
    }

    test('deleteConfession deletes the penance too', () async {
      final repository = container.read(confessionRepositoryProvider);
      final confessionId = await insertFinishedConfessionWithPenance(
        'Three Hail Marys',
      );

      await repository.deleteConfession(confessionId);

      expect(await db.select(db.penances).get(), isEmpty);
    });

    test('deleteAllFinishedConfessions deletes their penances too', () async {
      final repository = container.read(confessionRepositoryProvider);
      await insertFinishedConfessionWithPenance('Three Hail Marys');
      await insertFinishedConfessionWithPenance('An Our Father');

      await repository.deleteAllFinishedConfessions();

      expect(await db.select(db.penances).get(), isEmpty);
    });

    test('deleteConfession leaves other confessions penances alone', () async {
      final repository = container.read(confessionRepositoryProvider);
      final doomed = await insertFinishedConfessionWithPenance('Doomed');
      await insertFinishedConfessionWithPenance('Kept');

      await repository.deleteConfession(doomed);

      final remaining = await db.select(db.penances).get();
      expect(remaining, hasLength(1));
      expect(remaining.single.description, 'Kept');
    });
  });

  /// The confession providers are Drift streams. Nothing below invalidates
  /// anything: the streams must re-emit on their own.
  group('confession providers re-emit without invalidation', () {
    Future<int> insertConfession({
      required bool isFinished,
      DateTime? date,
    }) {
      return db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(date ?? DateTime.now()),
              isFinished: Value(isFinished),
              finishedAt:
                  isFinished ? Value(DateTime.now()) : const Value.absent(),
            ),
          );
    }

    Future<void> insertItem(int confessionId, String content) async {
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: confessionId,
              content: content,
            ),
          );
    }

    test('finishedConfessions emits a newly finished confession', () async {
      final sub = container.listen(finishedConfessionsProvider, (_, __) {});
      addTearDown(sub.close);

      expect(await container.read(finishedConfessionsProvider.future), isEmpty);

      final id = await insertConfession(isFinished: false);
      await insertItem(id, 'Test Item');
      await container
          .read(confessionRepositoryProvider)
          .markConfessionAsFinished(id);

      await waitUntil(
        () =>
            container.read(finishedConfessionsProvider).valueOrNull?.length == 1,
        reason: 'the finished confession never reached the stream',
      );

      final history = container.read(finishedConfessionsProvider).requireValue;
      expect(history.single.confession.id, id);
      expect(history.single.items.single.content, 'Test Item');
    });

    test('finishedConfessions drops a deleted confession', () async {
      final id = await insertConfession(isFinished: true);
      await insertItem(id, 'Test Item');

      final sub = container.listen(finishedConfessionsProvider, (_, __) {});
      addTearDown(sub.close);

      expect(
        await container.read(finishedConfessionsProvider.future),
        hasLength(1),
      );

      await container.read(confessionRepositoryProvider).deleteConfession(id);

      await waitUntil(
        () => container.read(finishedConfessionsProvider).valueOrNull?.isEmpty
            ?? false,
        reason: 'the deleted confession never left the stream',
      );
    });

    test('lastFinishedConfession emits when a confession is finished', () async {
      final sub = container.listen(lastFinishedConfessionProvider, (_, __) {});
      addTearDown(sub.close);

      expect(await container.read(lastFinishedConfessionProvider.future), isNull);

      final id = await insertConfession(isFinished: false);
      await container
          .read(confessionRepositoryProvider)
          .markConfessionAsFinished(id);

      await waitUntil(
        () => container.read(lastFinishedConfessionProvider).valueOrNull != null,
        reason: 'the finished confession never reached the stream',
      );

      expect(
        container.read(lastFinishedConfessionProvider).requireValue!.id,
        id,
      );
    });

    test('activeExaminationDraft emits as items are added to the draft',
        () async {
      final sub = container.listen(activeExaminationDraftProvider, (_, __) {});
      addTearDown(sub.close);

      expect(await container.read(activeExaminationDraftProvider.future), isNull);

      final draftId = await insertConfession(isFinished: false);
      await insertItem(draftId, 'Item 1');

      await waitUntil(
        () =>
            container.read(activeExaminationDraftProvider).valueOrNull != null,
        reason: 'the draft never reached the stream',
      );
      expect(
        container.read(activeExaminationDraftProvider).requireValue!.itemCount,
        1,
      );

      await insertItem(draftId, 'Item 2');

      await waitUntil(
        () =>
            container
                .read(activeExaminationDraftProvider)
                .valueOrNull
                ?.itemCount ==
            2,
        reason: 'the second draft item never reached the stream',
      );
    });

    test('activeConfession clears once the confession is finished', () async {
      final id = await insertConfession(isFinished: false);
      await insertItem(id, 'Test Item');

      final sub = container.listen(activeConfessionProvider, (_, __) {});
      addTearDown(sub.close);

      final active = await container.read(activeConfessionProvider.future);
      expect(active!.confession.id, id);

      await container
          .read(confessionRepositoryProvider)
          .markConfessionAsFinished(id);

      await waitUntil(
        () => container.read(activeConfessionProvider).valueOrNull == null,
        reason: 'the finished confession never left the active stream',
      );
    });
  });
}
