import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          AppImages.bellIcon,
          width: screenWidth * 0.06,
          height: screenWidth * 0.06,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImages.moonIcon,
              width: screenWidth * 0.06,
              height: screenWidth * 0.06,
            ),
            SizedBox(width: screenWidth * 0.02),
            Text(
              "Week 1/4",
              style: TextStyle(
                color: AppColors.white,
                fontSize: screenWidth * 0.04,
              ),
            ),
            SizedBox(width: screenWidth * 0.01),
            Image.asset(
              AppImages.dropDownIcon,
              width: screenWidth * 0.045,
              height: screenWidth * 0.045,
            ),
          ],
        ),
        SizedBox(width: screenWidth * 0.06),
      ],
    );
  }
}
