import 'package:flutter/material.dart';

/// A widget that animates number changes with a smooth counting effect.
class AnimatedCount extends StatelessWidget {
  const AnimatedCount({
    super.key,
    required this.count,
    required this.textStyle,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOutCubic,
    this.prefix = '',
    this.suffix = '',
  });

  final int count;
  final TextStyle? textStyle;
  final Duration duration;
  final Curve curve;
  final String prefix;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: count, end: count),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Text(
          '$prefix$value$suffix',
          style: textStyle,
        );
      },
    );
  }
}

/// A widget that animates with scale and fade when the count changes.
class AnimatedCountBadge extends StatefulWidget {
  const AnimatedCountBadge({
    super.key,
    required this.count,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
  });

  final int count;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;

  @override
  State<AnimatedCountBadge> createState() => _AnimatedCountBadgeState();
}

class _AnimatedCountBadgeState extends State<AnimatedCountBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int _previousCount = 0;

  @override
  void initState() {
    super.initState();
    _previousCount = widget.count;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.15)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.15, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  void didUpdateWidget(AnimatedCountBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.count != widget.count) {
      _previousCount = oldWidget.count;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TweenAnimationBuilder<int>(
          tween: IntTween(begin: _previousCount, end: widget.count),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Text(
              widget.label.replaceAll(
                RegExp(r'\d+'),
                value.toString(),
              ),
              style: widget.textStyle ??
                  theme.textTheme.labelLarge?.copyWith(
                    color: widget.textColor ??
                        theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
            );
          },
        ),
      ),
    );
  }
}
