import 'package:evencir_task/constants/app_colors.dart';
import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/constants/app_texts.dart';
import 'package:evencir_task/utils/calendar_utils.dart';
import 'package:evencir_task/utils/workout_utils.dart';
import 'package:evencir_task/widgets/weekInfoSection.dart';
import 'package:evencir_task/widgets/workoutContainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late List<Map<String, dynamic>> weekDays;
  late DateTime currentMonday;
  late DateTime nextMonday;
  late int currentWeekNumber;
  late int totalWeeksInMonth;
  late String currentWeekRange;
  late String nextWeekRange;

  @override
  void initState() {
    super.initState();
    _initializeDynamicWeek();
  }

  void _initializeDynamicWeek() {
    final now = DateTime.now();
    currentMonday = now.subtract(Duration(days: now.weekday - 1));
    nextMonday = currentMonday.add(const Duration(days: 7));

    // Calculate Week number
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    currentWeekNumber =
        ((currentMonday.day + firstDayOfMonth.weekday - 2) ~/ 7) + 1;
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    totalWeeksInMonth =
        ((lastDayOfMonth.day + firstDayOfMonth.weekday - 2) ~/ 7) + 1;

    final currentSunday = currentMonday.add(const Duration(days: 6));
    final nextSunday = nextMonday.add(const Duration(days: 6));

    final monthName = CalendarUtils.monthName(currentMonday.month);
    currentWeekRange = "$monthName ${currentMonday.day}-${currentSunday.day}";
    final nextMonthName = CalendarUtils.monthName(nextMonday.month);
    nextWeekRange = "$nextMonthName ${nextMonday.day}-${nextSunday.day}";

    const dayLabels = [
      AppTexts.mon,
      AppTexts.tue,
      AppTexts.wed,
      AppTexts.thu,
      AppTexts.fri,
      AppTexts.sat,
      AppTexts.sun,
    ];

    weekDays = List.generate(7, (index) {
      final dayDate = currentMonday.add(Duration(days: index));
      final dayLabel = dayLabels[index];

      if (index == 0) {
        // Monday - Push Workout
        return {
          "day": dayLabel,
          "date": "${dayDate.day}",
          "hasWorkout": true,
          "workoutType": "Push Strength",
          "workoutColor": const Color(0xFF00C896),
          "icon": AppImages.exerciseIcon,
          "title": "Push Hypertrophy Blitz",
          "duration": "45m - 50m",
          "exercises": [
            "Incline Dumbbell Bench Press • 4 sets × 10 reps (32 kg)",
            "Flat Barbell Bench Press • 4 sets × 8 reps (85 kg)",
            "Standing Dumbbell Lateral Raises • 4 sets × 15 reps (12 kg)",
            "Cable Chest Flyes (Low-to-High) • 3 sets × 12 reps (18 kg)",
            "Overhead Rope Tricep Extensions • 4 sets × 12 reps (25 kg)",
          ],
        };
      } else if (index == 1) {
        // Tuesday - Pull Workout
        return {
          "day": dayLabel,
          "date": "${dayDate.day}",
          "hasWorkout": true,
          "workoutType": "Pull Power",
          "workoutColor": const Color(0xFF48A4E5),
          "icon": AppImages.exerciseIcon,
          "title": "Back & Biceps Thickness",
          "duration": "40m - 45m",
          "exercises": [
            "Weighted Wide-Grip Pull-ups • 4 sets × 6 reps (+15 kg)",
            "Barbell Bent-over Rows • 4 sets × 8 reps (75 kg)",
            "Close-Grip Lat Pulldowns • 3 sets × 10 reps (65 kg)",
            "Incline Dumbbell Bicep Curls • 4 sets × 10 reps (16 kg)",
            "Face Pulls with External Rotation • 4 sets × 15 reps (20 kg)",
          ],
        };
      } else if (index == 3) {
        // Thursday - Leg Day
        return {
          "day": dayLabel,
          "date": "${dayDate.day}",
          "hasWorkout": true,
          "workoutType": AppTexts.legWorkout,
          "workoutColor": const Color(0xFF4855DF),
          "icon": AppImages.legIcon,
          "title": AppTexts.legDayBlitz,
          "duration": "50m - 55m",
          "exercises": [
            "Barbell Back Squats (A-T-G) • 4 sets × 6 reps (120 kg)",
            "Romanian Deadlifts (RDL) • 4 sets × 8 reps (100 kg)",
            "Bulgarian Split Squats • 3 sets × 10 reps/leg (24 kg)",
            "Seated Hamstring Curls • 4 sets × 12 reps (55 kg)",
            "Standing Calf Raises • 4 sets × 15 reps (70 kg)",
          ],
        };
      } else if (index == 5) {
        // Saturday - HIIT & Conditioning
        return {
          "day": dayLabel,
          "date": "${dayDate.day}",
          "hasWorkout": true,
          "workoutType": "HIIT Conditioning",
          "workoutColor": const Color(0xFFF99955),
          "icon": AppImages.exerciseIcon,
          "title": "Athletic Engine Burn",
          "duration": "25m - 30m",
          "exercises": [
            "Kettlebell Swings • 5 sets × 20 reps (28 kg)",
            "Concept2 Row Sprints • 5 sets × 250m (<45s pace)",
            "Dumbbell Devil Presses • 4 sets × 10 reps (16 kg)",
            "Box Jumps (24 inch) • 4 sets × 12 reps",
            "Ab Wheel Rollouts • 4 sets × 12 reps",
          ],
        };
      } else {
        // Rest / Active Recovery Day
        return {
          "day": dayLabel,
          "date": "${dayDate.day}",
          "hasWorkout": false,
        };
      }
    });
  }

  void moveWorkout(int fromIndex, int toIndex) {
    setState(() {
      WorkoutUtils.moveWorkout(
        weekDays: weekDays,
        fromIndex: fromIndex,
        toIndex: toIndex,
      );
    });

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1E1E28),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFF4855DF), width: 1),
        ),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF00C896),
              size: 18,
            ),
            const SizedBox(width: 10),
            Text(
              "Moved to ${weekDays[toIndex]['day']}, ${CalendarUtils.monthName(currentMonday.month)} ${weekDays[toIndex]['date']}",
              style: GoogleFonts.mulish(color: Colors.white, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  void _showWorkoutDetails(Map<String, dynamic> day) {
    final exercises = (day["exercises"] as List<String>?) ?? [
      "Dynamic Warmup • 5 mins",
      "Main Set A • 3 sets × 10 reps",
      "Main Set B • 3 sets × 12 reps",
      "Cool Down Stretch • 5 mins",
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF14141A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final Color accentColor = day["workoutColor"] ?? AppColors.primaryBlue;
        return Padding(
          padding: EdgeInsets.only(
            top: 14,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Category tag and duration
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      day["workoutType"] ?? "Workout",
                      style: GoogleFonts.mulish(
                        color: accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        day["duration"] ?? "25m",
                        style: GoogleFonts.mulish(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                day["title"] ?? "Workout Plan",
                style: GoogleFonts.mulish(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Scheduled for ${day['day']}, ${CalendarUtils.monthName(currentMonday.month)} ${day['date']}",
                style: GoogleFonts.mulish(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 20),
              Text(
                "Routine Breakdown",
                style: GoogleFonts.mulish(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              ...exercises.map(
                (ex) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accentColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          ex,
                          style: GoogleFonts.mulish(
                            color: Colors.white.withValues(alpha: 0.88),
                            fontSize: 13.5,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Start Workout Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF20B76F),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        content: Text(
                          "Starting ${day['title']} session! Let's crush it! 💪",
                          style: GoogleFonts.mulish(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Start Workout",
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        centerTitle: false,
        title: Text(
          AppTexts.trainingCalendar,
          style: GoogleFonts.mulish(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          WeekInfoSection(
            weekText: "Week $currentWeekNumber/$totalWeeksInMonth",
            dateRange: currentWeekRange,
            totalTime: AppTexts.total60Min,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: weekDays.length + 1,
              separatorBuilder: (context, index) {
                if (index == weekDays.length - 1) {
                  return const SizedBox.shrink();
                }
                return Divider(
                  color: Colors.white.withValues(alpha: 0.08),
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                );
              },
              itemBuilder: (context, index) {
                if (index == weekDays.length) {
                  final nextWeekNum = currentWeekNumber + 1;
                  return Column(
                    children: [
                      const SizedBox(height: 8),
                      WeekInfoSection(
                        weekText: "Week $nextWeekNum/$totalWeeksInMonth",
                        dateRange: nextWeekRange,
                        totalTime: AppTexts.total70Min,
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }

                final day = weekDays[index];
                final bool hasWorkout = day["hasWorkout"] == true;

                return DragTarget<int>(
                  onAcceptWithDetails: (details) {
                    final fromIndex = details.data;
                    if (fromIndex != index) {
                      moveWorkout(fromIndex, index);
                    }
                  },
                  builder: (context, candidateData, rejectedData) {
                    final isHovering = candidateData.isNotEmpty;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isHovering
                            ? AppColors.primaryBlue.withValues(alpha: 0.15)
                            : Colors.transparent,
                        border: isHovering
                            ? Border.all(
                                color: const Color(0xFF00C896),
                                width: 1.5,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6.0,
                          horizontal: 10.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Day & Date indicator
                            SizedBox(
                              width: 44,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    day["day"] ?? "",
                                    style: GoogleFonts.mulish(
                                      color: Colors.white.withValues(
                                        alpha: hasWorkout ? 0.95 : 0.35,
                                      ),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    day["date"] ?? "",
                                    style: GoogleFonts.mulish(
                                      color: Colors.white.withValues(
                                        alpha: hasWorkout ? 1.0 : 0.35,
                                      ),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Workout Card or Rest Day Placeholder
                            if (hasWorkout)
                              Expanded(
                                child: LongPressDraggable<int>(
                                  data: index,
                                  feedback: Material(
                                    color: Colors.transparent,
                                    child: Opacity(
                                      opacity: 0.92,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                            80,
                                        child: WorkoutContainer(
                                          type: day["workoutType"] ?? "Workout",
                                          color:
                                              day["workoutColor"] ??
                                              AppColors.primaryBlue,
                                          iconPath:
                                              day["icon"] ??
                                              AppImages.exerciseIcon,
                                          title: day["title"] ?? "Workout",
                                          duration: day["duration"] ?? "20m",
                                        ),
                                      ),
                                    ),
                                  ),
                                  childWhenDragging: Opacity(
                                    opacity: 0.25,
                                    child: WorkoutContainer(
                                      type: day["workoutType"] ?? "Workout",
                                      color:
                                          day["workoutColor"] ??
                                          AppColors.primaryBlue,
                                      iconPath:
                                          day["icon"] ?? AppImages.exerciseIcon,
                                      title: day["title"] ?? "Workout",
                                      duration: day["duration"] ?? "20m",
                                    ),
                                  ),
                                  child: WorkoutContainer(
                                    type: day["workoutType"] ?? "Workout",
                                    color:
                                        day["workoutColor"] ??
                                        AppColors.primaryBlue,
                                    iconPath:
                                        day["icon"] ?? AppImages.exerciseIcon,
                                    title: day["title"] ?? "Workout",
                                    duration: day["duration"] ?? "20m",
                                    onTap: () => _showWorkoutDetails(day),
                                  ),
                                ),
                              )
                            else
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.02),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.04,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.bedtime_outlined,
                                        size: 16,
                                        color: Colors.white.withValues(
                                          alpha: 0.25,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "Rest Day / Drag workout here",
                                          style: GoogleFonts.mulish(
                                            color: Colors.white.withValues(
                                              alpha: isHovering ? 0.8 : 0.28,
                                            ),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
