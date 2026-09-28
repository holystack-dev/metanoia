import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_app.dart';

void main() {
  late TestAppDatabase db;

  setUp(() async {
    db = TestAppDatabase(NativeDatabase.memory());
    // Force the connection open so beforeOpen has run.
    await db.customSelect('SELECT 1').get();
  });

  tearDown(() async => db.close());

  test('foreign keys are enabled', () async {
    // Drift leaves them off by default, which would make every declared
    // `onDelete: KeyAction.cascade` in tables.dart a no-op.
    final row = await db.customSelect('PRAGMA foreign_keys').getSingle();

    expect(row.data.values.first, 1);
  });

  test('foreign keys actually cascade', () async {
    final confessionId = await db.customSelect(
      "INSERT INTO confessions (date, is_finished) "
      "VALUES (strftime('%s','now'), 1) RETURNING id",
    ).getSingle().then((r) => r.read<int>('id'));

    await db.customStatement(
      'INSERT INTO penances (confession_id, description) VALUES (?, ?)',
      [confessionId, 'Three Hail Marys'],
    );

    await db.customStatement('DELETE FROM confessions WHERE id = ?', [
      confessionId,
    ]);

    final penances = await db.customSelect('SELECT * FROM penances').get();
    expect(penances, isEmpty);
  });

  test('foreign-key columns are indexed', () async {
    // SQLite does not index FK columns automatically; without these, lookups
    // are full table scans.
    final rows = await db
        .customSelect(
          "SELECT name FROM sqlite_master "
          "WHERE type = 'index' AND name LIKE 'idx_%'",
        )
        .get();

    expect(
      rows.map((r) => r.read<String>('name')).toSet(),
      containsAll([
        'idx_confession_items_confession_id',
        'idx_penances_confession_id',
        'idx_examination_questions_commandment_id',
        'idx_examination_questions_language_code',
      ]),
    );
  });
}
