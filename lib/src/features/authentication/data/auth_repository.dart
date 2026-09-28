import 'dart:convert';
import 'dart:math';

import 'package:confessionapp/src/features/authentication/domain/models/auth_settings.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_repository.g.dart';

/// Key-stretching for the PIN: 100,000 rounds of SHA-256.
///
/// Top-level so it can run on a background isolate via `compute`.
String _hashPinSync(({String pin, String salt}) input) {
  List<int> bytes = utf8.encode(input.pin + input.salt);

  for (var i = 0; i < 100000; i++) {
    bytes = sha256.convert(bytes).bytes;
  }

  return base64Encode(bytes);
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository();
}

/// Reads the current time. Injectable so the progressive-lockout table can be
/// tested without a test that actually waits half an hour.
typedef Clock = DateTime Function();

DateTime _systemClock() => DateTime.now();

/// Repository for handling authentication data storage
class AuthRepository {
  AuthRepository({
    FlutterSecureStorage? secureStorage,
    Clock clock = _systemClock,
  }) : _secureStorage = secureStorage ?? _defaultSecureStorage,
       _now = clock;

  static const _defaultSecureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  final FlutterSecureStorage _secureStorage;
  final Clock _now;

  // Secure storage keys
  static const _pinHashKey = 'pin_hash';
  static const _pinSaltKey = 'pin_salt';

  // SharedPreferences keys (non-sensitive settings)
  static const _biometricEnabledKey = 'biometric_enabled';
  static const _timeoutSecondsKey = 'lock_timeout_seconds';

  // Brute-force state. Secure storage, not SharedPreferences — these are what
  // enforce the lockout, so they must not be resettable from plaintext prefs.
  static const _failedAttemptsKey = 'auth_failed_attempts';
  static const _lockoutEndKey = 'auth_lockout_end';
  static const _lockoutStartKey = 'auth_lockout_start';

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
    final hash = await _hashPin(pin, salt);
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

    final inputHash = await _hashPin(pin, salt);
    return _constantTimeCompare(storedHash, inputHash);
  }

  /// Change PIN (requires current PIN verification)
  ///
  /// Failed attempts count against the same progressive lockout as the lock
  /// screen, so this cannot serve as an unthrottled PIN-guessing oracle.
  Future<bool> changePin(String currentPin, String newPin) async {
    if (!await isLockoutExpired()) return false;

    if (!await verifyPin(currentPin)) {
      final attempts = await incrementFailedAttempts();
      await setLockoutFromAttempts(attempts);
      return false;
    }

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
  ///
  /// Runs on a background isolate: 100k rounds visibly freeze the UI on
  /// low-end devices.
  Future<String> _hashPin(String pin, String salt) =>
      compute(_hashPinSync, (pin: pin, salt: salt));

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
    final attempts = await getFailedAttempts() + 1;
    await _secureStorage.write(
      key: _failedAttemptsKey,
      value: attempts.toString(),
    );
    return attempts;
  }

  /// Get current failed attempt count
  ///
  /// Held in secure storage, not SharedPreferences: the counter enforces the
  /// lockout, and plaintext prefs are trivially reset on a rooted device.
  Future<int> getFailedAttempts() async {
    final stored = await _secureStorage.read(key: _failedAttemptsKey);
    if (stored != null) return int.tryParse(stored) ?? 0;

    // One-time migration of a legacy value from SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    final legacy = prefs.getInt(_failedAttemptsKey);
    if (legacy == null) return 0;

    await _secureStorage.write(
      key: _failedAttemptsKey,
      value: legacy.toString(),
    );
    await prefs.remove(_failedAttemptsKey);
    return legacy;
  }

  /// Reset failed attempts
  Future<void> resetFailedAttempts() async {
    await _secureStorage.write(key: _failedAttemptsKey, value: '0');
    await clearLockout();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_failedAttemptsKey);
    await prefs.remove(_lockoutEndKey);
  }

  /// Set lockout end time based on failed attempts
  Future<DateTime?> setLockoutFromAttempts(int attempts) async {
    if (attempts < 5) return null;

    final lockoutIndex = (attempts - 5).clamp(0, _lockoutDurations.length - 1);
    final lockoutDuration = _lockoutDurations[lockoutIndex];
    final now = _now();
    final lockoutEnd = now.add(lockoutDuration);

    // The start is recorded as well as the end, so a clock wound forward or
    // backward can be detected rather than simply believed. See [isLockoutExpired].
    await _secureStorage.write(
      key: _lockoutStartKey,
      value: now.toIso8601String(),
    );
    await _secureStorage.write(
      key: _lockoutEndKey,
      value: lockoutEnd.toIso8601String(),
    );

    return lockoutEnd;
  }

  /// Get lockout end time
  Future<DateTime?> getLockoutEnd() async => _readStoredTime(_lockoutEndKey);

  Future<DateTime?> _readStoredTime(String key) async {
    final stored = await _secureStorage.read(key: key);
    if (stored == null) return null;
    return DateTime.tryParse(stored);
  }

  /// Check if lockout has expired
  ///
  /// Cross-checked against the recorded start so changing the device clock
  /// cannot clear it: if "now" is before the lockout began, the clock has been
  /// moved and the lockout is treated as still running.
  Future<bool> isLockoutExpired() async {
    final lockoutEnd = await getLockoutEnd();
    if (lockoutEnd == null) return true;

    final now = _now();
    final lockoutStart = await _readStoredTime(_lockoutStartKey);

    if (lockoutStart != null && now.isBefore(lockoutStart)) {
      // Clock rolled back — do not trust it.
      return false;
    }

    return now.isAfter(lockoutEnd);
  }

  /// Clear lockout
  Future<void> clearLockout() async {
    await _secureStorage.delete(key: _lockoutEndKey);
    await _secureStorage.delete(key: _lockoutStartKey);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lockoutEndKey);
  }

  /// Delete all authentication data (for testing or reset)
  Future<void> deleteAllAuthData() async {
    await _secureStorage.delete(key: _pinHashKey);
    await _secureStorage.delete(key: _pinSaltKey);
    await _secureStorage.delete(key: _failedAttemptsKey);
    await _secureStorage.delete(key: _lockoutEndKey);
    await _secureStorage.delete(key: _lockoutStartKey);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_biometricEnabledKey);
    await prefs.remove(_timeoutSecondsKey);
    await prefs.remove(_failedAttemptsKey);
    await prefs.remove(_lockoutEndKey);
  }
}
