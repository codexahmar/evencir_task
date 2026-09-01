import 'package:evencir_task/constants/app_colors.dart';
import 'package:evencir_task/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeightCardWidget extends StatelessWidget {
  final double? height;

  const WeightCardWidget({super.key, this.height});

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
          // Weight Value & Unit
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "75.0",
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "kg",
                    style: GoogleFonts.mulish(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Image.asset(
                    AppImages.statIcon,
                    width: 13,
                    height: 13,
                    color: const Color(0xFF00C896),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "+1.6 kg",
                      style: GoogleFonts.mulish(
                        color: const Color(0xFF00C896),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Mini Goal indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Weight",
                  style: GoogleFonts.mulish(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Goal 72k",
                    style: GoogleFonts.mulish(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
