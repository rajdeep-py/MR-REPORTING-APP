import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:collection/collection.dart';
import 'package:iconsax/iconsax.dart';
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

  void _handleTaskToggle(String taskId, bool currentStatus, DateTime selectedDate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Icon(
              currentStatus ? Iconsax.info_circle : Iconsax.tick_circle,
              color: AppColors.black,
            ),
            const SizedBox(width: 12),
            Text(
              currentStatus ? 'Unmark Task?' : 'Complete Task?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
            ),
          ],
        ),
        content: Text(
          currentStatus
              ? 'Are you sure you want to mark this task as incomplete?'
              : 'Have you finished this task? Marking it will update your daily progress.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, color: AppColors.darkGrey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(color: AppColors.coolGrey, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(routineProvider.notifier).toggleTaskCompletion(selectedDate, taskId);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(currentStatus ? 'Task marked as incomplete' : 'Great job! Task completed.'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: AppColors.black,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('CONFIRM', style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routineState = ref.watch(routineProvider);

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
                ref.read(routineProvider.notifier).setSelectedDate(selectedDay);
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
              onToggleTask: (taskId, currentStatus) => _handleTaskToggle(
                taskId,
                currentStatus,
                routineState.selectedDate,
              ),
            ),
            AppGaps.extraLargeV,
          ],
        ),
      ),
    );
  }
}
