import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/features/examination/data/user_custom_sins_repository.dart';
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

  group('UserCustomSinsRepository', () {
    test('insertCustomSin creates a new custom sin', () async {
      final repository = container.read(userCustomSinsRepositoryProvider);

      final id = await repository.insertCustomSin(
        UserCustomSinsCompanion.insert(
          sinText: 'Custom sin description',
        ),
      );

      expect(id, isPositive);

      final sin = await repository.getCustomSinById(id);
      expect(sin, isNotNull);
      expect(sin!.sinText, 'Custom sin description');
      expect(sin.commandmentCode, isNull);
    });

    test('insertCustomSin with commandment code', () async {
      final repository = container.read(userCustomSinsRepositoryProvider);

      final id = await repository.insertCustomSin(
        UserCustomSinsCompanion.insert(
          sinText: 'Lied to someone',
          commandmentCode: const Value('8'),
        ),
      );

      final sin = await repository.getCustomSinById(id);
      expect(sin, isNotNull);
      expect(sin!.commandmentCode, '8');
    });

    test('insertCustomSin with note', () async {
      final repository = container.read(userCustomSinsRepositoryProvider);

      final id = await repository.insertCustomSin(
        UserCustomSinsCompanion.insert(
          sinText: 'Custom sin',
          note: const Value('Additional note about this sin'),
        ),
      );

      final sin = await repository.getCustomSinById(id);
      expect(sin, isNotNull);
      expect(sin!.note, 'Additional note about this sin');
    });

    test('updateCustomSin updates existing sin', () async {
      final repository = container.read(userCustomSinsRepositoryProvider);

      final id = await repository.insertCustomSin(
        UserCustomSinsCompanion.insert(
          sinText: 'Original description',
        ),
      );

      await repository.updateCustomSin(
        id,
        const UserCustomSinsCompanion(
          sinText: Value('Updated description'),
        ),
      );

      final sin = await repository.getCustomSinById(id);
      expect(sin, isNotNull);
      expect(sin!.sinText, 'Updated description');
      expect(sin.updatedAt, isNotNull);
    });

    test('deleteCustomSin removes the sin', () async {
      final repository = container.read(userCustomSinsRepositoryProvider);

      final id = await repository.insertCustomSin(
        UserCustomSinsCompanion.insert(
          sinText: 'To be deleted',
        ),
      );

      await repository.deleteCustomSin(id);

      final sin = await repository.getCustomSinById(id);
      expect(sin, isNull);
    });

    test('getCustomSinById returns null for non-existent ID', () async {
      final repository = container.read(userCustomSinsRepositoryProvider);

      final sin = await repository.getCustomSinById(999);
      expect(sin, isNull);
    });

    test('getCustomSinsGroupedByCommandment groups sins correctly', () async {
      final repository = container.read(userCustomSinsRepositoryProvider);

      // Insert sins with different commandment codes
      await repository.insertCustomSin(
        UserCustomSinsCompanion.insert(
          sinText: 'Sin under commandment 1',
          commandmentCode: const Value('1'),
        ),
      );
      await repository.insertCustomSin(
        UserCustomSinsCompanion.insert(
          sinText: 'Another sin under commandment 1',
          commandmentCode: const Value('1'),
        ),
      );
      await repository.insertCustomSin(
        UserCustomSinsCompanion.insert(
          sinText: 'Sin under commandment 5',
          commandmentCode: const Value('5'),
        ),
      );
      await repository.insertCustomSin(
        UserCustomSinsCompanion.insert(
          sinText: 'Sin with no commandment',
        ),
      );

      final grouped = await repository.getCustomSinsGroupedByCommandment();

      expect(grouped.keys.length, 3); // '1', '5', and null
      expect(grouped['1']?.length, 2);
      expect(grouped['5']?.length, 1);
      expect(grouped[null]?.length, 1);
    });

    test('sins are ordered by creation date descending', () async {
      // Insert sins directly with explicit timestamps to ensure ordering
      final now = DateTime.now();

      await db.into(db.userCustomSins).insert(
        UserCustomSinsCompanion.insert(
          sinText: 'First sin',
          createdAt: Value(now.subtract(const Duration(hours: 2))),
          updatedAt: Value(now.subtract(const Duration(hours: 2))),
        ),
      );
      await db.into(db.userCustomSins).insert(
        UserCustomSinsCompanion.insert(
          sinText: 'Second sin',
          createdAt: Value(now.subtract(const Duration(hours: 1))),
          updatedAt: Value(now.subtract(const Duration(hours: 1))),
        ),
      );
      await db.into(db.userCustomSins).insert(
        UserCustomSinsCompanion.insert(
          sinText: 'Third sin',
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );

      final repository = container.read(userCustomSinsRepositoryProvider);
      final grouped = await repository.getCustomSinsGroupedByCommandment();
      final sins = grouped[null]!;

      // Most recent should be first (descending order)
      expect(sins.first.sinText, 'Third sin');
      expect(sins.last.sinText, 'First sin');
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
