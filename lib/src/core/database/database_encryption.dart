import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

/// Raised when the database cannot be opened securely.
///
/// Every failure mode here is fatal: opening the database unencrypted, or
/// re-keying it in a way that orphans existing data, is worse than refusing to
/// start.
class DatabaseEncryptionException implements Exception {
  DatabaseEncryptionException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() =>
      'DatabaseEncryptionException: $message${cause == null ? '' : ' ($cause)'}';
}

const _dbFileName = 'confession_app.sqlite';
const _dbKeyStorageKey = 'db_key';

const _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
);

/// Every SQLite database file begins with this 16-byte header. SQLCipher
/// encrypts the header too, so its absence is what tells the two apart.
/// Keep the NUL as an escape: a raw 0x00 makes this file binary to git, and
/// changing it would misclassify plaintext databases as encrypted.
const _sqliteMagic = 'SQLite format 3\x00';

/// Suffix for the pre-migration copy kept until the encrypted DB is verified.
const _backupSuffix = '.pre-encryption-bak';

/// Suffix for the encrypted database being built during migration.
const _tempSuffix = '.sqlcipher-tmp';

/// Opens the encrypted application database, migrating a legacy plaintext
/// database in place on first run of an SQLCipher-enabled build.
LazyDatabase openEncryptedDatabase() {
  return LazyDatabase(() async {
    // Must run on this isolate too: the migration below opens the file
    // directly, outside drift's background isolate.
    await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
    _overrideSqlCipherOpen();

    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, _dbFileName));

    await _recoverInterruptedMigration(file);

    final exists = await file.exists();
    final isPlaintext = exists && await _isPlaintextDatabase(file);
    final key = await _readOrCreateKey(
      databaseExists: exists,
      databaseIsPlaintext: isPlaintext,
    );

    if (isPlaintext) {
      await _encryptPlaintextDatabase(file, key);
    }

    return NativeDatabase.createInBackground(
      file,
      isolateSetup: _isolateSetup,
      setup: (rawDb) {
        rawDb.execute('PRAGMA key = ${_quote(key)};');
        _assertSqlCipherIsActive(rawDb);
      },
    );
  });
}

/// Irreversibly removes the database from disk, including its journal
/// side-files and any migration leftovers.
///
/// The caller must close the [AppDatabase] first. Deleting only the main file
/// is not enough: a surviving `-wal` can still hold committed rows.
Future<void> deleteDatabaseFiles() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final base = p.join(dbFolder.path, _dbFileName);

  for (final path in [
    base,
    '$base-wal',
    '$base-shm',
    '$base$_backupSuffix',
    '$base$_tempSuffix',
  ]) {
    final file = File(path);
    if (await file.exists()) await file.delete();
  }
}

/// Removes the database key, so any copy of the database that outlives
/// [deleteDatabaseFiles] (a device backup, say) stays unreadable.
Future<void> deleteDatabaseKey() async {
  await _secureStorage.delete(key: _dbKeyStorageKey);
}

/// Runs inside drift's background isolate. The `open` override registered on
/// the main isolate does not carry across, so it must be applied again here or
/// the isolate would load plain SQLite and silently ignore `PRAGMA key`.
Future<void> _isolateSetup() async {
  _overrideSqlCipherOpen();
}

void _overrideSqlCipherOpen() {
  open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
}

/// Fails hard unless the loaded SQLite is SQLCipher. Plain SQLite accepts
/// `PRAGMA key` without error and writes cleartext.
void _assertSqlCipherIsActive(Database db) {
  final ResultSet result;
  try {
    result = db.select('PRAGMA cipher_version;');
  } catch (e) {
    throw DatabaseEncryptionException('could not query cipher_version', e);
  }

  final version =
      result.isEmpty ? null : result.first.columnAt(0)?.toString().trim();

  if (version == null || version.isEmpty) {
    throw DatabaseEncryptionException(
      'SQLCipher is not active — the database would be written in cleartext. '
      'Check that sqlcipher_flutter_libs is linked and sqlite3_flutter_libs is not.',
    );
  }
}

/// Reads the database key, creating one only when it is safe to do so.
///
/// A read failure is never treated as "no key"; generating a new key would
/// orphan the existing data.
Future<String> _readOrCreateKey({
  required bool databaseExists,
  required bool databaseIsPlaintext,
}) async {
  String? key;
  try {
    key = await _secureStorage.read(key: _dbKeyStorageKey);
  } catch (e) {
    throw DatabaseEncryptionException(
      'could not read the database key from secure storage',
      e,
    );
  }

  if (key != null && key.isNotEmpty) return key;

  // No key on file. Generating a fresh one is only safe when there is nothing
  // encrypted to orphan: either no database at all, or a legacy plaintext one
  // that we are about to encrypt with the new key.
  if (databaseExists && !databaseIsPlaintext) {
    throw DatabaseEncryptionException(
      'the database is encrypted but its key is missing from secure storage; '
      'refusing to re-key, which would permanently discard existing data',
    );
  }

  final random = Random.secure();
  final newKey = base64Encode(
    List<int>.generate(32, (_) => random.nextInt(256)),
  );

  try {
    await _secureStorage.write(key: _dbKeyStorageKey, value: newKey);
  } catch (e) {
    throw DatabaseEncryptionException(
      'could not persist the database key to secure storage',
      e,
    );
  }

  return newKey;
}

