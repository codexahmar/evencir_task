import 'dart:math';
import 'package:flutter/material.dart';

class MoodRingPainter extends CustomPainter {
  final double activeAngle;
  final Color activeColor;

  MoodRingPainter({
    this.activeAngle = 0,
    this.activeColor = const Color(0xFF6EB9AD),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double ringThickness = size.width * 0.085;
    final double radius = size.width / 2 - ringThickness / 2 - 4;

    const gradient = SweepGradient(
      startAngle: 0,
      endAngle: 2 * pi,
      colors: [
        Color(0xFF6EB9AD), // Calm
        Color(0xFFC9BBEF), // Content
        Color(0xFFF28DB3), // Peaceful
        Color(0xFFF99955), // Happy
        Color(0xFF6EB9AD), // Wrap around
      ],
      stops: [0.0, 0.25, 0.5, 0.75, 1.0],
    );

    // Subtle background track
    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringThickness;
    canvas.drawCircle(center, radius, bgPaint);

    // Glowing main sweep ring
    final ringPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringThickness
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, ringPaint);

    // Tick divider marks
    final dividerPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..strokeWidth = 2.0;

    final double innerRadius = radius - ringThickness / 2;
    final double outerRadius = radius + ringThickness / 2;
    const int totalDividers = 36;
    const double gapAngle = (2 * pi) / totalDividers;

    for (int i = 0; i < totalDividers; i++) {
      if (i % 3 == 0) {
        final double a = i * gapAngle;
        final Offset start = Offset(
          center.dx + innerRadius * cos(a),
          center.dy + innerRadius * sin(a),
        );
        final Offset end = Offset(
          center.dx + outerRadius * cos(a),
          center.dy + outerRadius * sin(a),
        );
        canvas.drawLine(start, end, dividerPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant MoodRingPainter oldDelegate) =>
      oldDelegate.activeAngle != activeAngle ||
      oldDelegate.activeColor != activeColor;
}
