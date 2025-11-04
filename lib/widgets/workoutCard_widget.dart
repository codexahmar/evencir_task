import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/constants/app_text_styles.dart';
import 'package:evencir_task/constants/app_texts.dart';
import 'package:evencir_task/utils/calendar_utils.dart';
import 'package:flutter/material.dart';

class WorkoutCardWidget extends StatelessWidget {
  final DateTime selectedDay;
  final double height;

  const WorkoutCardWidget({
    super.key,
    required this.selectedDay,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.02,
            decoration: const BoxDecoration(
              color: Color.fromARGB(147, 33, 205, 243),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF18181C),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${CalendarUtils.formattedDate(selectedDay)} - 25m - 30m",
                            style: AppTextStyles.custom(
                              context: context,
                              color: Colors.white,
                              fontSize: screenWidth * 0.03,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: height * 0.1),
                          Text(
                            AppTexts.upperBody,
                            style: AppTextStyles.custom(
                              context: context,
                              color: Colors.white,
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      AppImages.arrowIcon,
                      width: screenWidth * 0.06,
                      height: screenWidth * 0.06,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
