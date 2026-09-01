import 'package:evencir_task/utils/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    const dayNames = ["M", "TU", "W", "TH", "F", "SA", "SU"];

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final day = currentWeekDays[index];
              final isSelected = isSameDay(day, selectedDay);
              final isToday = isSameDay(day, DateTime.now());

              return GestureDetector(
                onTap: () {
                  onDaySelected(day, day);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF00C896).withValues(alpha: 0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected
                        ? Border.all(
                            color: const Color(0xFF00C896),
                            width: 1.5,
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        dayNames[index],
                        style: GoogleFonts.mulish(
                          color: isSelected
                              ? const Color(0xFF00C896)
                              : Colors.white.withValues(alpha: 0.4),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 34,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF00C896)
                              : const Color(0xFF222228),
                          shape: BoxShape.circle,
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF00C896).withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          "${day.day}",
                          style: GoogleFonts.manrope(
                            color: isSelected ? Colors.black : Colors.white,
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.w800
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (isToday && !isSelected)
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Color(0xFF00C896),
                            shape: BoxShape.circle,
                          ),
                        )
                      else
                        const SizedBox(height: 4),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),

          // Calendar drag handle button
          GestureDetector(
            onTap: () {
              CalendarUtils.showFullCalendar(
                context: context,
                focusedDay: focusedDay,
                selectedDay: selectedDay,
                onDaySelected: onDaySelected,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
