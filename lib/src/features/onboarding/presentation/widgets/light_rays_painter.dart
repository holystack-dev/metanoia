import 'dart:math';
import 'package:flutter/material.dart';

/// Custom painter for drawing divine light rays emanating from the archway
/// Symbolizes grace and divine light streaming through the sacred threshold
class LightRaysPainter extends CustomPainter {
  final Color rayColor;
  final double intensity;
  final Offset sourcePoint;

  LightRaysPainter({
    required this.rayColor,
    this.intensity = 1.0,
    required this.sourcePoint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Skip painting if size is too small
    if (size.width < 10 || size.height < 10) return;

    const rayCount = 9;
    const spreadAngle = pi * 0.5; // 90 degrees spread
    const startAngle = -pi / 2 - spreadAngle / 2; // Center upward

    for (int i = 0; i < rayCount; i++) {
      final angle = startAngle + (spreadAngle * i / (rayCount - 1));
      final rayLength = size.height * 0.7;

      // Vary ray properties
      final rayOpacity = 0.08 + (0.04 * (i % 3)) * intensity;
      final rayWidth = 30.0 + (i % 3) * 15.0;

      final endPoint = Offset(
        sourcePoint.dx + cos(angle) * rayLength,
        sourcePoint.dy + sin(angle) * rayLength,
      );

      // Create gradient for each ray
      final rayPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            rayColor.withValues(alpha: rayOpacity * 0.8),
            rayColor.withValues(alpha: rayOpacity),
            rayColor.withValues(alpha: rayOpacity * 0.5),
            rayColor.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.2, 0.5, 1.0],
        ).createShader(
          Rect.fromPoints(
            sourcePoint,
            Offset(sourcePoint.dx, sourcePoint.dy + rayLength),
          ),
        )
        ..strokeWidth = rayWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

      canvas.drawLine(sourcePoint, endPoint, rayPaint);
    }

    // Central bright glow
    canvas.drawCircle(
      sourcePoint,
      40,
      Paint()
        ..color = rayColor.withValues(alpha: 0.15 * intensity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30),
    );
  }

  @override
  bool shouldRepaint(LightRaysPainter oldDelegate) {
    return oldDelegate.intensity != intensity ||
        oldDelegate.rayColor != rayColor ||
        oldDelegate.sourcePoint != sourcePoint;
  }
}