Future<bool> _isPlaintextDatabase(File file) async {
  final handle = await file.open();
  try {
    final header = await handle.read(_sqliteMagic.length);
    if (header.length < _sqliteMagic.length) return false; // empty/new file
    return latin1.decode(header) == _sqliteMagic;
  } finally {
    await handle.close();
  }
}

/// Encrypts a legacy plaintext database in place.
///
/// Exports into a temporary encrypted file, verifies that file opens and
/// matches the original, and only then swaps it in. The original is left
/// untouched if any step fails.
Future<void> _encryptPlaintextDatabase(File file, String key) async {
  final tempPath = '${file.path}$_tempSuffix';
  final temp = File(tempPath);
  if (temp.existsSync()) await temp.delete();

  int userVersion = 0;
  int schemaObjectCount = 0;
  Object? failure;

  final plaintext = sqlite3.open(file.path);
  try {
    // Fold any -wal content into the main file so the export sees every write.
    plaintext.execute('PRAGMA wal_checkpoint(TRUNCATE);');

    userVersion =
        plaintext.select('PRAGMA user_version;').first.columnAt(0)! as int;
    schemaObjectCount =
        plaintext
                .select('SELECT count(*) FROM sqlite_master;')
                .first
                .columnAt(0)!
            as int;

    plaintext.execute('ATTACH DATABASE ? AS encrypted KEY ?;', [tempPath, key]);
    plaintext.execute("SELECT sqlcipher_export('encrypted');");
    // sqlcipher_export copies schema and rows but NOT user_version — and that
    // is where drift records its schema version. Without this the migrated
    // database would look brand new and drift would re-run onCreate over it.
    plaintext.execute('PRAGMA encrypted.user_version = $userVersion;');
    plaintext.execute('DETACH DATABASE encrypted;');
  } catch (e) {
    failure = e;
  } finally {
    plaintext.dispose();
  }

  if (failure != null) {
    if (temp.existsSync()) await temp.delete();
    throw DatabaseEncryptionException(
      'could not encrypt the existing database',
      failure,
    );
  }

  await _verifyEncryptedCopy(
    temp,
    key,
    expectedUserVersion: userVersion,
    expectedSchemaObjectCount: schemaObjectCount,
  );

  // Swap. Keep the plaintext original until the encrypted file is in place, so
  // an interrupted swap is recoverable (see _recoverInterruptedMigration).
  final backup = File('${file.path}$_backupSuffix');
  await file.rename(backup.path);
  await temp.rename(file.path);

  // A -wal/-shm pair left over from the plaintext database would be paired with
  // the new encrypted file and corrupt reads.
  for (final suffix in const ['-wal', '-shm']) {
    final stale = File('${file.path}$suffix');
    if (stale.existsSync()) await stale.delete();
  }

  await backup.delete();
}

Future<void> _verifyEncryptedCopy(
  File temp,
  String key, {
  required int expectedUserVersion,
  required int expectedSchemaObjectCount,
}) async {
  Database? check;
  try {
    check = sqlite3.open(temp.path);
    check.execute('PRAGMA key = ${_quote(key)};');
    _assertSqlCipherIsActive(check);

    final objects =
        check.select('SELECT count(*) FROM sqlite_master;').first.columnAt(0)! as int;
    final version = check.select('PRAGMA user_version;').first.columnAt(0)! as int;

    if (objects != expectedSchemaObjectCount || version != expectedUserVersion) {
      throw DatabaseEncryptionException(
        'encrypted copy does not match the original '
        '(objects $objects/$expectedSchemaObjectCount, '
        'user_version $version/$expectedUserVersion)',
      );
    }
  } catch (e) {
    check?.dispose();
    check = null;
    if (temp.existsSync()) await temp.delete();
    if (e is DatabaseEncryptionException) rethrow;
    throw DatabaseEncryptionException('encrypted copy failed verification', e);
  } finally {
    check?.dispose();
  }
}

/// Repairs the two states a crash mid-swap can leave behind.
Future<void> _recoverInterruptedMigration(File file) async {
  final backup = File('${file.path}$_backupSuffix');
  final temp = File('${file.path}$_tempSuffix');

  if (!await file.exists() && await backup.exists()) {
    // Crashed between the two renames: the plaintext original is all we have.
    // Restore it and let this run encrypt it again from scratch.
    await backup.rename(file.path);
  } else if (await backup.exists()) {
    // Crashed after the swap but before cleanup: the encrypted file is already
    // in place, so the plaintext copy is now just a leak. Get rid of it.
    await backup.delete();
  }

  if (await temp.exists()) await temp.delete();
}

/// SQL string literal. The key is base64 so it cannot contain a quote, but
/// `PRAGMA key` takes no bind parameters, so escape defensively anyway.
String _quote(String value) => "'${value.replaceAll("'", "''")}'";
