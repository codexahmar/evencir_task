import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/constants/app_text_styles.dart';
import 'package:evencir_task/constants/app_texts.dart';
import 'package:evencir_task/utils/calendar_utils.dart';
import 'package:evencir_task/widgets/appbar_widget.dart';
import 'package:evencir_task/widgets/minicalendar_widget.dart';
import 'package:evencir_task/widgets/calories_card_widget.dart';
import 'package:evencir_task/widgets/weight_card_widget.dart';
import 'package:evencir_task/widgets/hydration_card_widget.dart';
import 'package:evencir_task/widgets/workoutCard_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  List<DateTime> get currentWeekDays =>
      CalendarUtils.getCurrentWeekDays(focusedDay);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final safeAreaHeight =
        screenHeight -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    String getTimeBasedIcon() {
      final hour = DateTime.now().hour;

      // Day time: 6 AM to 6 PM (6-17)
      if (hour >= 6 && hour < 18) {
        return AppImages.sunIcon;
      }
      // Night time: 6 PM to 6 AM (18-5)
      else {
        return AppImages.moon;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: safeAreaHeight * 0.015,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarWidget(
                        selectedDay: selectedDay,
                        focusedDay: focusedDay,
                        onDaySelected: (selected, focused) {
                          setState(() {
                            selectedDay = selected;
                            focusedDay = focused;
                          });
                        },
                      ),

                      SizedBox(height: safeAreaHeight * 0.02),

                      Text(
                        "Today, ${selectedDay.day} ${CalendarUtils.monthName(selectedDay.month)} ${selectedDay.year}",
                        style: GoogleFonts.mulish(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: safeAreaHeight * 0.015),

                      MiniCalendarWidget(
                        currentWeekDays: currentWeekDays,
                        selectedDay: selectedDay,
                        focusedDay: focusedDay,
                        onDaySelected: (selected, focused) {
                          setState(() {
                            selectedDay = selected;
                            focusedDay = focused;
                          });
                        },
                      ),

                      SizedBox(height: safeAreaHeight * 0.02),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppTexts.workout,
                            style: AppTextStyles.custom(
                              context: context,
                              color: Colors.white,
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                getTimeBasedIcon(),
                                width: screenWidth * 0.06,
                                height: screenWidth * 0.06,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                "9°",
                                style: AppTextStyles.custom(
                                  context: context,
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: safeAreaHeight * 0.015),

                      WorkoutCardWidget(
                        selectedDay: selectedDay,
                        height: safeAreaHeight * 0.11,
                      ),

                      SizedBox(height: safeAreaHeight * 0.02),

                      Text(
                        AppTexts.insights,
                        style: AppTextStyles.custom(
                          context: context,
                          color: Colors.white,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: safeAreaHeight * 0.02),

                      Row(
                        children: [
                          Expanded(
                            child: CaloriesCardWidget(
                              height: safeAreaHeight * 0.18,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(
                            child: WeightCardWidget(
                              height: safeAreaHeight * 0.18,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: safeAreaHeight * 0.02),

                      HydrationCardWidget(height: safeAreaHeight * 0.19),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
