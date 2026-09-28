import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_encryption.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/features/authentication/data/auth_repository.dart';
import 'package:confessionapp/src/features/authentication/domain/models/auth_settings.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  final LocalAuthentication _localAuth = LocalAuthentication();
  DateTime? _lastPausedTime;

  /// True while the system biometric prompt is on screen. See
  /// [onAppLifecycleChange].
  bool _biometricPromptInFlight = false;

  @override
  Future<AuthState> build() async {
    final repo = ref.watch(authRepositoryProvider);
    final isPinSet = await repo.isPinSet();

    if (!isPinSet) {
      // PIN not set - use deferred state so user can browse home first
      return const AuthState(status: AuthStatus.pinSetupDeferred);
    }

    // Check if in lockout
    final lockoutEnd = await repo.getLockoutEnd();
    final failedAttempts = await repo.getFailedAttempts();

    if (lockoutEnd != null && DateTime.now().isBefore(lockoutEnd)) {
      return AuthState(
        status: AuthStatus.lockedOut,
        biometricAvailable: await _checkBiometricAvailability(),
        biometricEnabled: await repo.getBiometricEnabled(),
        failedAttempts: failedAttempts,
        lockoutEndTime: lockoutEnd,
        backgroundTimeout: await repo.getBackgroundTimeout(),
      );
    }

    // Normal locked state
    return AuthState(
      status: AuthStatus.locked,
      biometricAvailable: await _checkBiometricAvailability(),
      biometricEnabled: await repo.getBiometricEnabled(),
      failedAttempts: failedAttempts,
      backgroundTimeout: await repo.getBackgroundTimeout(),
    );
  }

  /// Check if biometric authentication is available on this device
  Future<bool> _checkBiometricAvailability() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      if (!canCheck || !isDeviceSupported) return false;

      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      return availableBiometrics.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Set up a new PIN
  Future<void> setupPin(String pin) async {
    final repo = ref.read(authRepositoryProvider);
    await repo.savePin(pin);

    state = AsyncValue.data(
      AuthState(
        status: AuthStatus.unlocked,
        biometricAvailable: await _checkBiometricAvailability(),
        biometricEnabled: false,
        backgroundTimeout: await repo.getBackgroundTimeout(),
      ),
    );
  }

  /// Verify PIN and unlock if correct
  Future<bool> verifyPin(String pin) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return false;

    // Check if in lockout
    if (currentState.status == AuthStatus.lockedOut) {
      if (currentState.isLockedOut) return false;
      // Lockout expired, reset to locked
      await _resetFromLockout();
    }

    final repo = ref.read(authRepositoryProvider);
    final isValid = await repo.verifyPin(pin);

    if (isValid) {
      await repo.resetFailedAttempts();
      state = AsyncValue.data(
        currentState.copyWith(
          status: AuthStatus.unlocked,
          failedAttempts: 0,
          clearLockoutEndTime: true,
        ),
      );
      return true;
    } else {
      await _recordFailedAttempt();
      return false;
    }
  }

  /// Authenticate using biometrics.
  ///
  /// [localizedReason] is the message shown in the system biometric prompt; it
  /// is passed in from the UI, which is where the localizations live.
  Future<bool> authenticateWithBiometric(String localizedReason) async {
    final currentState = state.valueOrNull;
    if (currentState == null ||
        !currentState.biometricAvailable ||
        !currentState.biometricEnabled) {
      return false;
    }

    try {
      final authenticated = await _duringBiometricPrompt(
        () => _localAuth.authenticate(
          localizedReason: localizedReason,
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        ),
      );

      if (authenticated) {
        final repo = ref.read(authRepositoryProvider);
        await repo.resetFailedAttempts();
        state = AsyncValue.data(
          currentState.copyWith(
            status: AuthStatus.unlocked,
            failedAttempts: 0,
            clearLockoutEndTime: true,
          ),
        );
        return true;
      }
    } on PlatformException catch (e) {
      // Handle specific biometric errors
      if (e.code == 'NotAvailable' || e.code == 'NotEnrolled') {
        // Biometric not available, disable it
        await setBiometricEnabled(false);
      }
    }

    return false;
  }

  /// Record a failed authentication attempt
  Future<void> _recordFailedAttempt() async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final repo = ref.read(authRepositoryProvider);
    final attempts = await repo.incrementFailedAttempts();

    if (attempts >= 5) {
      final lockoutEnd = await repo.setLockoutFromAttempts(attempts);
      state = AsyncValue.data(
        currentState.copyWith(
          status: AuthStatus.lockedOut,
          failedAttempts: attempts,
          lockoutEndTime: lockoutEnd,
        ),
      );
    } else {
      state = AsyncValue.data(
        currentState.copyWith(failedAttempts: attempts),
      );
    }
  }

  /// Reset from lockout state
  Future<void> _resetFromLockout() async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final repo = ref.read(authRepositoryProvider);
    await repo.clearLockout();
    state = AsyncValue.data(
      currentState.copyWith(
        status: AuthStatus.locked,
        clearLockoutEndTime: true,
      ),
    );
  }

  /// Check and reset lockout if expired
  Future<void> checkLockoutExpired() async {
    final currentState = state.valueOrNull;
    if (currentState?.status != AuthStatus.lockedOut) return;

    final repo = ref.read(authRepositoryProvider);
    if (await repo.isLockoutExpired()) {
      await _resetFromLockout();
    }
  }

  /// Lock the app
  void lock() {
    final currentState = state.valueOrNull;
    if (currentState == null ||
        currentState.status == AuthStatus.uninitialized ||
        currentState.status == AuthStatus.pinSetupDeferred) {
      return;
    }

    state = AsyncValue.data(
      currentState.copyWith(status: AuthStatus.locked),
    );
  }

  /// Unlock the app (called after successful authentication)
  void unlock() {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    state = AsyncValue.data(
      currentState.copyWith(status: AuthStatus.unlocked),
    );
  }

  /// Handle app lifecycle changes
  void onAppLifecycleChange(AuthAppLifecycleState lifecycleState) {
    // The system biometric prompt fires `inactive`. Without this guard it
    // starts the background-lock timer, and a Face ID slower than the timeout
    // re-locks the app as soon as it unlocks.
    if (_biometricPromptInFlight) return;

    final currentState = state.valueOrNull;
    if (currentState == null ||
        currentState.status == AuthStatus.uninitialized ||
        currentState.status == AuthStatus.pinSetupDeferred) {
      return;
    }

    if (lifecycleState == AuthAppLifecycleState.paused ||
        lifecycleState == AuthAppLifecycleState.inactive) {
      _lastPausedTime = DateTime.now();
    } else if (lifecycleState == AuthAppLifecycleState.resumed) {
      _checkAndLockIfNeeded();
    }
  }

  /// Runs [action] with the lifecycle lock timer suspended.
  Future<T> _duringBiometricPrompt<T>(Future<T> Function() action) async {
    _biometricPromptInFlight = true;
    try {
      return await action();
    } finally {
      _biometricPromptInFlight = false;
      // The prompt's own inactive/resumed cycle must not count as time spent
      // in the background.
      _lastPausedTime = null;
    }
  }

  /// Check if app should be locked based on background time
  void _checkAndLockIfNeeded() {
    if (_lastPausedTime == null) return;

    final currentState = state.valueOrNull;
    if (currentState == null ||
        currentState.status != AuthStatus.unlocked) {
      _lastPausedTime = null;
      return;
    }

    final elapsed = DateTime.now().difference(_lastPausedTime!);
    if (elapsed >= currentState.backgroundTimeout) {
      lock();
    }
    _lastPausedTime = null;
  }

  /// Enable or disable biometric authentication
  Future<void> setBiometricEnabled(bool enabled) async {
    final repo = ref.read(authRepositoryProvider);
    await repo.setBiometricEnabled(enabled);

    final currentState = state.valueOrNull;
    if (currentState != null) {
      state = AsyncValue.data(
        currentState.copyWith(biometricEnabled: enabled),
      );
    }
  }

  /// Set background timeout duration
  Future<void> setBackgroundTimeout(Duration timeout) async {
    final repo = ref.read(authRepositoryProvider);
    await repo.setBackgroundTimeout(timeout);

    final currentState = state.valueOrNull;
    if (currentState != null) {
      state = AsyncValue.data(
        currentState.copyWith(backgroundTimeout: timeout),
      );
    }
  }

  /// Change PIN
  Future<bool> changePin(String currentPin, String newPin) async {
    final repo = ref.read(authRepositoryProvider);
    return repo.changePin(currentPin, newPin);
  }

  /// Check if PIN setup is required (deferred state)
  bool get isPinSetupRequired {
    final currentState = state.valueOrNull;
    return currentState?.status == AuthStatus.pinSetupDeferred;
  }

  /// Reset the PIN and delete all user data (confessions, custom sins,
  /// penances). Destructive and unrecoverable.
  ///
  /// The caller is expected to restart the app afterwards (see [AppRoot.restart])
  /// so that no provider keeps serving rows cached from the deleted database.
  Future<bool> resetPinAndDeleteAllData() async {
    try {
      // Close the database before its files go away; a live connection would
      // otherwise write its cache back out and recreate them.
      await ref.read(appDatabaseProvider).close();

      // Destroy the data itself, not just the auth keys.
      await deleteDatabaseFiles();
      await deleteDatabaseKey();

      await ref.read(authRepositoryProvider).deleteAllAuthData();

      // A stale content version would stop the fresh database from being
      // seeded on the next open.
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppDatabase.contentVersionKey);

      state = const AsyncValue.data(
        AuthState(status: AuthStatus.uninitialized),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Authenticate using biometrics for PIN reset verification
  /// This doesn't change app state, just verifies identity
  Future<bool> authenticateWithBiometricForReset(String reason) async {
    final currentState = state.valueOrNull;
    if (currentState == null || !currentState.biometricAvailable) {
      return false;
    }

    try {
      // Verify biometrics enrollment
      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        return false;
      }

      return await _duringBiometricPrompt(
        () => _localAuth.authenticate(
          localizedReason: reason,
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false, // Allow device credentials as fallback
          ),
        ),
      );
    } on PlatformException {
      return false;
    } catch (e) {
      return false;
    }
  }
}

/// App lifecycle state (named to avoid clashing with Flutter's).
enum AuthAppLifecycleState {
  resumed,
  inactive,
  paused,
  detached,
  hidden,
}
