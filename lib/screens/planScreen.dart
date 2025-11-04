import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/constants/app_text_styles.dart';
import 'package:evencir_task/constants/app_texts.dart';
import 'package:evencir_task/widgets/weekInfoSection.dart';
import 'package:evencir_task/widgets/workoutContainer.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final List<Map<String, dynamic>> weekDays = [
      {
        "day": AppTexts.mon,
        "date": "8",
        "hasWorkout": true,
        "workoutType": AppTexts.armWorkout,
        "workoutColor": const Color(0xFF20B76F),
        "icon": AppImages.exerciseIcon,
        "title": AppTexts.armBlaster,
        "duration": AppTexts.workoutDuration,
      },
      {"day": AppTexts.tue, "date": "9", "hasWorkout": false},
      {"day": AppTexts.wed, "date": "10", "hasWorkout": false},
      {
        "day": AppTexts.thu,
        "date": "11",
        "hasWorkout": true,
        "workoutType": AppTexts.legWorkout,
        "workoutColor": const Color(0xFF4855DF),
        "icon": AppImages.legIcon,
        "title": AppTexts.legDayBlitz,
        "duration": AppTexts.workoutDuration,
      },
      {"day": AppTexts.fri, "date": "12", "hasWorkout": false},
      {"day": AppTexts.sat, "date": "13", "hasWorkout": false},
      {"day": AppTexts.sun, "date": "14", "hasWorkout": false},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        title: Text(
          AppTexts.trainingCalendar,
          style: AppTextStyles.custom(context: context, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              AppTexts.save,
              style: AppTextStyles.custom(
                context: context,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xFF000000),
      ),
      body: Column(
        children: [
          const Divider(thickness: 2, color: Color(0xFF4855DF)),

          WeekInfoSection(
            screenHeight: screenHeight,
            contextRef: context,
            weekText: AppTexts.weekTwoOfEight,
            dateRange: AppTexts.weekTwoDateRange,
            totalTime: AppTexts.total60Min,
          ),

          Expanded(
            child: ListView.separated(
              itemCount: weekDays.length + 1,
              separatorBuilder: (context, index) {
                if (index == weekDays.length - 1) {
                  return const SizedBox.shrink();
                }
                return Divider(
                  color: Colors.white.withOpacity(0.15),
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                );
              },

              itemBuilder: (context, index) {
                if (index == weekDays.length) {
                  return Column(
                    children: [
                      const Divider(thickness: 2, color: Color(0xFF4855DF)),
                      WeekInfoSection(
                        screenHeight: screenHeight,
                        contextRef: context,
                        weekText: AppTexts.weekThreeOfEight,
                        dateRange: AppTexts.weekThreeDateRange,
                        totalTime: AppTexts.total70Min,
                      ),
                    ],
                  );
                }

                final day = weekDays[index];
                final hasWorkout = day["hasWorkout"] ?? false;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            day["day"],
                            style: AppTextStyles.custom(
                              context: context,
                              color: Colors.white.withOpacity(
                                hasWorkout ? 1 : 0.3,
                              ),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            day["date"],
                            style: AppTextStyles.custom(
                              context: context,
                              color: Colors.white.withOpacity(
                                hasWorkout ? 1 : 0.3,
                              ),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),

                      if (hasWorkout)
                        Expanded(
                          child: WorkoutContainer(
                            context: context,
                            type: day["workoutType"],
                            color: day["workoutColor"],
                            iconPath: day["icon"],
                            title: day["title"],
                            duration: day["duration"],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
