import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/features/authentication/domain/models/auth_settings.dart';
import 'package:confessionapp/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:confessionapp/src/features/authentication/presentation/widgets/lockout_timer_widget.dart';
import 'package:confessionapp/src/features/authentication/presentation/widgets/pin_dots_display.dart';
import 'package:confessionapp/src/features/authentication/presentation/widgets/pin_input_widget.dart';
import 'package:confessionapp/src/features/authentication/presentation/widgets/reset_pin_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Lock screen that requires PIN or biometric authentication
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  String _enteredPin = '';
  bool _hasError = false;
  bool _isVerifying = false;
  bool _hasAttemptedBiometric = false;

  @override
  void initState() {
    super.initState();
    // Schedule biometric check after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndTriggerBiometric();
    });
  }

  /// Check auth state and trigger biometric if conditions are met
  Future<void> _checkAndTriggerBiometric() async {
    if (_hasAttemptedBiometric || !mounted) return;

    final authState = ref.read(authControllerProvider);

    // If still loading, wait for it
    if (authState.isLoading) {
      // Wait a bit and try again
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        _checkAndTriggerBiometric();
      }
      return;
    }

    final state = authState.valueOrNull;
    if (state != null &&
        state.status == AuthStatus.locked &&
        state.biometricAvailable &&
        state.biometricEnabled) {
      _attemptBiometric();
    }
  }

  Future<void> _attemptBiometric() async {
    if (!mounted) return;

    // Mark as attempted for auto-trigger (so it doesn't auto-trigger again)
    _hasAttemptedBiometric = true;

    final success =
        await ref.read(authControllerProvider.notifier).authenticateWithBiometric();
    if (!success && mounted) {
      // Biometric failed or cancelled, user can use PIN
    }
  }

  void _onDigitPressed(String digit) {
    if (_enteredPin.length >= 6 || _isVerifying) return;

    setState(() {
      _enteredPin += digit;
      _hasError = false;
    });

    if (_enteredPin.length == 6) {
      _verifyPin();
    }
  }

  void _onBackspacePressed() {
    if (_enteredPin.isEmpty || _isVerifying) return;

    setState(() {
      _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      _hasError = false;
    });
  }

  Future<void> _verifyPin() async {
    setState(() => _isVerifying = true);

    final success =
        await ref.read(authControllerProvider.notifier).verifyPin(_enteredPin);

    if (!mounted) return;

    if (!success) {
      setState(() {
        _hasError = true;
        _enteredPin = '';
        _isVerifying = false;
      });
    }
    // If success, the auth state will update and this screen will be hidden
  }

  void _onLockoutExpired() {
    ref.read(authControllerProvider.notifier).checkLockoutExpired();
  }

  Future<void> _onForgotPinPressed() async {
    if (!mounted) return;

    final l10n = AppLocalizations.of(context)!;
    final authState = ref.read(authControllerProvider).valueOrNull;

    // Try biometric verification first if available and enabled
    bool biometricVerified = false;
    final canUseBiometric =
        (authState?.biometricAvailable ?? false) &&
        (authState?.biometricEnabled ?? false);

    if (canUseBiometric) {
      try {
        biometricVerified = await ref
            .read(authControllerProvider.notifier)
            .authenticateWithBiometricForReset(l10n.resetPinBiometricPrompt);
      } catch (_) {
        // Biometric failed, continue with timer
        biometricVerified = false;
      }
    }

    if (!mounted) return;

    // Show the reset dialog (with timer if biometric not verified)
    final confirmed = await showResetPinDialog(
      context,
      biometricVerified: biometricVerified,
    );
    if (!confirmed || !mounted) return;

    final success =
        await ref.read(authControllerProvider.notifier).resetPinAndDeleteAllData();

    if (!mounted) return;

    if (success) {
      // Show success message and restart app
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.resetPinSuccess),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
      // Restart the app by exiting (app will reopen fresh)
      await Future.delayed(const Duration(seconds: 2));
      SystemNavigator.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.resetPinError),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authControllerProvider);

    return authState.when(
      data: (state) => _buildContent(context, theme, state),
      loading: () => _buildLoading(theme),
      error: (_, __) => _buildContent(context, theme, null),
    );
  }

  Widget _buildLoading(ThemeData theme) {
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ThemeData theme, dynamic state) {
    final isLockedOut = state?.isLockedOut ?? false;
    final lockoutEndTime = state?.lockoutEndTime;
    final biometricAvailable = state?.biometricAvailable ?? false;
    final biometricEnabled = state?.biometricEnabled ?? false;
    final failedAttempts = state?.failedAttempts ?? 0;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      // App icon and title
                      _buildHeader(theme),
                      const SizedBox(height: 32),
                      // Lockout timer or PIN entry
                      if (isLockedOut && lockoutEndTime != null)
                        LockoutTimerWidget(
                          lockoutEndTime: lockoutEndTime,
                          onLockoutExpired: _onLockoutExpired,
                        ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9))
                      else ...[
                        // PIN dots
                        PinDotsDisplay(
                          pinLength: _enteredPin.length,
                          error: _hasError,
                        ),
                        const SizedBox(height: 16),
                        // Error message or attempts remaining
                        if (_hasError)
                          Text(
                            failedAttempts >= 3
                                ? 'Incorrect PIN (${5 - failedAttempts} attempts remaining)'
                                : 'Incorrect PIN',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ).animate().shake(hz: 3, duration: 300.ms)
                        else
                          const SizedBox(height: 20),
                        const SizedBox(height: 32),
                        // PIN keypad
                        PinInputWidget(
                          onDigitPressed: _onDigitPressed,
                          onBackspacePressed: _onBackspacePressed,
                          onBiometricPressed: _attemptBiometric,
                          showBiometric: biometricAvailable && biometricEnabled,
                          enabled: !_isVerifying,
                        ),
                        const SizedBox(height: 24),
                        // Forgot PIN button
                        TextButton(
                          onPressed: _onForgotPinPressed,
                          child: Text(
                            AppLocalizations.of(context)!.forgotPin,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_outline_rounded,
            size: 40,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Metanoia',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your PIN to unlock',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
