import 'package:flutter/material.dart';

/// Custom painter for drawing a gothic-style archway with glowing effect
/// Represents the sacred threshold - the doorway to grace through confession
class ArchwayPainter extends CustomPainter {
  final Color archColor;
  final Color glowColor;
  final double glowIntensity;
  final double animationProgress;

  ArchwayPainter({
    required this.archColor,
    required this.glowColor,
    this.glowIntensity = 1.0,
    this.animationProgress = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Skip painting if size is too small
    if (size.width < 10 || size.height < 10) return;

    final centerX = size.width / 2;
    final archWidth = size.width * 0.65;
    final archHeight = size.height * 0.85;

    // 1. Draw inner golden glow (radial gradient)
    _drawInnerGlow(canvas, size, centerX, archWidth, archHeight);

    // 2. Draw the archway outline
    _drawArchway(canvas, size, centerX, archWidth, archHeight);
  }

  void _drawInnerGlow(
    Canvas canvas,
    Size size,
    double centerX,
    double archWidth,
    double archHeight,
  ) {
    final glowRect = Rect.fromCenter(
      center: Offset(centerX, size.height * 0.45),
      width: archWidth * 0.85,
      height: archHeight * 0.9,
    );

    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0.2),
        radius: 0.9,
        colors: [
          glowColor.withValues(alpha: 0.5 * glowIntensity),
          glowColor.withValues(alpha: 0.25 * glowIntensity),
          glowColor.withValues(alpha: 0.08 * glowIntensity),
          glowColor.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
      ).createShader(glowRect);

    canvas.drawOval(glowRect, glowPaint);

    // Secondary inner glow for more warmth
    final innerGlowRect = Rect.fromCenter(
      center: Offset(centerX, size.height * 0.5),
      width: archWidth * 0.5,
      height: archHeight * 0.6,
    );

    final innerGlowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0.3),
        radius: 0.7,
        colors: [
          glowColor.withValues(alpha: 0.35 * glowIntensity),
          glowColor.withValues(alpha: 0.15 * glowIntensity),
          glowColor.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(innerGlowRect);

    canvas.drawOval(innerGlowRect, innerGlowPaint);
  }

  void _drawArchway(
    Canvas canvas,
    Size size,
    double centerX,
    double archWidth,
    double archHeight,
  ) {
    final archPath = _createArchPath(size, centerX, archWidth, archHeight);

    // Calculate animated path
    final pathMetricsList = archPath.computeMetrics().toList();
    if (pathMetricsList.isEmpty) return;

    final pathMetric = pathMetricsList.first;
    final animatedPath = pathMetric.extractPath(
      0,
      pathMetric.length * animationProgress.clamp(0.0, 1.0),
    );

    // Outer glow/shadow
    canvas.drawPath(
      animatedPath,
      Paint()
        ..color = archColor.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 16
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    // Mid glow
    canvas.drawPath(
      animatedPath,
      Paint()
        ..color = archColor.withValues(alpha: 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    // Main stroke
    canvas.drawPath(
      animatedPath,
      Paint()
        ..color = archColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Inner highlight
    canvas.drawPath(
      animatedPath,
      Paint()
        ..color = glowColor.withValues(alpha: 0.3 * glowIntensity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round,
    );
  }

  Path _createArchPath(
    Size size,
    double centerX,
    double archWidth,
    double archHeight,
  ) {
    final path = Path();
    final baseY = size.height;
    final topY = size.height - archHeight;

    final leftX = centerX - archWidth / 2;
    final rightX = centerX + archWidth / 2;

    // Start from bottom left
    path.moveTo(leftX, baseY);

    // Left side going up
    path.lineTo(leftX, baseY - archHeight * 0.35);

    // Left curve to peak (gothic pointed arch)
    path.cubicTo(
      leftX,
      topY + archHeight * 0.25,
      centerX - archWidth * 0.15,
      topY,
      centerX,
      topY,
    );

    // Right curve from peak
    path.cubicTo(
      centerX + archWidth * 0.15,
      topY,
      rightX,
      topY + archHeight * 0.25,
      rightX,
      baseY - archHeight * 0.35,
    );

    // Right side going down
    path.lineTo(rightX, baseY);

    return path;
  }

  @override
  bool shouldRepaint(ArchwayPainter oldDelegate) {
    return oldDelegate.glowIntensity != glowIntensity ||
        oldDelegate.animationProgress != animationProgress ||
        oldDelegate.archColor != archColor ||
        oldDelegate.glowColor != glowColor;
  }
}
