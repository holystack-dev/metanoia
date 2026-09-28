import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../helpers/test_app.dart';

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

  test('Select question saves to draft with a language-neutral key', () async {
    final controller = container.read(examinationControllerProvider.notifier);

    await controller.selectQuestion('en-01-001', 'Test Question');

    expect(container.read(examinationControllerProvider), {
      '01-001': 'Test Question',
    });

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
    expect(items.first.questionId, '01-001');
    expect(items.first.content, 'Test Question');
  });

  test('Selection survives a content-language switch', () async {
    final controller = container.read(examinationControllerProvider.notifier);

    await controller.selectQuestion('en-01-001', 'Test Question');

    // The same question in another content language maps to the same key.
    expect(controller.isChecked('es-01-001'), true);
    expect(controller.isChecked('pt_BR-01-001'), true);

    // Re-selecting it in the other language does not duplicate the item.
    await controller.selectQuestion('es-01-001', 'Pregunta de prueba');
    expect(container.read(examinationControllerProvider).length, 1);

    final items = await db.select(db.confessionItems).get();
    expect(items.length, 1);
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
    expect(container.read(examinationControllerProvider), {
      '01-001': 'Test Question',
    });

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

  test('Restores draft on initialization (legacy language-scoped ids)', () async {
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
    await controller.draftRestored;

    expect(controller.state, {'01-001': 'Restored Question'});
    expect(controller.isDraftRestored, true);

    newContainer.dispose();
  });

  test('Draft restore merges with selections made while loading', () async {
    // Existing draft in the DB
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

    final newContainer = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    final controller = newContainer.read(
      examinationControllerProvider.notifier,
    );

    // Tap a question before the restore completes.
    final select = controller.selectQuestion('en-02-001', 'Tapped While Loading');
    await controller.draftRestored;
    await select;

    // The restore must not clobber the tap.
    expect(controller.state, {
      '01-001': 'Restored Question',
      '02-001': 'Tapped While Loading',
    });

    newContainer.dispose();
  });

  test('Concurrent draft saves create exactly one draft confession', () async {
    final controller = container.read(examinationControllerProvider.notifier);

    // Two rapid taps on first use must not both see a null draft id and each
    // insert a Confessions row, orphaning one of them.
    await Future.wait([
      controller.selectQuestion('en-01-001', 'First'),
      controller.selectQuestion('en-01-002', 'Second'),
      controller.selectQuestion('en-01-003', 'Third'),
    ]);

    final confessions = await db.select(db.confessions).get();
    expect(confessions.length, 1);

    // And no duplicated / interleaved items.
    final items = await db.select(db.confessionItems).get();
    expect(items.length, 3);
    expect(items.every((i) => i.confessionId == confessions.first.id), true);
    expect(
      items.map((i) => i.questionId).toSet(),
      {'01-001', '01-002', '01-003'},
    );
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
    // The id lives in its own column (schema 3); `note` is for the user's own
    // notes.
    expect(items.first.customSinId, 5);
    expect(items.first.note, isNull);
    expect(items.first.content, 'Custom Sin Text');
  });

  test('A custom sin round-trips through save and restore', () async {
    final controller = container.read(examinationControllerProvider.notifier);
    await controller.selectQuestion('custom-7', 'My Own Sin');

    final item = (await db.select(db.confessionItems).get()).single;
    expect(item.customSinId, 7);
    expect(item.note, isNull);

    // Restart the app: the draft must come back with its custom sin intact,
    // read from the id column rather than `note`.
    final newContainer = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    final restored = newContainer.read(examinationControllerProvider.notifier);
    await restored.draftRestored;

    expect(restored.state, {'custom-7': 'My Own Sin'});
    expect(restored.isChecked('custom-7'), true);

    newContainer.dispose();
  });

  test('A legacy custom sin item still restores from note', () async {
    // A row that escaped the v3 migration: the id is still in `note`. Dropping
    // it from the draft would lose the user's own sins, so reads fall back.
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
            content: 'Legacy Custom Sin',
            isCustom: const Value(true),
            note: const Value('9'),
          ),
        );

    final newContainer = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    final controller = newContainer.read(
      examinationControllerProvider.notifier,
    );
    await controller.draftRestored;

    expect(controller.state, {'custom-9': 'Legacy Custom Sin'});

    newContainer.dispose();
  });

  group('preloadFromJournal', () {
    test('carries questions, custom sins and free text into the draft', () async {
      final controller = container.read(examinationControllerProvider.notifier);

      final added = await controller.preloadFromJournal({
        '01-001': 'Marked question',
        'custom-3': 'My own sin',
        'journal-12': 'Something I typed one evening',
      });

      expect(added, 3);
      expect(container.read(examinationControllerProvider), {
        '01-001': 'Marked question',
        'custom-3': 'My own sin',
        'journal-12': 'Something I typed one evening',
      });

      // Exactly one draft, holding all three as items.
      final confessions = await db.select(db.confessions).get();
      expect(confessions, hasLength(1));

      final items = await db.select(db.confessionItems).get();
      expect(items, hasLength(3));

      final question = items.firstWhere((i) => i.questionId == '01-001');
      expect(question.isCustom, false);

      final custom = items.firstWhere((i) => i.isCustom);
      expect(custom.customSinId, 3);
      expect(custom.content, 'My own sin');

      // A free-text mark matches no question, so it is carried under its own
      // key — which is also what lets it be traced back and absolved later.
      final freeText = items.firstWhere((i) => i.questionId == 'journal-12');
      expect(freeText.content, 'Something I typed one evening');
    });

    test('does not duplicate a sin the user already selected', () async {
      final controller = container.read(examinationControllerProvider.notifier);

      await controller.selectQuestion('en-01-001', 'Ticked by hand');

      final added = await controller.preloadFromJournal({
        // The same question, marked in the journal in another content language.
        '01-001': 'Marked in the journal',
        '02-004': 'A new one',
      });

      // Only the sin that was not already selected is added, and the text the
      // user already had is left exactly as it was.
      expect(added, 1);
      expect(container.read(examinationControllerProvider), {
        '01-001': 'Ticked by hand',
        '02-004': 'A new one',
      });

      final items = await db.select(db.confessionItems).get();
      expect(items, hasLength(2));
      expect(
        items.firstWhere((i) => i.questionId == '01-001').content,
        'Ticked by hand',
      );
    });

    test('preloading nothing new leaves the draft untouched', () async {
      final controller = container.read(examinationControllerProvider.notifier);
      await controller.selectQuestion('en-01-001', 'Ticked by hand');

      expect(await controller.preloadFromJournal({'01-001': 'Same sin'}), 0);
      expect(await controller.preloadFromJournal({}), 0);

      expect(await db.select(db.confessionItems).get(), hasLength(1));
      expect(await db.select(db.confessions).get(), hasLength(1));
    });

    test('a preload racing a tap creates exactly one draft confession', () async {
      final controller = container.read(examinationControllerProvider.notifier);

      // The banner is tapped as the screen loads; the serialized write queue
      // keeps both writes from seeing a null draft id.
      await Future.wait([
        controller.preloadFromJournal({'01-001': 'From the journal'}),
        controller.selectQuestion('en-02-002', 'Tapped'),
      ]);

      expect(await db.select(db.confessions).get(), hasLength(1));

      final items = await db.select(db.confessionItems).get();
      expect(items, hasLength(2));
      expect(
        items.map((i) => i.questionId).toSet(),
        {'01-001', '02-002'},
      );
    });
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
