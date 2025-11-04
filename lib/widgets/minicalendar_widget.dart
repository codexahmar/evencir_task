import 'package:evencir_task/utils/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MiniCalendarWidget extends StatelessWidget {
  final List<DateTime> currentWeekDays;
  final DateTime selectedDay;
  final DateTime focusedDay;
  final Function(DateTime, DateTime) onDaySelected;

  const MiniCalendarWidget({
    super.key,
    required this.currentWeekDays,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaHeight = screenHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! > 5) {
          CalendarUtils.showFullCalendar(
            context: context,
            focusedDay: focusedDay,
            selectedDay: selectedDay,
            onDaySelected: onDaySelected,
          );
        }
      },
      onTap: () {
        CalendarUtils.showFullCalendar(
          context: context,
          focusedDay: focusedDay,
          selectedDay: selectedDay,
          onDaySelected: onDaySelected,
        );
      },
      child: Column(
        children: [
          SizedBox(height: safeAreaHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final day = currentWeekDays[index];
              final isSelected = isSameDay(day, selectedDay);

              const dayNames = ["M", "TU", "W", "TH", "F", "SA", "SU"];

              return Column(
                children: [
                  Text(
                    dayNames[index],
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.03,
                    ),
                  ),
                  SizedBox(height: safeAreaHeight * 0.008),
                  Container(
                    width: screenWidth * 0.095,
                    height: screenWidth * 0.095,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBEBEB).withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                              color: const Color(0xFF00C896),
                              width: 2,
                            )
                          : null,
                    ),
                    child: Text(
                      "${day.day}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: safeAreaHeight * 0.006),
                  if (isSelected)
                    Container(
                      width: screenWidth * 0.016,
                      height: screenWidth * 0.016,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00C896),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              );
            }),
          ),
          SizedBox(height: safeAreaHeight * 0.015),
          Center(
            child: Container(
              width: screenWidth * 0.13,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}