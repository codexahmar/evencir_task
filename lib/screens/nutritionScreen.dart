import 'package:evencir_task/constants/app_colors.dart';
import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/constants/app_texts.dart';
import 'package:evencir_task/utils/calendar_utils.dart';
import 'package:evencir_task/widgets/appbar_widget.dart';
import 'package:evencir_task/widgets/calories_card_widget.dart';
import 'package:evencir_task/widgets/hydration_card_widget.dart';
import 'package:evencir_task/widgets/minicalendar_widget.dart';
import 'package:evencir_task/widgets/weight_card_widget.dart';
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

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return AppTexts.greetingMorning;
    if (hour < 17) return AppTexts.greetingAfternoon;
    return AppTexts.greetingEvening;
  }

  String _getTimeBasedIcon() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 18) {
      return AppImages.sunIcon;
    }
    return AppImages.moon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
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

              const SizedBox(height: 18),

              // Greeting & Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${_getGreeting()}, Alex",
                          style: GoogleFonts.mulish(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Today, ${selectedDay.day} ${CalendarUtils.monthName(selectedDay.month)} ${selectedDay.year}",
                          style: GoogleFonts.manrope(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Weather / Time Chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          _getTimeBasedIcon(),
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "9°C",
                          style: GoogleFonts.manrope(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Interactive Week Day Selector Strip
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

              const SizedBox(height: 22),

              // Workouts Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppTexts.workout,
                    style: GoogleFonts.mulish(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  Text(
                    "1 Planned",
                    style: GoogleFonts.mulish(
                      color: const Color(0xFF00C896),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              WorkoutCardWidget(
                selectedDay: selectedDay,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF1E1E28),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      content: Text(
                        "Upper Body Blitz: 4 exercises scheduled for today.",
                        style: GoogleFonts.mulish(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 22),

              // Insights Section Header
              Text(
                AppTexts.insights,
                style: GoogleFonts.mulish(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),

              const SizedBox(height: 12),

              // Calories & Weight Cards Side by Side
              const Row(
                children: [
                  Expanded(child: CaloriesCardWidget()),
                  SizedBox(width: 12),
                  Expanded(child: WeightCardWidget()),
                ],
              ),

              const SizedBox(height: 14),

              // Hydration Card
              const HydrationCardWidget(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
