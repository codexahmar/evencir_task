import 'package:evencir_task/constants/app_colors.dart';
import 'package:evencir_task/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class WeekInfoSection extends StatelessWidget {
  final String weekText;
  final String dateRange;
  final String totalTime;

  const WeekInfoSection({
    super.key,
    required this.weekText,
    required this.dateRange,
    required this.totalTime,
    double? screenHeight,
    BuildContext? contextRef,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.primaryBlue.withValues(alpha: 0.8),
            width: 2,
          ),
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  weekText,
                  style: AppTextStyles.custom(
                    context: context,
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateRange,
                  style: AppTextStyles.custom(
                    context: context,
                    color: Colors.white.withValues(alpha: 0.55),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Total Duration Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primaryBlue.withValues(alpha: 0.35),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.schedule_rounded,
                  size: 13,
                  color: Color(0xFF818CF8),
                ),
                const SizedBox(width: 5),
                Text(
                  totalTime,
                  style: AppTextStyles.custom(
                    context: context,
                    color: const Color(0xFFC7D2FE),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
