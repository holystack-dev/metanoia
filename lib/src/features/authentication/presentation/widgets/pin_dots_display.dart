import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Widget to display PIN entry progress as dots
class PinDotsDisplay extends StatelessWidget {
  const PinDotsDisplay({
    super.key,
    required this.pinLength,
    this.maxLength = 6,
    this.dotSize = 16.0,
    this.spacing = 16.0,
    this.error = false,
  });

  final int pinLength;
  final int maxLength;
  final double dotSize;
  final double spacing;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxLength, (index) {
        final isFilled = index < pinLength;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled
                ? (error ? theme.colorScheme.error : theme.colorScheme.primary)
                : theme.colorScheme.surfaceContainerHighest,
            border: Border.all(
              color: error
                  ? theme.colorScheme.error
                  : (isFilled
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outline.withValues(alpha: 0.3)),
              width: 2,
            ),
          ),
        )
            .animate(target: isFilled ? 1 : 0)
            .scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1.0, 1.0),
              duration: 150.ms,
            )
            .then()
            .animate(target: error ? 1 : 0)
            .shake(hz: 4, duration: 300.ms);
      }),
    );
  }
}
