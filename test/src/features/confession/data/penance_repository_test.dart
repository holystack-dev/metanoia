import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
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

  Future<int> createConfession({bool isFinished = true}) async {
    return await db.into(db.confessions).insert(
      ConfessionsCompanion.insert(
        date: Value(DateTime.now()),
        isFinished: Value(isFinished),
        finishedAt: isFinished ? Value(DateTime.now()) : const Value.absent(),
      ),
    );
  }

  group('PenanceRepository', () {
    test('addPenance creates a new penance', () async {
      final repository = container.read(penanceRepositoryProvider);
      final confessionId = await createConfession();

      final penanceId = await repository.addPenance(confessionId, 'Say 3 Hail Marys');

      expect(penanceId, isPositive);

      final penance = await (db.select(db.penances)
        ..where((t) => t.id.equals(penanceId))).getSingle();
      expect(penance.description, 'Say 3 Hail Marys');
      expect(penance.confessionId, confessionId);
      expect(penance.isCompleted, false);
      expect(penance.completedAt, isNull);
    });

    test('getPenanceForConfession returns correct penance', () async {
      final repository = container.read(penanceRepositoryProvider);
      final confessionId = await createConfession();

      await repository.addPenance(confessionId, 'Pray the Rosary');

      final penance = await repository.getPenanceForConfession(confessionId);

      expect(penance, isNotNull);
      expect(penance!.description, 'Pray the Rosary');
      expect(penance.confessionId, confessionId);
    });

    test('getPenanceForConfession returns null when no penance exists', () async {
      final repository = container.read(penanceRepositoryProvider);
      final confessionId = await createConfession();

      final penance = await repository.getPenanceForConfession(confessionId);

      expect(penance, isNull);
    });

    test('completePenance marks penance as completed', () async {
      final repository = container.read(penanceRepositoryProvider);
      final confessionId = await createConfession();
      final penanceId = await repository.addPenance(confessionId, 'Read Scripture');

      await repository.completePenance(penanceId);

      final penance = await (db.select(db.penances)
        ..where((t) => t.id.equals(penanceId))).getSingle();
      expect(penance.isCompleted, true);
      expect(penance.completedAt, isNotNull);
    });

    test('updatePenance updates description', () async {
      final repository = container.read(penanceRepositoryProvider);
      final confessionId = await createConfession();
      final penanceId = await repository.addPenance(confessionId, 'Old description');

      await repository.updatePenance(penanceId, 'New description');

      final penance = await (db.select(db.penances)
        ..where((t) => t.id.equals(penanceId))).getSingle();
      expect(penance.description, 'New description');
    });

    test('deletePenance removes penance', () async {
      final repository = container.read(penanceRepositoryProvider);
      final confessionId = await createConfession();
      final penanceId = await repository.addPenance(confessionId, 'To be deleted');

      await repository.deletePenance(penanceId);

      final penances = await db.select(db.penances).get();
      expect(penances, isEmpty);
    });

    test('getPendingPenances returns only incomplete penances', () async {
      final repository = container.read(penanceRepositoryProvider);

      // Create two confessions with penances
      final confession1 = await createConfession();
      final confession2 = await createConfession();

      await repository.addPenance(confession1, 'Pending penance');
      final completedPenanceId = await repository.addPenance(confession2, 'Completed penance');
      await repository.completePenance(completedPenanceId);

      final pendingPenances = await repository.getPendingPenances();

      expect(pendingPenances.length, 1);
      expect(pendingPenances.first.penance.description, 'Pending penance');
      expect(pendingPenances.first.confession.id, confession1);
    });

    test('getPendingPenances includes confession data', () async {
      final repository = container.read(penanceRepositoryProvider);
      final confessionId = await createConfession();

      await repository.addPenance(confessionId, 'Test penance');

      final pendingPenances = await repository.getPendingPenances();

      expect(pendingPenances.length, 1);
      expect(pendingPenances.first.penance.description, 'Test penance');
      expect(pendingPenances.first.confession.id, confessionId);
      expect(pendingPenances.first.confession.isFinished, true);
    });
  });

  group('Penance Providers', () {
    test('pendingPenancesProvider returns pending penances', () async {
      final repository = container.read(penanceRepositoryProvider);
      final confessionId = await createConfession();

      await repository.addPenance(confessionId, 'Provider test penance');

      final pendingPenances = await container.read(pendingPenancesProvider.future);

      expect(pendingPenances.length, 1);
      expect(pendingPenances.first.penance.description, 'Provider test penance');
    });

    test('penanceForConfessionProvider returns penance for specific confession', () async {
      final repository = container.read(penanceRepositoryProvider);
      final confessionId = await createConfession();

      await repository.addPenance(confessionId, 'Specific penance');

      final penance = await container.read(
        penanceForConfessionProvider(confessionId).future,
      );

      expect(penance, isNotNull);
      expect(penance!.description, 'Specific penance');
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
