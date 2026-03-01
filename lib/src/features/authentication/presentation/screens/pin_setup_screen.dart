import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:confessionapp/src/features/authentication/presentation/widgets/pin_dots_display.dart';
import 'package:confessionapp/src/features/authentication/presentation/widgets/pin_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen for initial PIN setup (enter + confirm)
class PinSetupScreen extends ConsumerStatefulWidget {
  const PinSetupScreen({super.key, this.redirectTo});

  /// The route to navigate to after PIN setup is complete
  final String? redirectTo;

  @override
  ConsumerState<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends ConsumerState<PinSetupScreen> {
  String _firstPin = '';
  String _confirmPin = '';
  bool _isConfirming = false;
  bool _hasError = false;
  bool _isSaving = false;

  void _onDigitPressed(String digit) {
    if (_isSaving) return;

    setState(() {
      _hasError = false;
      if (_isConfirming) {
        if (_confirmPin.length < 6) {
          _confirmPin += digit;
        }
        if (_confirmPin.length == 6) {
          _verifyAndSave();
        }
      } else {
        if (_firstPin.length < 6) {
          _firstPin += digit;
        }
        if (_firstPin.length == 6) {
          // Move to confirm step
          Future.delayed(150.ms, () {
            if (mounted) {
              setState(() => _isConfirming = true);
            }
          });
        }
      }
    });
  }

  void _onBackspacePressed() {
    if (_isSaving) return;

    setState(() {
      _hasError = false;
      if (_isConfirming) {
        if (_confirmPin.isNotEmpty) {
          _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
        } else {
          // Go back to first PIN entry
          _isConfirming = false;
          _firstPin = '';
        }
      } else {
        if (_firstPin.isNotEmpty) {
          _firstPin = _firstPin.substring(0, _firstPin.length - 1);
        }
      }
    });
  }

  Future<void> _verifyAndSave() async {
    if (_firstPin != _confirmPin) {
      setState(() {
        _hasError = true;
        _confirmPin = '';
      });
      return;
    }

    setState(() => _isSaving = true);

    await ref.read(authControllerProvider.notifier).setupPin(_firstPin);

    if (mounted) {
      // Show biometric enrollment dialog if available
      final authState = ref.read(authControllerProvider).valueOrNull;
      if (authState?.biometricAvailable == true) {
        final enableBiometric = await _showBiometricDialog();
        if (enableBiometric) {
          await ref.read(authControllerProvider.notifier).setBiometricEnabled(true);
        }
      }

      // Navigate to the intended destination or home
      if (mounted) {
        final destination = widget.redirectTo ?? '/';
        context.go(destination);
      }
    }
  }

  Future<bool> _showBiometricDialog() async {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            icon: Icon(
              Icons.fingerprint_rounded,
              size: 48,
              color: theme.colorScheme.primary,
            ),
            title: Text(l10n.enableBiometricUnlock),
            content: Text(
              '${l10n.unlockWithFingerprintOrFace}\n\n${l10n.biometricAccessWarning}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l10n.notNow),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(l10n.enable),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentPin = _isConfirming ? _confirmPin : _firstPin;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Set Up PIN',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(),
              // Instructions
              _buildInstructions(theme),
              const Spacer(),
              // PIN dots
              PinDotsDisplay(
                pinLength: currentPin.length,
                error: _hasError,
              ),
              const SizedBox(height: 16),
              // Error message
              if (_hasError)
                Text(
                  'PINs don\'t match. Try again.',
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
                showBiometric: false,
                enabled: !_isSaving,
              ),
              const Spacer(),
              // Progress indicator
              _buildProgressIndicator(theme),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructions(ThemeData theme) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            _isConfirming ? Icons.check_circle_outline_rounded : Icons.pin_outlined,
            size: 36,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 24),
        AnimatedSwitcher(
          duration: 200.ms,
          child: Text(
            _isConfirming ? 'Confirm your PIN' : 'Create a 6-digit PIN',
            key: ValueKey(_isConfirming),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _isConfirming
              ? 'Enter the same PIN again to confirm'
              : 'This PIN will be used to protect your data',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProgressDot(theme, true),
        const SizedBox(width: 8),
        Container(
          width: 24,
          height: 2,
          color: _isConfirming
              ? theme.colorScheme.primary
              : theme.colorScheme.outlineVariant,
        ),
        const SizedBox(width: 8),
        _buildProgressDot(theme, _isConfirming),
      ],
    );
  }

  Widget _buildProgressDot(ThemeData theme, bool isActive) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.outlineVariant,
      ),
    );
  }
}
