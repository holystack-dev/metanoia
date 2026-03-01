import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';

/// Numeric keypad widget for PIN entry
class PinInputWidget extends StatelessWidget {
  const PinInputWidget({
    super.key,
    required this.onDigitPressed,
    required this.onBackspacePressed,
    this.onBiometricPressed,
    this.showBiometric = false,
    this.enabled = true,
  });

  final ValueChanged<String> onDigitPressed;
  final VoidCallback onBackspacePressed;
  final VoidCallback? onBiometricPressed;
  final bool showBiometric;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Row 1: 1, 2, 3
        _buildRow(context, ['1', '2', '3']),
        const SizedBox(height: 16),
        // Row 2: 4, 5, 6
        _buildRow(context, ['4', '5', '6']),
        const SizedBox(height: 16),
        // Row 3: 7, 8, 9
        _buildRow(context, ['7', '8', '9']),
        const SizedBox(height: 16),
        // Row 4: Biometric/Empty, 0, Backspace
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Biometric or empty space
            if (showBiometric)
              _KeypadButton(
                onPressed: enabled ? onBiometricPressed : null,
                enabled: enabled,
                child: Icon(
                  Icons.fingerprint_rounded,
                  size: 32,
                  color: enabled
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              )
            else
              const SizedBox(width: 80, height: 80),
            // 0
            _KeypadButton(
              onPressed: enabled ? () => onDigitPressed('0') : null,
              enabled: enabled,
              child: Text(
                '0',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: enabled
                      ? theme.colorScheme.onSurface
                      : theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ),
            // Backspace
            _KeypadButton(
              onPressed: enabled ? onBackspacePressed : null,
              enabled: enabled,
              child: Icon(
                Icons.backspace_outlined,
                size: 28,
                color: enabled
                    ? theme.colorScheme.onSurfaceVariant
                    : theme.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context, List<String> digits) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((digit) {
        return _KeypadButton(
          onPressed: enabled ? () => onDigitPressed(digit) : null,
          enabled: enabled,
          child: Text(
            digit,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: enabled
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  const _KeypadButton({
    required this.child,
    required this.onPressed,
    this.enabled = true,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 80,
      height: 80,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed != null
              ? () {
                  HapticUtils.lightImpact();
                  onPressed!();
                }
              : null,
          borderRadius: BorderRadius.circular(40),
          splashColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          highlightColor: theme.colorScheme.primary.withValues(alpha: 0.05),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: enabled
                  ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                  : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
