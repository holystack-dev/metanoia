import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUpAll(() {
    // Initialize Flutter binding for SharedPreferences
    WidgetsFlutterBinding.ensureInitialized();
    // Set up mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    db = TestAppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    // Reset mock SharedPreferences before each test
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() async {
    await db.close();
    container.dispose();
  });

  test('Initial state is empty', () {
    final controller = container.read(examinationControllerProvider);
    expect(controller, isEmpty);
  });

  test('Select question saves to draft', () async {
    final controller = container.read(examinationControllerProvider.notifier);

    await controller.selectQuestion('en-01-001', 'Test Question');

    expect(container.read(examinationControllerProvider), {'en-01-001': 'Test Question'});

    // Verify draft in DB
    final drafts =
        await (db.select(db.confessions)
          ..where((t) => t.isFinished.equals(false))).get();
    expect(drafts.length, 1);
    expect(drafts.first.isFinished, false);

    final items =
        await (db.select(db.confessionItems)
          ..where((t) => t.confessionId.equals(drafts.first.id))).get();
    expect(items.length, 1);
    expect(items.first.questionId, 'en-01-001');
    expect(items.first.content, 'Test Question');
  });

  test('Unselect question updates draft', () async {
    final controller = container.read(examinationControllerProvider.notifier);

    await controller.selectQuestion('en-01-001', 'Test Question');
    await controller.unselectQuestion('en-01-001');

    expect(container.read(examinationControllerProvider), isEmpty);

    // Verify draft items are empty
    final drafts =
        await (db.select(db.confessions)
          ..where((t) => t.isFinished.equals(false))).get();
    expect(drafts.length, 1); // Draft confession still exists

    final items =
        await (db.select(db.confessionItems)
          ..where((t) => t.confessionId.equals(drafts.first.id))).get();
    expect(items, isEmpty);
  });

  test('Save confession creates active confession and preserves state until clearAfterSave', () async {
    final controller = container.read(examinationControllerProvider.notifier);

    await controller.selectQuestion('en-01-001', 'Test Question');
    await controller.saveConfession();

    // State is preserved after saveConfession (for navigation purposes)
    expect(container.read(examinationControllerProvider), {'en-01-001': 'Test Question'});

    // Confession exists in database
    final confessions = await db.select(db.confessions).get();
    expect(confessions.length, 1);
    expect(confessions.first.isFinished, false);

    final items = await db.select(db.confessionItems).get();
    expect(items.length, 1);

    // State is cleared after clearAfterSave
    await controller.clearAfterSave();
    expect(container.read(examinationControllerProvider), isEmpty);
  });

  test('Restores draft on initialization', () async {
    // Create a draft manually
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
            content: 'Restored Question',
          ),
        );

    // Re-initialize container to simulate app restart
    final newContainer = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );

    final controller = newContainer.read(
      examinationControllerProvider.notifier,
    );
    // Give it a moment to load
    await Future.delayed(const Duration(milliseconds: 100));

    expect(controller.state, {'en-01-001': 'Restored Question'});
    expect(controller.isDraftRestored, true);

    newContainer.dispose();
  });

  test('Clear draft removes from DB', () async {
    final controller = container.read(examinationControllerProvider.notifier);

    await controller.selectQuestion('en-01-001', 'Test Question');
    await controller.clearDraft();

    expect(container.read(examinationControllerProvider), isEmpty);

    final confessions = await db.select(db.confessions).get();
    expect(confessions, isEmpty);
  });

  test('Select custom sin with custom- prefix ID', () async {
    final controller = container.read(examinationControllerProvider.notifier);

    // Custom sins use "custom-{id}" format
    await controller.selectQuestion('custom-5', 'Custom Sin Text');

    expect(container.read(examinationControllerProvider), {'custom-5': 'Custom Sin Text'});

    // Verify draft in DB with custom sin flag
    final drafts =
        await (db.select(db.confessions)
          ..where((t) => t.isFinished.equals(false))).get();
    expect(drafts.length, 1);

    final items =
        await (db.select(db.confessionItems)
          ..where((t) => t.confessionId.equals(drafts.first.id))).get();
    expect(items.length, 1);
    expect(items.first.isCustom, true);
    expect(items.first.note, '5'); // Custom sin ID stored in note field
    expect(items.first.content, 'Custom Sin Text');
  });

  test('isChecked returns correct state', () async {
    final controller = container.read(examinationControllerProvider.notifier);

    expect(controller.isChecked('en-01-001'), false);

    await controller.selectQuestion('en-01-001', 'Test Question');
    expect(controller.isChecked('en-01-001'), true);

    await controller.unselectQuestion('en-01-001');
    expect(controller.isChecked('en-01-001'), false);
  });
}

class TestAppDatabase extends AppDatabase {
  TestAppDatabase(super.e);

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      // Skip syncContent() for tests to avoid asset loading
    },
  );
}
