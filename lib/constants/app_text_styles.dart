import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle custom({
    required BuildContext context,
    Color color = Colors.white,
    double? fontSize,
    FontWeight fontWeight = FontWeight.normal,
    String fontFamily = 'Mulish',
    double? letterSpacing,
    double? height,
  }) {
    double baseSize = 16.0;

    return GoogleFonts.getFont(
      fontFamily,
      color: color,
      fontSize: fontSize ?? baseSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Pre-baked text styles for consistent typography
  static TextStyle heading1({Color color = Colors.white}) =>
      GoogleFonts.mulish(
        color: color,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      );

  static TextStyle heading2({Color color = Colors.white}) =>
      GoogleFonts.mulish(
        color: color,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      );

  static TextStyle heading3({Color color = Colors.white}) =>
      GoogleFonts.mulish(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );

  static TextStyle bodyMedium({Color color = Colors.white}) =>
      GoogleFonts.mulish(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  static TextStyle bodySmall({Color color = Colors.white70}) =>
      GoogleFonts.mulish(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );

  static TextStyle caption({Color color = Colors.white60}) =>
      GoogleFonts.mulish(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      );
}
