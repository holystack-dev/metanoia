import 'dart:convert';
import 'dart:math';

import 'package:confessionapp/src/features/authentication/domain/models/auth_settings.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository();
}

/// Repository for handling authentication data storage
class AuthRepository {
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // Secure storage keys
  static const _pinHashKey = 'pin_hash';
  static const _pinSaltKey = 'pin_salt';

  // SharedPreferences keys (non-sensitive settings)
  static const _biometricEnabledKey = 'biometric_enabled';
  static const _timeoutSecondsKey = 'lock_timeout_seconds';
  static const _failedAttemptsKey = 'auth_failed_attempts';
  static const _lockoutEndKey = 'auth_lockout_end';

  // Progressive lockout durations
  static const _lockoutDurations = [
    Duration(seconds: 30), // After 5 failed attempts
    Duration(minutes: 1), // After 6 failed attempts
    Duration(minutes: 5), // After 7 failed attempts
    Duration(minutes: 15), // After 8 failed attempts
    Duration(minutes: 30), // After 9+ failed attempts
  ];

  /// Check if PIN has been set up
  Future<bool> isPinSet() async {
    final hash = await _secureStorage.read(key: _pinHashKey);
    return hash != null && hash.isNotEmpty;
  }

  /// Save a new PIN (hashed with salt)
  Future<void> savePin(String pin) async {
    final salt = _generateSalt();
    final hash = _hashPin(pin, salt);
    await _secureStorage.write(key: _pinSaltKey, value: salt);
    await _secureStorage.write(key: _pinHashKey, value: hash);
    // Reset failed attempts on new PIN
    await resetFailedAttempts();
  }

  /// Verify PIN against stored hash using constant-time comparison
  Future<bool> verifyPin(String pin) async {
    final storedHash = await _secureStorage.read(key: _pinHashKey);
    final salt = await _secureStorage.read(key: _pinSaltKey);
    if (storedHash == null || salt == null) return false;

    final inputHash = _hashPin(pin, salt);
    return _constantTimeCompare(storedHash, inputHash);
  }

  /// Change PIN (requires current PIN verification)
  Future<bool> changePin(String currentPin, String newPin) async {
    final isValid = await verifyPin(currentPin);
    if (!isValid) return false;

    await savePin(newPin);
    return true;
  }

  /// Generate a cryptographically secure random salt
  String _generateSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64Encode(bytes);
  }

  /// Hash PIN with salt using multiple rounds of SHA-256 (key stretching)
  /// This makes brute-force attacks significantly slower
  String _hashPin(String pin, String salt) {
    List<int> bytes = utf8.encode(pin + salt);

    // Apply 100,000 rounds of hashing for key stretching
    // This makes brute-force attacks ~100,000x slower
    for (var i = 0; i < 100000; i++) {
      bytes = sha256.convert(bytes).bytes;
    }

    return base64Encode(bytes);
  }

  /// Constant-time comparison to prevent timing attacks
  bool _constantTimeCompare(String a, String b) {
    if (a.length != b.length) return false;

    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return result == 0;
  }

  /// Get authentication settings
  Future<AuthSettings> getAuthSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final biometricEnabled = prefs.getBool(_biometricEnabledKey) ?? false;
    final timeoutSeconds = prefs.getInt(_timeoutSecondsKey) ?? 15;

    return AuthSettings(
      biometricEnabled: biometricEnabled,
      backgroundTimeout: Duration(seconds: timeoutSeconds),
    );
  }

  /// Save authentication settings
  Future<void> saveAuthSettings(AuthSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, settings.biometricEnabled);
    await prefs.setInt(
      _timeoutSecondsKey,
      settings.backgroundTimeout.inSeconds,
    );
  }

  /// Set biometric enabled status
  Future<void> setBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, enabled);
  }

  /// Get biometric enabled status
  Future<bool> getBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricEnabledKey) ?? false;
  }

  /// Set background timeout
  Future<void> setBackgroundTimeout(Duration timeout) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_timeoutSecondsKey, timeout.inSeconds);
  }

  /// Get background timeout
  Future<Duration> getBackgroundTimeout() async {
    final prefs = await SharedPreferences.getInstance();
    final seconds = prefs.getInt(_timeoutSecondsKey) ?? 15;
    return Duration(seconds: seconds);
  }

  /// Increment and get failed attempt count
  Future<int> incrementFailedAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    final attempts = (prefs.getInt(_failedAttemptsKey) ?? 0) + 1;
    await prefs.setInt(_failedAttemptsKey, attempts);
    return attempts;
  }

  /// Get current failed attempt count
  Future<int> getFailedAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_failedAttemptsKey) ?? 0;
  }

  /// Reset failed attempts
  Future<void> resetFailedAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_failedAttemptsKey, 0);
    await prefs.remove(_lockoutEndKey);
  }

  /// Set lockout end time based on failed attempts
  Future<DateTime?> setLockoutFromAttempts(int attempts) async {
    if (attempts < 5) return null;

    final lockoutIndex = (attempts - 5).clamp(0, _lockoutDurations.length - 1);
    final lockoutDuration = _lockoutDurations[lockoutIndex];
    final lockoutEnd = DateTime.now().add(lockoutDuration);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lockoutEndKey, lockoutEnd.toIso8601String());

    return lockoutEnd;
  }

  /// Get lockout end time
  Future<DateTime?> getLockoutEnd() async {
    final prefs = await SharedPreferences.getInstance();
    final lockoutEndStr = prefs.getString(_lockoutEndKey);
    if (lockoutEndStr == null) return null;

    try {
      return DateTime.parse(lockoutEndStr);
    } catch (e) {
      return null;
    }
  }

  /// Check if lockout has expired
  Future<bool> isLockoutExpired() async {
    final lockoutEnd = await getLockoutEnd();
    if (lockoutEnd == null) return true;
    return DateTime.now().isAfter(lockoutEnd);
  }

  /// Clear lockout
  Future<void> clearLockout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lockoutEndKey);
  }

  /// Delete all authentication data (for testing or reset)
  Future<void> deleteAllAuthData() async {
    await _secureStorage.delete(key: _pinHashKey);
    await _secureStorage.delete(key: _pinSaltKey);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_biometricEnabledKey);
    await prefs.remove(_timeoutSecondsKey);
    await prefs.remove(_failedAttemptsKey);
    await prefs.remove(_lockoutEndKey);
  }

  /// Reset PIN and delete all user data (confessions, custom sins, penances)
  /// This is a destructive operation that cannot be undone
  /// Returns true if successful
  Future<bool> resetPinAndDeleteAllData() async {
    try {
      // Delete all authentication data
      await deleteAllAuthData();

      // Delete database encryption key (this makes the database unrecoverable)
      await _secureStorage.delete(key: 'db_key');

      return true;
    } catch (e) {
      return false;
    }
  }
}
