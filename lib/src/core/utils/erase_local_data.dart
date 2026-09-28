import 'package:confessionapp/src/core/database/database_encryption.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
);

/// Erases every trace of local data and returns the app to a first-run state.
///
/// Uses no provider and never opens the database: it is the recovery path when
/// the database key is unrecoverable and both would throw.
///
/// Every step is best-effort, so a failing keystore cannot block the reset.
Future<void> eraseAllLocalData() async {
  try {
    await deleteDatabaseFiles();
  } catch (_) {
    // Nothing to delete, or the file is already gone.
  }

  try {
    // Only valid as a user-confirmed full erase; never use `deleteAll` to
    // recover from a read error, as it wipes the PIN and the database key.
    await _secureStorage.deleteAll();
  } catch (_) {
    // The keystore may be what is broken; carry on.
  }

  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  } catch (_) {
    // Nothing recoverable to do.
  }
}
