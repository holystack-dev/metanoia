import 'dart:async';

import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:flutter/material.dart';

/// Widget that displays a countdown timer during lockout periods
class LockoutTimerWidget extends StatefulWidget {
  const LockoutTimerWidget({
    super.key,
    required this.lockoutEndTime,
    required this.onLockoutExpired,
  });

  final DateTime lockoutEndTime;
  final VoidCallback onLockoutExpired;

  @override
  State<LockoutTimerWidget> createState() => _LockoutTimerWidgetState();
}

class _LockoutTimerWidgetState extends State<LockoutTimerWidget> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _restart();
  }

  @override
  void didUpdateWidget(LockoutTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lockoutEndTime != widget.lockoutEndTime) {
      // A new lockout needs a fresh timer; the old one is cancelled on expiry.
      _restart();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _restart() {
    _timer?.cancel();
    _remaining = widget.lockoutEndTime.difference(DateTime.now());
    if (_expireIfElapsed()) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (!mounted) return;
    setState(() {
      _remaining = widget.lockoutEndTime.difference(DateTime.now());
    });
    _expireIfElapsed();
  }

  /// Reports an elapsed lockout, and returns whether it had elapsed.
  bool _expireIfElapsed() {
    if (_remaining > Duration.zero) return false;

    _timer?.cancel();
    _remaining = Duration.zero;

    // Deferred: reached from initState and didUpdateWidget, and the callback
    // writes to a provider, which is not allowed during build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onLockoutExpired();
    });
    return true;
  }

  /// Digits-only countdown (m:ss) so it reads the same in every language.
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_clock_rounded,
            size: 48,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.tooManyAttempts,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.tryAgainInLabel,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onErrorContainer,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _formatDuration(_remaining),
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.bold,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
