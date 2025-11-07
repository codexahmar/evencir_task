import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:evencir_task/utils/calendar_utils.dart';

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
    // Week starts on Monday
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
    final screenWidth = MediaQuery.of(context).size.width;
    final weekNumber = getWeekNumber(selectedDay);
    final totalWeeks = getTotalWeeks(selectedDay);

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
            GestureDetector(
              onTap: () {
                CalendarUtils.showFullCalendar(
                  context: context,
                  focusedDay: focusedDay,
                  selectedDay: selectedDay,
                  onDaySelected: onDaySelected,
                );
              },
              child: Row(
                children: [
                  Text(
                    "Week $weekNumber/$totalWeeks",
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
            ),
          ],
        ),
        SizedBox(width: screenWidth * 0.06),
      ],
    );
  }
}
