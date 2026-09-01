import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarUtils {
  static DateTime getStartOfWeek(DateTime focusedDay) {
    return focusedDay.subtract(Duration(days: focusedDay.weekday - 1));
  }

  static List<DateTime> getCurrentWeekDays(DateTime focusedDay) {
    final startOfWeek = getStartOfWeek(focusedDay);
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  static void showFullCalendar({
    required BuildContext context,
    required DateTime focusedDay,
    required DateTime selectedDay,
    required Function(DateTime, DateTime) onDaySelected,
  }) {
    showModalBottomSheet(
      backgroundColor: const Color(0xFF14141A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 14,
            left: 12,
            right: 12,
            bottom: MediaQuery.of(context).padding.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Select Date",
                      style: GoogleFonts.mulish(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded, color: Colors.white70, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: focusedDay,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: GoogleFonts.mulish(color: Colors.white60, fontSize: 13),
                  weekendStyle: GoogleFonts.mulish(color: Colors.white60, fontSize: 13),
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  leftChevronIcon: const Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.white,
                  ),
                  rightChevronIcon: const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                  ),
                  titleTextStyle: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xFF00C896),
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: GoogleFonts.manrope(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                  todayDecoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF00C896), width: 1.5),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: GoogleFonts.manrope(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  defaultDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  weekendDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: GoogleFonts.mulish(color: Colors.white),
                  weekendTextStyle: GoogleFonts.mulish(color: Colors.white),
                  outsideTextStyle: GoogleFonts.mulish(color: Colors.white24),
                ),
                onDaySelected: (selected, focused) {
                  onDaySelected(selected, focused);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  static String monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }

  static String formattedDate(DateTime date) {
    const monthsFull = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return "${monthsFull[date.month - 1]} ${date.day}";
  }
}
