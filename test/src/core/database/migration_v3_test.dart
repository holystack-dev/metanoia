import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

/// The 2 -> 3 migration runs once, on published installs holding real
/// confession data.
///
/// The schema-2 database it runs against is produced by letting drift create
/// the current schema and then reversing the v3 changes, rather than by
/// hand-writing DDL — a hand-written guess at the old schema would test the
/// guess, not the thing users actually have on disk.
void main() {
  late Database raw;

  Future<void> seedSchemaV2() async {
    // Let drift build the full, real schema.
    final current = AppDatabase(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
      false,
    );
    await current.customSelect('SELECT 1').get();
    await current.close();

    // Now roll it back to exactly what schema 2 looked like.
    raw.execute('DROP TABLE journal_sin_marks;');
    raw.execute('DROP TABLE journal_entries;');
    raw.execute('ALTER TABLE confession_items DROP COLUMN custom_sin_id;');
    raw.execute('PRAGMA user_version = 2;');

    raw.execute(
      'INSERT INTO confessions (id, date, is_finished) VALUES (1, 1700000000, 1);',
    );
    // A custom sin, with its id squatting in the `note` column.
    raw.execute(
      'INSERT INTO confession_items '
      '(id, confession_id, content, note, is_custom) '
      "VALUES (1, 1, 'a custom sin', '42', 1);",
    );
    // A listed sin whose `note` is a genuine user note, which must survive.
    raw.execute(
      'INSERT INTO confession_items '
      '(id, confession_id, content, note, is_custom, question_id) '
      "VALUES (2, 1, 'a listed sin', 'my own note', 0, 'en-01-001');",
    );
    // A penance, to prove nothing else is disturbed.
    raw.execute(
      'INSERT INTO penances (id, confession_id, description) '
      "VALUES (1, 1, 'Three Hail Marys');",
    );
  }

  /// Opens the database at the current schema, which runs the migration.
  AppDatabase openMigrated() => AppDatabase(
    NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    false,
  );

  setUp(() => raw = sqlite3.openInMemory());
  tearDown(() => raw.dispose());

  test('moves the custom-sin id out of `note` and keeps real notes', () async {
    await seedSchemaV2();

    final db = openMigrated();
    final items = await db.select(db.confessionItems).get();

    final custom = items.firstWhere((i) => i.isCustom);
    final listed = items.firstWhere((i) => !i.isCustom);

    // The id moved into its own column...
    expect(custom.customSinId, 42);
    expect(custom.note, isNull);

    // ...and a note that was actually a note was left exactly alone.
    expect(listed.note, 'my own note');
    expect(listed.customSinId, isNull);

    await db.close();
  });

  test('leaves the rest of the user data untouched', () async {
    await seedSchemaV2();

    final db = openMigrated();

    expect(await db.select(db.confessions).get(), hasLength(1));
    final penances = await db.select(db.penances).get();
    expect(penances.single.description, 'Three Hail Marys');

    final version = await db.customSelect('PRAGMA user_version').getSingle();
    expect(version.data.values.first, 3);

    await db.close();
  });

  test('creates the journal tables, and marks cascade with their entry', () async {
    await seedSchemaV2();

    final db = openMigrated();

    final entryId = await db
        .into(db.journalEntries)
        .insert(
          JournalEntriesCompanion.insert(
            entryDate: DateTime(2026, 7, 12),
            reflection: const Value('a quiet day'),
          ),
        );
    await db
        .into(db.journalSinMarks)
        .insert(
          JournalSinMarksCompanion.insert(
            entryId: entryId,
            questionKey: const Value('01-001'),
          ),
        );

    await (db.delete(db.journalEntries)
      ..where((t) => t.id.equals(entryId))).go();

    expect(await db.select(db.journalSinMarks).get(), isEmpty);

    await db.close();
  });

  test('survives being replayed after a kill mid-upgrade', () async {
    await seedSchemaV2();

    // Drift stamps the new schema version only after beforeOpen, which
    // re-syncs content and can take seconds. An app killed in that window
    // replays the v2 migration on next launch; a blind ADD COLUMN would throw
    // "duplicate column name" on every open and leave the data unreachable.
    final first = openMigrated();
    await first.customSelect('SELECT 1').get();
    await first.close();

    // Simulate the kill: the schema changes are on disk, but user_version was
    // never stamped, so the next open runs onUpgrade from 2 all over again.
    raw.execute('PRAGMA user_version = 2;');

    final second = openMigrated();
    await expectLater(
      second.select(second.confessionItems).get(),
      completes,
      reason: 'the replayed migration bricked the database',
    );

    // And it is still correct, not merely non-throwing.
    final items = await second.select(second.confessionItems).get();
    final custom = items.firstWhere((i) => i.isCustom);
    final listed = items.firstWhere((i) => !i.isCustom);

    expect(custom.customSinId, 42);
    expect(custom.note, isNull);
    expect(listed.note, 'my own note');
    expect(await second.select(second.penances).get(), hasLength(1));

    await second.close();
  });

  test('allows only one journal entry per calendar day', () async {
    await seedSchemaV2();
    final db = openMigrated();

    await db
        .into(db.journalEntries)
        .insert(
          JournalEntriesCompanion.insert(entryDate: DateTime(2026, 7, 12)),
        );

    // The unique day is what keeps the streak and calendar queries trivial.
    await expectLater(
      db
          .into(db.journalEntries)
          .insert(
            JournalEntriesCompanion.insert(entryDate: DateTime(2026, 7, 12)),
          ),
      throwsA(anything),
    );

    await db.close();
  });
}
