import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/constants/app_text_styles.dart';
import 'package:evencir_task/constants/app_colors.dart';
import 'package:flutter/material.dart';

class WeightCardWidget extends StatelessWidget {
  final double height;

  const WeightCardWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "75",
                  style: AppTextStyles.custom(
                    context: context,
                    color: AppColors.white,
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: height * 0.08),
                    child: Text(
                      "Kg",
                      style: AppTextStyles.custom(
                        context: context,
                        color: AppColors.white,
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  AppImages.statIcon,
                  width: screenWidth * 0.06,
                  height: screenWidth * 0.06,
                ),
                Text(
                  "+1.6kg",
                  style: AppTextStyles.custom(
                    context: context,
                    color: AppColors.white60,
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "Weight",
              style: AppTextStyles.custom(
                context: context,
                color: AppColors.white,
                fontSize: screenWidth * 0.032,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
