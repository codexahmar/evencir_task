import 'package:evencir_task/constants/app_colors.dart';
import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/constants/app_texts.dart';
import 'package:evencir_task/utils/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutCardWidget extends StatelessWidget {
  final DateTime selectedDay;
  final double? height;
  final VoidCallback? onTap;

  const WorkoutCardWidget({
    super.key,
    required this.selectedDay,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Left Glowing Strip
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF00C896),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF00C896),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),

              // Workout Info Content
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 14, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                CalendarUtils.formattedDate(selectedDay),
                                style: GoogleFonts.mulish(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(
                                  color: Colors.white38,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "25m - 30m",
                                style: GoogleFonts.mulish(
                                  color: const Color(0xFF00C896),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppTexts.upperBody,
                            style: GoogleFonts.mulish(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        AppImages.arrowIcon,
                        width: 14,
                        height: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
