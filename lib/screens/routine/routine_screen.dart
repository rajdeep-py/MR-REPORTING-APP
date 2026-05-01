import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:collection/collection.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../providers/routine_provider.dart';
import '../../cards/routine/routine_calendar_card.dart';
import '../../cards/routine/routine_details_card.dart';

class RoutineScreen extends ConsumerStatefulWidget {
  const RoutineScreen({super.key});

  @override
  ConsumerState<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends ConsumerState<RoutineScreen> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final routineState = ref.watch(routineProvider);
    final routineNotifier = ref.read(routineProvider.notifier);

    // Safely find the routine for the selected date
    final routine = routineState.routines.firstWhereOrNull(
      (r) => isSameDay(r.date, routineState.selectedDate),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const SideNavBar(currentRoute: '/routine'),
      appBar: const CustomAppBar(
        title: 'My Routine',
        subtitle: 'Plan your day effectively',
        showDrawerButton: true,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoutineCalendarCard(
              selectedDay: routineState.selectedDate,
              focusedDay: _focusedDay,
              routines: routineState.routines,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
                routineNotifier.setSelectedDate(selectedDay);
              },
            ),
            AppGaps.largeV,
            Text(
              'DAILY TASKS',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            AppGaps.mediumV,
            RoutineDetailsCard(
              selectedDate: routineState.selectedDate,
              routine: routine,
              onToggleTask: (taskId) => routineNotifier.toggleTaskCompletion(
                routineState.selectedDate,
                taskId,
              ),
            ),
            AppGaps.extraLargeV,
          ],
        ),
      ),
    );
  }
}
