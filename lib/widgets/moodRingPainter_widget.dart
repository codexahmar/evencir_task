import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class MoodRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double ringThickness = size.width * 0.1;
    final double radius = size.width / 2 - ringThickness / 2;

    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: 2 * pi,
      colors: const [
        Color(0xFF6EB9AD),
        Color(0xFF8FC1B8),
        Color(0xFFC9BBEF),
        Color(0xFFD5B6E8),
        Color(0xFFF28DB3),
        Color(0xFFF59F7A),
        Color(0xFFF99955),
        Color(0xFF7CC0A9),
        Color(0xFF6EB9AD),
      ],
      stops: const [0.0, 0.12, 0.25, 0.37, 0.5, 0.62, 0.75, 0.87, 1.0],
    );

    final ringPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringThickness
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, ringPaint);

    final dividerPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..strokeWidth = size.width * 0.005;

    final double innerRadius = radius - ringThickness / 2;
    final double outerRadius = radius + ringThickness / 2;
    const int totalDividers = 30;
    const double gapAngle = (2 * pi) / totalDividers;

    for (int i = 0; i < totalDividers; i++) {
      if (i % 2 == 0) {
        final double angle = i * gapAngle;
        final Offset start = Offset(
          center.dx + innerRadius * cos(angle),
          center.dy + innerRadius * sin(angle),
        );
        final Offset end = Offset(
          center.dx + outerRadius * cos(angle),
          center.dy + outerRadius * sin(angle),
        );
        canvas.drawLine(start, end, dividerPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
