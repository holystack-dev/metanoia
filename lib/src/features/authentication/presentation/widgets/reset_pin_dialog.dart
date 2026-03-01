import 'dart:async';

import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Dialog for resetting PIN with data deletion warning
/// Requires either biometric auth or a wait timer for security
class ResetPinDialog extends StatefulWidget {
  const ResetPinDialog({super.key, required this.biometricVerified});

  /// Whether biometric was already verified before showing dialog
  final bool biometricVerified;

  @override
  State<ResetPinDialog> createState() => _ResetPinDialogState();
}

class _ResetPinDialogState extends State<ResetPinDialog> {
  final _textController = TextEditingController();
  bool _isDeleteTyped = false;

  // Wait timer for non-biometric protection
  static const _waitDuration = 30; // seconds
  int _remainingSeconds = _waitDuration;
  Timer? _timer;
  bool _timerCompleted = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_checkDeleteText);

    // If biometric was verified, skip the timer
    if (widget.biometricVerified) {
      _timerCompleted = true;
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
        if (_remainingSeconds <= 0) {
          _timerCompleted = true;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _textController.removeListener(_checkDeleteText);
    _textController.dispose();
    super.dispose();
  }

  void _checkDeleteText() {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;
    final isDelete =
        _textController.text.toUpperCase() == l10n.deleteConfirmationText;
    if (isDelete != _isDeleteTyped) {
      setState(() {
        _isDeleteTyped = isDelete;
      });
    }
  }

  bool get _canReset => _isDeleteTyped && _timerCompleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: theme.colorScheme.error,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              l10n.resetPinTitle,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontFamily: AppTheme.fontFamilyEBGaramond,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.error.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.delete_forever_rounded,
                    color: theme.colorScheme.error,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.resetPinWarning,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppTheme.fontFamilyLato,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Description
            Text(
              l10n.resetPinDescription,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.6,
                fontFamily: AppTheme.fontFamilyLato,
              ),
            ),
            const SizedBox(height: 24),
            // Confirmation text field
            Text(
              l10n.resetPinConfirmation,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontFamily: AppTheme.fontFamilyLato,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _textController,
              autofocus: true,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: l10n.deleteConfirmationText,
                hintStyle: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.5,
                  ),
                  fontFamily: AppTheme.fontFamilyLato,
                ),
                filled: true,
                fillColor:
                    isDark
                        ? theme.colorScheme.surfaceContainerHighest
                        : theme.colorScheme.surfaceContainerLow,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: theme.colorScheme.error,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontFamily: AppTheme.fontFamilyLato,
              ),
            ),
            // Timer indicator (only shown if biometric not verified)
            if (!_timerCompleted) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        value:
                            (_waitDuration - _remainingSeconds) / _waitDuration,
                        strokeWidth: 2,
                        color: theme.colorScheme.error,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      l10n.resetPinWaitTimer(_remainingSeconds),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontFamily: AppTheme.fontFamilyLato,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            l10n.cancel,
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontFamily: AppTheme.fontFamilyLato,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        FilledButton(
          onPressed: _canReset ? () => Navigator.of(context).pop(true) : null,
          style: FilledButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBackgroundColor: theme.colorScheme.onSurface.withValues(
              alpha: 0.12,
            ),
            disabledForegroundColor: theme.colorScheme.onSurface.withValues(
              alpha: 0.38,
            ),
          ),
          child: Text(
            _timerCompleted
                ? l10n.resetPinButton
                : '${l10n.resetPinButton} ($_remainingSeconds)',
            style: const TextStyle(
              fontFamily: AppTheme.fontFamilyLato,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
    );
  }
}

/// Shows the reset PIN confirmation dialog
/// Returns true if user confirmed the reset, false otherwise
Future<bool> showResetPinDialog(
  BuildContext context, {
  required bool biometricVerified,
}) async {
  final theme = Theme.of(context);

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder:
        (dialogContext) => Theme(
          data: theme,
          child: ResetPinDialog(biometricVerified: biometricVerified),
        ),
  );
  return result ?? false;
}
