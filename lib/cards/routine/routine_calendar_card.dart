import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/app_theme.dart';
import '../../models/routine.dart';

class RoutineCalendarCard extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final List<RoutineModel> routines;
  final Function(DateTime, DateTime) onDaySelected;

  const RoutineCalendarCard({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.routines,
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
        ),
        calendarStyle: const CalendarStyle(
          selectedDecoration: BoxDecoration(color: AppColors.black, shape: BoxShape.circle),
          todayDecoration: BoxDecoration(color: AppColors.lightGrey, shape: BoxShape.circle),
          todayTextStyle: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            final hasRoutine = routines.any((r) => isSameDay(r.date, date));
            if (!hasRoutine) return const SizedBox.shrink();

            return Container(
              margin: const EdgeInsets.only(top: 25),
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
