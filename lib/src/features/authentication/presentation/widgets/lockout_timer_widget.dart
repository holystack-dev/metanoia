import 'dart:async';

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
    _updateRemaining();
    _startTimer();
  }

  @override
  void didUpdateWidget(LockoutTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lockoutEndTime != widget.lockoutEndTime) {
      _updateRemaining();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemaining();
    });
  }

  void _updateRemaining() {
    final now = DateTime.now();
    final remaining = widget.lockoutEndTime.difference(now);

    if (remaining.isNegative || remaining == Duration.zero) {
      _timer?.cancel();
      widget.onLockoutExpired();
      return;
    }

    setState(() {
      _remaining = remaining;
    });
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    if (minutes > 0) {
      return '${minutes}m ${seconds.toString().padLeft(2, '0')}s';
    }
    return '${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
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
            'Too many failed attempts',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try again in',
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
