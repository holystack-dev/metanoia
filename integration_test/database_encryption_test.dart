import 'dart:io';

import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_encryption.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

/// Runs on a real device/simulator: the only way to exercise the SQLCipher
/// native library and the platform keystore.
///
/// The plaintext -> encrypted migration runs once, irreversibly, on every
/// existing install; a bug here loses the user's confession history.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  late File dbFile;

  /// Header every plaintext SQLite file starts with. SQLCipher encrypts the
  /// header too, so its absence is the proof that encryption is real.
  const plaintextMagic = 'SQLite format 3';

  Future<void> removeDatabase() async {
    final folder = await getApplicationDocumentsDirectory();
    for (final suffix in ['', '-wal', '-shm']) {
      final f = File(p.join(folder.path, 'confession_app.sqlite$suffix'));
      if (f.existsSync()) await f.delete();
    }
  }

  setUp(() async {
    final folder = await getApplicationDocumentsDirectory();
    dbFile = File(p.join(folder.path, 'confession_app.sqlite'));

    await removeDatabase();
    await secureStorage.delete(key: 'db_key');
  });

  tearDown(() async {
    await removeDatabase();
    await secureStorage.delete(key: 'db_key');
  });

  Future<String> readHeader() async {
    final handle = await dbFile.open();
    try {
      final bytes = await handle.read(plaintextMagic.length);
      return String.fromCharCodes(bytes);
    } finally {
      await handle.close();
    }
  }

  testWidgets('a fresh database is written encrypted, not in cleartext', (
    _,
  ) async {
    final db = AppDatabase(openEncryptedDatabase(), false);
    await db
        .into(db.confessions)
        .insert(
          ConfessionsCompanion.insert(
            date: Value(DateTime.now()),
            isFinished: const Value(true),
          ),
        );
    await db.close();

    expect(dbFile.existsSync(), isTrue);
    expect(await readHeader(), isNot(plaintextMagic));

    // Unreadable without the key.
    expect(
      () => sqlite3.open(dbFile.path).select('SELECT * FROM sqlite_master'),
      throwsA(anything),
      reason: 'the database opened without a key — it is not encrypted',
    );
  });

  testWidgets('a legacy plaintext database is migrated with its data intact', (
    _,
  ) async {
    // Seed a pre-encryption install: the full drift schema in an unencrypted
    // file, plus a confession with an item and a priest-assigned penance.
    final legacy = AppDatabase(NativeDatabase(dbFile), false);
    final confessionId = await legacy
        .into(legacy.confessions)
        .insert(
          ConfessionsCompanion.insert(
            date: Value(DateTime.fromMillisecondsSinceEpoch(1700000000000)),
            isFinished: const Value(true),
          ),
        );
    await legacy
        .into(legacy.confessionItems)
        .insert(
          ConfessionItemsCompanion.insert(
            confessionId: confessionId,
            content: 'a sin the user confessed',
          ),
        );
    await legacy
        .into(legacy.penances)
        .insert(
          PenancesCompanion.insert(
            confessionId: confessionId,
            description: 'Three Hail Marys',
          ),
        );
    await legacy.close();

    // The schema version drift stamped into the plaintext file. sqlcipher_export
    // does not copy user_version, so this is the value the migration has to
    // carry across by hand. Read after the close, so the header is settled.
    final probe = sqlite3.open(dbFile.path);
    final versionBefore =
        probe.select('PRAGMA user_version').first.columnAt(0);
    probe.dispose();

    expect(
      await readHeader(),
      plaintextMagic,
      reason: 'the seeded database should start out as plaintext',
    );

    // Opening through the encrypted connection triggers the migration.
    final migrated = AppDatabase(openEncryptedDatabase(), false);
    final confessions = await migrated.select(migrated.confessions).get();
    final items = await migrated.select(migrated.confessionItems).get();
    final penances = await migrated.select(migrated.penances).get();
    final userVersion = await migrated
        .customSelect('PRAGMA user_version')
        .getSingle();
    await migrated.close();

    // Every row survived...
    expect(confessions, hasLength(1));
    expect(confessions.single.isFinished, isTrue);
    expect(items.single.content, 'a sin the user confessed');
    expect(penances.single.description, 'Three Hail Marys');

    // ...user_version carried over. sqlcipher_export does not copy it, and drift
    // keeps its schema version there — losing it would make drift treat the
    // migrated database as brand new and run onCreate over the user's data.
    expect(userVersion.data.values.first, versionBefore);

    // ...and the file on disk is no longer cleartext.
    expect(await readHeader(), isNot(plaintextMagic));
    expect(
      () => sqlite3.open(dbFile.path).select('SELECT * FROM confessions'),
      throwsA(anything),
      reason: 'the migrated database still opens without a key',
    );

    // No migration leftovers.
    expect(File('${dbFile.path}.sqlcipher-tmp').existsSync(), isFalse);
    expect(File('${dbFile.path}.pre-encryption-bak').existsSync(), isFalse);
  });

  testWidgets('an already-encrypted database is not migrated again', (
    _,
  ) async {
    final first = AppDatabase(openEncryptedDatabase(), false);
    await first
        .into(first.confessions)
        .insert(
          ConfessionsCompanion.insert(
            date: Value(DateTime.now()),
            isFinished: const Value(true),
          ),
        );
    await first.close();

    // Reopening must find the same data with the same key, not re-key or wipe.
    final second = AppDatabase(openEncryptedDatabase(), false);
    final rows = await second.select(second.confessions).get();
    await second.close();

    expect(rows, hasLength(1));
    expect(await readHeader(), isNot(plaintextMagic));
  });

  testWidgets('refuses to re-key an encrypted database whose key is gone', (
    _,
  ) async {
    final db = AppDatabase(openEncryptedDatabase(), false);
    await db.customSelect('SELECT 1').get();
    await db.close();

    // Losing the key must be a loud failure, not a silent wipe of the data it
    // protects.
    await secureStorage.delete(key: 'db_key');

    final orphaned = AppDatabase(openEncryptedDatabase(), false);
    await expectLater(
      orphaned.customSelect('SELECT 1').get(),
      throwsA(isA<DatabaseEncryptionException>()),
    );
  });
}
