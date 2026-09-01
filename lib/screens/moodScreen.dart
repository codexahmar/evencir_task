import 'dart:math';
import 'package:evencir_task/constants/app_colors.dart';
import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/constants/app_texts.dart';
import 'package:evencir_task/widgets/moodRingPainter_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Moodscreen extends StatefulWidget {
  const Moodscreen({super.key});

  @override
  State<Moodscreen> createState() => _MoodscreenState();
}

class _MoodscreenState extends State<Moodscreen> {
  double angle = 0;

  final List<Color> colors = const [
    Color(0xFF6EB9AD), // Calm
    Color(0xFFC9BBEF), // Content
    Color(0xFFF28DB3), // Peaceful
    Color(0xFFF99955), // Happy
  ];

  final List<String> emojis = [
    AppImages.calmImage,
    AppImages.contentImage,
    AppImages.peacefulImage,
    AppImages.happyImage,
  ];

  final List<String> moods = ["Calm", "Content", "Peaceful", "Happy"];

  final List<String> moodQuotes = [
    "Centered, focused & mindful",
    "Satisfied, peaceful & grateful",
    "Tranquil, balanced & serene",
    "Energized, joyful & radiant",
  ];

  String currentMood = "Calm";
  String currentEmoji = AppImages.calmImage;
  String currentQuote = "Centered, focused & mindful";
  Color currentColor = const Color(0xFF6EB9AD);

  void updateMood(double rawAngle) {
    double a = rawAngle;
    if (a < 0) a += 2 * pi;
    const double sectionAngle = 2 * pi / 4;
    final adjustedAngle = (a + sectionAngle / 2) % (2 * pi);
    final int section = (adjustedAngle / sectionAngle).floor() % 4;

    setState(() {
      angle = rawAngle;
      currentEmoji = emojis[section];
      currentMood = moods[section];
      currentQuote = moodQuotes[section];
      currentColor = colors[section];
    });
  }

  void _logMood() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1E1E28),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: currentColor, width: 1.5),
        ),
        content: Row(
          children: [
            Image.asset(currentEmoji, width: 24, height: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Logged '$currentMood' mood! $currentQuote ✨",
                style: GoogleFonts.mulish(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dialSize = (screenWidth * 0.74).clamp(250.0, 320.0);
    final double ringThickness = dialSize * 0.085;
    final double radius = dialSize / 2 - ringThickness / 2 - 4;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.28),
            radius: 0.95,
            colors: [
              currentColor.withValues(alpha: 0.12),
              const Color(0xFF0D0D12),
              AppColors.black,
            ],
            stops: const [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Header
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppTexts.moodTitle,
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppTexts.startYourDay,
                              style: GoogleFonts.mulish(
                                color: Colors.white.withValues(alpha: 0.55),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              AppTexts.howAreYouFeeling,
                              style: GoogleFonts.mulish(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Clean Minimal Radial Mood Dial
                        Center(
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              final touchPosition = Offset(
                                details.localPosition.dx - dialSize / 2,
                                details.localPosition.dy - dialSize / 2,
                              );
                              final newAngle = atan2(
                                touchPosition.dy,
                                touchPosition.dx,
                              );
                              updateMood(newAngle);
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Custom Sweep Gradient Ring
                                CustomPaint(
                                  size: Size(dialSize, dialSize),
                                  painter: MoodRingPainter(
                                    activeAngle: angle,
                                    activeColor: currentColor,
                                  ),
                                ),

                                // Center Emoji Disc with Glassmorphism
                                Container(
                                  width: dialSize * 0.44,
                                  height: dialSize * 0.44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFF0F0F16).withValues(
                                      alpha: 0.9,
                                    ),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.1,
                                      ),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.4,
                                        ),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      transitionBuilder: (child, anim) =>
                                          ScaleTransition(
                                            scale: anim,
                                            child: child,
                                          ),
                                      child: Image.asset(
                                        currentEmoji,
                                        key: ValueKey<String>(currentEmoji),
                                        width: dialSize * 0.32,
                                        height: dialSize * 0.32,
                                      ),
                                    ),
                                  ),
                                ),

                                // Draggable Indicator Knob
                                Transform.translate(
                                  offset: Offset(
                                    radius * cos(angle),
                                    radius * sin(angle),
                                  ),
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: currentColor,
                                        width: 2.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: currentColor.withValues(
                                            alpha: 0.4,
                                          ),
                                          blurRadius: 8,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // Active Mood Label & Descriptor Quote
                        Center(
                          child: Column(
                            children: [
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 250),
                                style: GoogleFonts.manrope(
                                  color: currentColor,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.3,
                                ),
                                child: Text(currentMood),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.08),
                                  ),
                                ),
                                child: Text(
                                  currentQuote,
                                  style: GoogleFonts.mulish(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Action Button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _logMood,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  AppTexts.continueButton,
                                  style: GoogleFonts.manrope(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
