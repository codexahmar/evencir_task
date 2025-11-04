import 'dart:math';
import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/widgets/moodRingPainter_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_texts.dart';
import '../../../constants/app_text_styles.dart';

class Moodscreen extends StatefulWidget {
  const Moodscreen({super.key});

  @override
  State<Moodscreen> createState() => _MoodscreenState();
}

class _MoodscreenState extends State<Moodscreen> {
  double angle = 0;

  final List<Color> colors = const [
    Color(0xFF6EB9AD),
    Color(0xFFC9BBEF),
    Color(0xFFF28DB3),
    Color(0xFFF99955),
  ];

  final List<String> emojis = [
    AppImages.calmImage,
    AppImages.contentImage,
    AppImages.peacefulImage,
    AppImages.happyImage,
  ];

  final List<String> moods = ["Calm", "Content", "Peaceful", "Happy"];

  String currentMood = "Calm";
  String currentEmoji = AppImages.calmImage;

  void updateMood(double angle) {
    if (angle < 0) angle += 2 * pi;
    const double sectionAngle = 2 * pi / 4;
    final adjustedAngle = (angle + sectionAngle / 2) % (2 * pi);
    final int section = (adjustedAngle / sectionAngle).floor() % 4;

    setState(() {
      currentEmoji = emojis[section];
      currentMood = moods[section];
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double size = screenWidth * 0.75;
    final double ringThickness = size * 0.1;
    final double radius = size / 2 - ringThickness / 2;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 0.53,
            colors: [Color.fromARGB(131, 33, 149, 243), Colors.black],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTexts.moodTitle,
                        style: AppTextStyles.custom(
                          context: context,
                          color: Colors.white,
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Mulish',
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.05),
                      Text(
                        AppTexts.startYourDay,
                        style: AppTextStyles.custom(
                          context: context,
                          color: Colors.white,
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Mulish',
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.05),
                      Text(
                        AppTexts.howAreYouFeeling,
                        style: AppTextStyles.custom(
                          context: context,
                          color: Colors.white,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Mulish',
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.12),

                      Center(
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            final touchPosition = Offset(
                              details.localPosition.dx - size / 2,
                              details.localPosition.dy - size / 2,
                            );
                            final newAngle = atan2(
                              touchPosition.dy,
                              touchPosition.dx,
                            );
                            setState(() {
                              angle = newAngle;
                              updateMood(angle);
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomPaint(
                                size: Size(size, size),
                                painter: MoodRingPainter(),
                              ),
                              Image.asset(
                                currentEmoji,
                                width: size * 0.33,
                                height: size * 0.33,
                              ),
                              Transform.translate(
                                offset: Offset(
                                  radius * cos(angle),
                                  radius * sin(angle),
                                ),
                                child: Container(
                                  width: size * 0.18,
                                  height: size * 0.18,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.6),
                                        blurRadius: 15,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: screenWidth * 0.07),
                      Center(
                        child: Text(
                          currentMood,
                          style: AppTextStyles.custom(
                            context: context,
                            color: Colors.white,
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Mulish',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: screenWidth * 0.14,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  ),
                  child: Center(
                    child: Text(
                      AppTexts.continueButton,
                      style: AppTextStyles.custom(
                        context: context,
                        color: Colors.black,
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
