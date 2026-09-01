import 'package:evencir_task/constants/app_colors.dart';
import 'package:evencir_task/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CaloriesCardWidget extends StatelessWidget {
  final double? height;

  const CaloriesCardWidget({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: height ?? 135,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Calorie header & number
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "550",
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "kcal",
                    style: GoogleFonts.mulish(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF60C198),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "1,950 kcal left",
                      style: AppTextStyles.custom(
                        context: context,
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Calories Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "0",
                    style: GoogleFonts.mulish(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 9.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Target 2.5k",
                    style: GoogleFonts.mulish(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 9.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Stack(
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const double progress = 550 / 2500;
                      final double progressWidth =
                          constraints.maxWidth * progress;
                      return Container(
                        width: progressWidth,
                        height: 6,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF7BBDE2),
                              Color(0xFF69C0B1),
                              Color(0xFF60C198),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF60C198).withValues(
                                alpha: 0.4,
                              ),
                              blurRadius: 6,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
