import 'package:flutter/material.dart';
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
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFF18181C),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: focusedDay,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white70),
                  weekendStyle: TextStyle(color: Colors.white70),
                ),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF00C896), width: 2),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF00C896), width: 2),
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: const BoxDecoration(
                    color: Color(0xFF2A2A2A),
                    shape: BoxShape.circle,
                  ),
                  weekendDecoration: const BoxDecoration(
                    color: Color(0xFF2A2A2A),
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(color: Colors.white),
                  weekendTextStyle: TextStyle(color: Colors.white),
                  outsideTextStyle: TextStyle(color: Colors.grey),
                ),
                onDaySelected: (selected, focused) {
                  onDaySelected(selected, focused);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 30),
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
