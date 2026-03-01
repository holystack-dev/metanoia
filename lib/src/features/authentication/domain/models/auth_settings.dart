/// Authentication settings model
class AuthSettings {
  final bool biometricEnabled;
  final Duration backgroundTimeout;

  const AuthSettings({
    this.biometricEnabled = false,
    this.backgroundTimeout = const Duration(seconds: 15),
  });

  AuthSettings copyWith({
    bool? biometricEnabled,
    Duration? backgroundTimeout,
  }) {
    return AuthSettings(
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      backgroundTimeout: backgroundTimeout ?? this.backgroundTimeout,
    );
  }
}

/// Authentication status
enum AuthStatus {
  /// First launch, no PIN set - PIN setup deferred until first sensitive action
  uninitialized,

  /// PIN setup has been deferred - user can browse, but sensitive areas require PIN setup
  pinSetupDeferred,

  /// App is locked, needs authentication
  locked,

  /// App is unlocked
  unlocked,

  /// Too many failed attempts, temporarily locked out
  lockedOut,
}

/// Authentication state
class AuthState {
  final AuthStatus status;
  final bool biometricAvailable;
  final bool biometricEnabled;
  final int failedAttempts;
  final DateTime? lockoutEndTime;
  final Duration backgroundTimeout;

  const AuthState({
    required this.status,
    this.biometricAvailable = false,
    this.biometricEnabled = false,
    this.failedAttempts = 0,
    this.lockoutEndTime,
    this.backgroundTimeout = const Duration(seconds: 15),
  });

  AuthState copyWith({
    AuthStatus? status,
    bool? biometricAvailable,
    bool? biometricEnabled,
    int? failedAttempts,
    DateTime? lockoutEndTime,
    Duration? backgroundTimeout,
    bool clearLockoutEndTime = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      biometricAvailable: biometricAvailable ?? this.biometricAvailable,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      lockoutEndTime:
          clearLockoutEndTime ? null : (lockoutEndTime ?? this.lockoutEndTime),
      backgroundTimeout: backgroundTimeout ?? this.backgroundTimeout,
    );
  }

  /// Check if currently in lockout period
  bool get isLockedOut {
    if (status != AuthStatus.lockedOut || lockoutEndTime == null) return false;
    return DateTime.now().isBefore(lockoutEndTime!);
  }

  /// Remaining lockout duration
  Duration get remainingLockout {
    if (lockoutEndTime == null) return Duration.zero;
    final remaining = lockoutEndTime!.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }
}
