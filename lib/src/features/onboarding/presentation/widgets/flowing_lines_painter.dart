import 'dart:math';
import 'package:flutter/material.dart';

/// Custom painter for sacred geometry decorations
/// Creates elegant circles, arcs, and spiritual patterns
/// Optimized for performance on all devices (no blur filters)
class FlowingLinesPainter extends CustomPainter {
  final Color lineColor;
  final double animationValue;

  FlowingLinesPainter({
    required this.lineColor,
    this.animationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width < 10 || size.height < 10) return;

    final w = size.width;
    final h = size.height;
    final centerX = w / 2;

    // Animation values
    final breathe = 0.97 + 0.03 * sin(animationValue * 2 * pi);
    final slowRotation = animationValue * pi * 0.1;
    final pulsePhase = animationValue * 2 * pi;

    // ============ CORNER ARCS ============
    // Top-left arc
    _drawArc(
      canvas,
      center: const Offset(0, 0),
      radius: w * 0.30 * breathe,
      startAngle: 0,
      sweepAngle: pi / 2.2,
      opacity: 0.18,
      strokeWidth: 1.5,
    );

    // Top-right arc
    _drawArc(
      canvas,
      center: Offset(w, 0),
      radius: w * 0.30 * breathe,
      startAngle: pi / 2,
      sweepAngle: pi / 2.2,
      opacity: 0.18,
      strokeWidth: 1.5,
    );

    // ============ SIDE ARCS ============
    // Left side arc
    _drawArc(
      canvas,
      center: Offset(w * -0.15, h * 0.38),
      radius: w * 0.32,
      startAngle: -pi / 5 + slowRotation * 0.2,
      sweepAngle: pi / 2.5,
      opacity: 0.15,
      strokeWidth: 1.2,
    );

    // Right side arc
    _drawArc(
      canvas,
      center: Offset(w * 1.15, h * 0.42),
      radius: w * 0.32,
      startAngle: pi * 0.7 - slowRotation * 0.2,
      sweepAngle: pi / 2.5,
      opacity: 0.15,
      strokeWidth: 1.2,
    );

    // ============ CONCENTRIC CIRCLES ============
    _drawConcentricCircles(
      canvas,
      center: Offset(w * 0.06, h * 0.2),
      maxRadius: w * 0.12,
      rings: 2,
      opacity: 0.12,
      phase: pulsePhase,
    );

    _drawConcentricCircles(
      canvas,
      center: Offset(w * 0.94, h * 0.22),
      maxRadius: w * 0.10,
      rings: 2,
      opacity: 0.12,
      phase: pulsePhase + pi * 0.3,
    );

    // ============ TRINITY SYMBOL (Top Center) ============
    _drawTrinitySymbol(
      canvas,
      center: Offset(centerX, h * 0.06),
      radius: w * 0.04 * breathe,
      opacity: 0.15,
      rotation: slowRotation * 0.3,
    );

    // ============ ACCENT DOTS ============
    _drawAccentDots(canvas, size, breathe, pulsePhase);
  }

  void _drawArc(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required double startAngle,
    required double sweepAngle,
    required double opacity,
    required double strokeWidth,
  }) {
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Single clean arc (no blur)
    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      Paint()
        ..color = lineColor.withValues(alpha: opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawConcentricCircles(
    Canvas canvas, {
    required Offset center,
    required double maxRadius,
    required int rings,
    required double opacity,
    required double phase,
  }) {
    for (int i = 0; i < rings; i++) {
      final ringPhase = phase + (i * pi / rings);
      final pulse = 0.95 + 0.05 * sin(ringPhase);
      final r = maxRadius * ((i + 1) / rings) * pulse;
      final ringOpacity = opacity * (1 - i * 0.3);

      canvas.drawCircle(
        center,
        r,
        Paint()
          ..color = lineColor.withValues(alpha: ringOpacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8,
      );
    }

    // Center dot
    final centerPulse = 0.85 + 0.15 * sin(phase);
    canvas.drawCircle(
      center,
      2.0 * centerPulse,
      Paint()..color = lineColor.withValues(alpha: opacity * 0.7),
    );
  }

  void _drawTrinitySymbol(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required double opacity,
    required double rotation,
  }) {
    const angles = [0.0, 2 * pi / 3, 4 * pi / 3];
    final offset = radius * 0.5;

    for (final angle in angles) {
      final circleCenter = Offset(
        center.dx + cos(angle + rotation) * offset,
        center.dy + sin(angle + rotation) * offset,
      );

      canvas.drawCircle(
        circleCenter,
        radius,
        Paint()
          ..color = lineColor.withValues(alpha: opacity * 0.6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.7,
      );
    }
  }

  void _drawAccentDots(
    Canvas canvas,
    Size size,
    double breathe,
    double phase,
  ) {
    final dots = [
      (Offset(size.width * 0.04, size.height * 0.12), 0.0),
      (Offset(size.width * 0.96, size.height * 0.12), 0.2),
      (Offset(size.width * 0.03, size.height * 0.32), 0.4),
      (Offset(size.width * 0.97, size.height * 0.32), 0.6),
      (Offset(size.width * 0.05, size.height * 0.52), 0.8),
      (Offset(size.width * 0.95, size.height * 0.52), 1.0),
    ];

    for (final (pos, offset) in dots) {
      final dotPhase = phase + offset * 2 * pi;
      final twinkle = (sin(dotPhase) + 1) / 2;
      final alpha = 0.15 + 0.2 * twinkle;
      final dotSize = (1.5 + 0.5 * twinkle) * breathe;

      // Simple dot with soft edge
      canvas.drawCircle(
        pos,
        dotSize * 2,
        Paint()..color = lineColor.withValues(alpha: alpha * 0.3),
      );

      canvas.drawCircle(
        pos,
        dotSize,
        Paint()..color = lineColor.withValues(alpha: alpha),
      );
    }
  }

  @override
  bool shouldRepaint(FlowingLinesPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.lineColor != lineColor;
  }
}
