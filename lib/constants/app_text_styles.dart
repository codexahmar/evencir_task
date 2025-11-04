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
  }) {
    double baseSize = MediaQuery.of(context).size.width * 0.045;

    return TextStyle(
      color: color,
      fontSize: fontSize ?? baseSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      fontFamily: GoogleFonts.getFont(fontFamily).fontFamily,
    );
  }
}
