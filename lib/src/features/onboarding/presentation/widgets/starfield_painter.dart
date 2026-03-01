import 'dart:math';
import 'package:flutter/material.dart';

/// Represents a single star in the starfield
class Star {
  final Offset position;
  final double size;
  final double baseOpacity;
  final double twinklePhase;

  const Star({
    required this.position,
    required this.size,
    required this.baseOpacity,
    required this.twinklePhase,
  });
}

/// Custom painter for drawing a twinkling starfield
/// Creates a celestial atmosphere for the spiritual journey theme
/// Optimized for performance on all devices
class StarfieldPainter extends CustomPainter {
  final Color starColor;
  final List<Star> stars;
  final double animationValue;

  StarfieldPainter({
    required this.starColor,
    required this.stars,
    this.animationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Skip painting if size is too small
    if (size.width < 10 || size.height < 10) return;

    for (final star in stars) {
      // Calculate twinkling opacity using sine wave
      final twinkle = sin((animationValue + star.twinklePhase) * 2 * pi);
      final opacity = star.baseOpacity * (0.5 + 0.5 * ((twinkle + 1) / 2));

      final starPosition = Offset(
        star.position.dx * size.width,
        star.position.dy * size.height,
      );

      // Simple star with subtle glow (no blur filter)
      // Outer soft circle
      canvas.drawCircle(
        starPosition,
        star.size * 2,
        Paint()..color = starColor.withValues(alpha: opacity * 0.15),
      );

      // Star center
      canvas.drawCircle(
        starPosition,
        star.size * 0.8,
        Paint()..color = starColor.withValues(alpha: opacity.clamp(0.3, 1.0)),
      );
    }
  }

  @override
  bool shouldRepaint(StarfieldPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.starColor != starColor;
  }
}

/// Generate a list of stars with random positions and properties
List<Star> generateStars(int count, {int? seed}) {
  final random = Random(seed ?? 42);
  return List.generate(
    count,
    (i) => Star(
      position: Offset(
        0.05 + random.nextDouble() * 0.9, // 5-95% horizontal
        0.05 + random.nextDouble() * 0.5, // Top 55% only
      ),
      size: 1.0 + random.nextDouble() * 2.0,
      baseOpacity: 0.5 + random.nextDouble() * 0.4,
      twinklePhase: random.nextDouble(),
    ),
  );
}
