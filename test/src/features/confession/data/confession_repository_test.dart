import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/presentation/confession_screen.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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

      // Get finished confessions
      final confessions = await repository.getFinishedConfessions();

      // Should only include confession 1 (has items)
      expect(confessions.length, 1);
      expect(confessions[0].confession.id, confessionId1);
      expect(confessions[0].items.isNotEmpty, true);
      expect(confessions[0].items.length, 1);
      expect(confessions[0].items.first.content, 'Test sin 1');
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
}

class TestAppDatabase extends AppDatabase {
  TestAppDatabase(super.e);

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      // Skip syncContent()
    },
  );
}
