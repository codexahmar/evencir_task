import 'package:flutter/material.dart';

class AppColors {
  // Base Colors
  static const Color black = Color(0xFF000000);
  static const Color background = Color(0xFF0A0A0C);
  static const Color surface = Color(0xFF141418);
  static const Color cardBackground = Color(0xFF18181C);
  static const Color cardBackgroundElevated = Color(0xFF202026);
  static const Color cardBorder = Color(0xFF2C2C34);
  static const Color glassBorder = Color(0x1FFFFFFF);

  // Text Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFFF5F5F7);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textMuted = Color(0xFF71717A);

  static Color white80 = const Color(0xCCFFFFFF);
  static Color white60 = const Color(0x99FFFFFF);
  static Color white30 = const Color(0x4DFFFFFF);
  static Color white15 = const Color(0x26FFFFFF);
  static Color white10 = const Color(0x1AFFFFFF);
  static Color white05 = const Color(0x0DFFFFFF);

  static const Color grey = Color(0xFF8E8E93);
  static Color grey30 = const Color(0x4D8E8E93);

  // Accent & Brand Colors
  static const Color primaryBlue = Color(0xFF4855DF);
  static const Color accentCyan = Color(0xFF00D2FF);
  static const Color accentTeal = Color(0xFF00C896);
  static const Color accentGreen = Color(0xFF20B76F);
  static const Color accentOrange = Color(0xFFF99955);
  static const Color accentPink = Color(0xFFF28DB3);
  static const Color accentPurple = Color(0xFFC9BBEF);

  // Specific Feature Colors
  static const Color dividerBlue = Color(0xFF4855DF);
  static const Color infoBackground = Color(0xFF121216);
  static const Color hydrationBottom = Color(0xFF16323B);
  static const Color hydrationCyan = Color(0xFF48A4E5);
  static const Color workoutLeft = Color(0xFF00C896);
  static const Color workoutRight = Color(0xFF18181C);
  static const Color workoutContainer = Color(0xFF1C1C22);
  static const Color workoutContainerLeft = Color(0xFFFFFFFF);
  static const Color weekInfoBackground = Color(0xFF121216);
  static const Color miniCalendarCircle = Color(0xFF23232A);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4855DF), Color(0xFF00C896)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1F1F26), Color(0xFF141418)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient caloriesGradient = LinearGradient(
    colors: [Color(0xFF7BBDE2), Color(0xFF69C0B1), Color(0xFF60C198)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient hydrationGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFF00E5FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFF4855DF), Color(0xFF6366F1)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
