import 'package:evencir_task/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class CaloriesCardWidget extends StatelessWidget {
  final double height;

  const CaloriesCardWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF18181C),
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
                  "550",
                  style: AppTextStyles.custom(
                    context: context,
                    color: Colors.white,
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: height * 0.08),
                    child: Text(
                      "Calories",
                      style: AppTextStyles.custom(
                        context: context,
                        color: Colors.white,
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "1950 Remaining",
              style: AppTextStyles.custom(
                context: context,
                color: Colors.white.withOpacity(0.6),
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            buildCaloriesProgressBar(context, screenWidth),
          ],
        ),
      ),
    );
  }

  Widget buildCaloriesProgressBar(BuildContext context, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "0",
                style: AppTextStyles.custom(
                  context: context,
                  color: Colors.white.withOpacity(0.6),
                  fontSize: screenWidth * 0.025,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "2500",
                style: AppTextStyles.custom(
                  context: context,
                  color: Colors.white.withOpacity(0.6),
                  fontSize: screenWidth * 0.025,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        Stack(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                double progress = 550 / 2500;
                double progressWidth = constraints.maxWidth * progress;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  width: progressWidth,
                  height: 10,
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
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
