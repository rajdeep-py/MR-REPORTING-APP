import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/app_theme.dart';
import '../../models/attendance.dart';

class AttendanceCalendarCard extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final List<AttendanceModel> attendanceList;
  final Function(DateTime, DateTime) onDaySelected;

  const AttendanceCalendarCard({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.attendanceList,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: onDaySelected,
        calendarFormat: CalendarFormat.month,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
          leftChevronIcon: const Icon(Icons.chevron_left, color: AppColors.black),
          rightChevronIcon: const Icon(Icons.chevron_right, color: AppColors.black),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.black.withAlpha(20),
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: AppColors.black,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          todayTextStyle: const TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
          defaultTextStyle: const TextStyle(color: AppColors.darkGrey),
          weekendTextStyle: const TextStyle(color: AppColors.error),
          outsideDaysVisible: false,
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            final attendance = attendanceList.firstWhere(
              (a) => isSameDay(a.date, date),
              orElse: () => AttendanceModel(date: date, isPresent: false),
            );

            // Only show markers if there is data for that day in our mock list
            bool hasData = attendanceList.any((a) => isSameDay(a.date, date));
            if (!hasData) return const SizedBox.shrink();

            return Container(
              margin: const EdgeInsets.only(top: 25),
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: attendance.isPresent ? AppColors.success : AppColors.error,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
