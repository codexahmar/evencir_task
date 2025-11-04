import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.construction_rounded,
              size: 70,
              color: Colors.amberAccent.withOpacity(0.8),
            ),
            const SizedBox(height: 20),
            Text(
              "Profile Screen",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.mulish().fontFamily,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "This screen is under development",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: GoogleFonts.mulish().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
