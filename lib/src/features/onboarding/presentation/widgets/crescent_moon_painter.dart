import 'package:flutter/material.dart';

/// Custom painter for drawing a crescent moon
/// Adds to the celestial, mystical atmosphere
class CrescentMoonPainter extends CustomPainter {
  final Color moonColor;
  final double glowIntensity;

  CrescentMoonPainter({
    required this.moonColor,
    this.glowIntensity = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Skip painting if size is too small
    if (size.width < 5 || size.height < 5) return;

    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.75;
    final innerOffset = Offset(outerRadius * 0.35, -outerRadius * 0.1);

    // Outer glow
    canvas.drawCircle(
      center,
      outerRadius * 1.3,
      Paint()
        ..color = moonColor.withValues(alpha: 0.1 * glowIntensity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, outerRadius * 0.5),
    );

    // Create crescent path
    final path = Path();
    path.addOval(
      Rect.fromCircle(center: center, radius: outerRadius),
    );

    // Subtract inner circle to create crescent
    final innerPath = Path();
    innerPath.addOval(
      Rect.fromCircle(center: center + innerOffset, radius: innerRadius),
    );

    final crescentPath = Path.combine(
      PathOperation.difference,
      path,
      innerPath,
    );

    // Draw crescent with glow
    canvas.drawPath(
      crescentPath,
      Paint()
        ..color = moonColor.withValues(alpha: 0.15 * glowIntensity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, outerRadius * 0.3),
    );

    // Main crescent
    canvas.drawPath(
      crescentPath,
      Paint()
        ..color = moonColor.withValues(alpha: 0.5 * glowIntensity)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(CrescentMoonPainter oldDelegate) {
    return oldDelegate.glowIntensity != glowIntensity ||
        oldDelegate.moonColor != moonColor;
  }
}
