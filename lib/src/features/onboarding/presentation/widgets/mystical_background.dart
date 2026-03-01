import 'package:confessionapp/src/features/onboarding/presentation/widgets/flowing_lines_painter.dart';
import 'package:confessionapp/src/features/onboarding/presentation/widgets/starfield_painter.dart';
import 'package:flutter/material.dart';

/// A reusable mystical background with flowing lines, stars, and optional moon
/// Used across all onboarding screens for visual consistency
class MysticalBackground extends StatefulWidget {
  final Widget child;
  final bool showStars;
  final double starDensity;

  const MysticalBackground({
    super.key,
    required this.child,
    this.showStars = true,
    this.starDensity = 1.0,
  });

  @override
  State<MysticalBackground> createState() => _MysticalBackgroundState();
}

class _MysticalBackgroundState extends State<MysticalBackground>
    with TickerProviderStateMixin {
  late AnimationController _flowingLinesController;
  late AnimationController _starsController;
  late List<Star> _stars;

  @override
  void initState() {
    super.initState();

    // Slower animations = fewer repaints = better performance
    _flowingLinesController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _starsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _stars = generateStars((15 * widget.starDensity).round());
  }

  @override
  void dispose() {
    _flowingLinesController.dispose();
    _starsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    // Use scaffoldBackgroundColor which is configured in app_theme.dart
    // Light: _backgroundLight = Color(0xFFF8F6F3)
    // Dark: _backgroundDark = Color(0xFF121019)
    final backgroundColor = theme.scaffoldBackgroundColor;
    // Use primaryContainer for gradient top
    // Light: primaryContainer = Color(0xFFE5DBEF)
    // Dark: primaryContainer = _accentPurpleDark = Color(0xFF5B3A7C)
    final gradientTop =
        isDark
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.primaryContainer.withValues(alpha: 0.6);
    final lineColor = theme.colorScheme.primary.withValues(
      alpha: isDark ? 0.35 : 0.25,
    );
    final starColor = theme.colorScheme.secondary;

    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gradientTop, backgroundColor, backgroundColor],
            stops: const [0.0, 0.35, 1.0],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Flowing decorative lines
            Positioned.fill(
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _flowingLinesController,
                  builder:
                      (context, _) => CustomPaint(
                        size: Size.infinite,
                        painter: FlowingLinesPainter(
                          lineColor: lineColor,
                          animationValue: _flowingLinesController.value,
                        ),
                      ),
                ),
              ),
            ),

            // Starfield
            if (widget.showStars)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: size.height * 0.5,
                child: RepaintBoundary(
                  child: AnimatedBuilder(
                    animation: _starsController,
                    builder:
                        (context, _) => CustomPaint(
                          size: Size.infinite,
                          painter: StarfieldPainter(
                            starColor: starColor,
                            stars: _stars,
                            animationValue: _starsController.value,
                          ),
                        ),
                  ),
                ),
              ),

            // Main content
            Positioned.fill(
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
