import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:collection/collection.dart';
import '../../routes/app_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../providers/attendance_provider.dart';
import '../../cards/attendance/attendance_calendar_card.dart';
import '../../cards/attendance/attendance_details_card.dart';

class AttendanceRecordScreen extends ConsumerStatefulWidget {
  const AttendanceRecordScreen({super.key});

  @override
  ConsumerState<AttendanceRecordScreen> createState() =>
      _AttendanceRecordScreenState();
}

class _AttendanceRecordScreenState
    extends ConsumerState<AttendanceRecordScreen> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final attendanceState = ref.watch(attendanceProvider);

    // Safely find the record for the selected date using collection package
    final record = attendanceState.attendanceList.firstWhereOrNull(
      (a) => isSameDay(a.date, attendanceState.selectedDate),
    );

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.home);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: const SideNavBar(currentRoute: '/attendance'),
        appBar: const CustomAppBar(
          title: 'Attendance Record',
          subtitle: 'Track your daily presence',
          showDrawerButton: true,
          showBackButton: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppGaps.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AttendanceCalendarCard(
                selectedDay: attendanceState.selectedDate,
                focusedDay: _focusedDay,
                attendanceList: attendanceState.attendanceList,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                  ref
                      .read(attendanceProvider.notifier)
                      .setSelectedDate(selectedDay);
                },
              ),
              AppGaps.largeV,
              Text(
                'DETAILS',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              AppGaps.mediumV,
              AttendanceDetailsCard(
                selectedDate: attendanceState.selectedDate,
                attendance: record,
              ),
              AppGaps.extraLargeV,
            ],
          ),
        ),
      ),
    );
  }
}
