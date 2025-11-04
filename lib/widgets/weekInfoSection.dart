import 'package:evencir_task/constants/app_text_styles.dart';
import 'package:evencir_task/constants/app_colors.dart';
import 'package:flutter/material.dart';

class WeekInfoSection extends StatelessWidget {
  final double screenHeight;
  final BuildContext contextRef;
  final String weekText;
  final String dateRange;
  final String totalTime;

  const WeekInfoSection({
    super.key,
    required this.screenHeight,
    required this.contextRef,
    required this.weekText,
    required this.dateRange,
    required this.totalTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.1,
      color: AppColors.weekInfoBackground,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weekText,
            style: AppTextStyles.custom(
              context: context,
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateRange,
                style: AppTextStyles.custom(
                  context: context,
                  color: AppColors.white60,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                totalTime,
                style: AppTextStyles.custom(
                  context: context,
                  color: AppColors.white60,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
