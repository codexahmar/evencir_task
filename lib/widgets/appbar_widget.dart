import 'package:evencir_task/constants/app_colors.dart';
import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/utils/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final Function(DateTime, DateTime) onDaySelected;

  const AppBarWidget({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
  });

  int getWeekNumber(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    final offset = firstWeekday == DateTime.monday ? 0 : (8 - firstWeekday);
    final firstMonday = firstDayOfMonth.add(Duration(days: offset));
    if (date.isBefore(firstMonday)) {
      return 1;
    }
    return ((date.day + firstDayOfMonth.weekday - 2) ~/ 7) + 1;
  }

  int getTotalWeeks(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday;
    final totalDays = daysInMonth + (firstWeekday - 1);
    return ((totalDays - 1) ~/ 7) + 1;
  }

  @override
  Widget build(BuildContext context) {
    final weekNumber = getWeekNumber(selectedDay);
    final totalWeeks = getTotalWeeks(selectedDay);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Bell Notification Button with unread indicator
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color(0xFF1E1E28),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                content: Text(
                  "You have 2 upcoming workout reminders today.",
                  style: GoogleFonts.mulish(color: Colors.white, fontSize: 13),
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  AppImages.bellIcon,
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
                Positioned(
                  right: -1,
                  top: -1,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00C896),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Week Selector Pill Button
        InkWell(
          onTap: () {
            CalendarUtils.showFullCalendar(
              context: context,
              focusedDay: focusedDay,
              selectedDay: selectedDay,
              onDaySelected: onDaySelected,
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImages.moonIcon,
                  width: 16,
                  height: 16,
                  color: const Color(0xFF818CF8),
                ),
                const SizedBox(width: 8),
                Text(
                  "Week $weekNumber/$totalWeeks",
                  style: GoogleFonts.mulish(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                Image.asset(
                  AppImages.dropDownIcon,
                  width: 12,
                  height: 12,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ),

        // Quick Stats / Flame Streak icon
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF99955).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFF99955).withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.local_fire_department_rounded,
                size: 16,
                color: Color(0xFFF99955),
              ),
              const SizedBox(width: 3),
              Text(
                "12",
                style: GoogleFonts.manrope(
                  color: const Color(0xFFF99955),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
