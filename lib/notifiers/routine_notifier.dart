import 'package:flutter_riverpod/legacy.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/routine.dart';

class RoutineState {
  final List<RoutineModel> routines;
  final DateTime selectedDate;

  RoutineState({required this.routines, required this.selectedDate});

  RoutineState copyWith({
    List<RoutineModel>? routines,
    DateTime? selectedDate,
  }) {
    return RoutineState(
      routines: routines ?? this.routines,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class RoutineNotifier extends StateNotifier<RoutineState> {
  RoutineNotifier()
    : super(RoutineState(routines: [], selectedDate: DateTime.now())) {
    _loadMockRoutines();
  }

  void setSelectedDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void toggleTaskCompletion(DateTime date, String taskId) {
    final newList = state.routines.map((routine) {
      if (isSameDay(routine.date, date)) {
        final newTasks = routine.tasks.map((task) {
          if (task.id == taskId)
            return task.copyWith(isCompleted: !task.isCompleted);
          return task;
        }).toList();
        return RoutineModel(date: routine.date, tasks: newTasks);
      }
      return routine;
    }).toList();
    state = state.copyWith(routines: newList);
  }

  void _loadMockRoutines() {
    final now = DateTime.now();
    state = state.copyWith(
      routines: [
        RoutineModel(
          date: DateTime(now.year, now.month, now.day),
          tasks: [
            RoutineTask(id: '1', title: 'Visit Dr. Sharma', time: '10:00 AM'),
            RoutineTask(
              id: '2',
              title: 'Chemist Call - South Mumbai',
              time: '12:30 PM',
            ),
            RoutineTask(id: '3', title: 'Lunch with Team', time: '02:00 PM'),
            RoutineTask(
              id: '4',
              title: 'Inventory Check at Stockist',
              time: '04:30 PM',
            ),
          ],
        ),
        RoutineModel(
          date: DateTime(now.year, now.month, now.day + 1),
          tasks: [
            RoutineTask(
              id: '5',
              title: 'Early Morning Call - Dr. Patel',
              time: '09:00 AM',
            ),
            RoutineTask(
              id: '6',
              title: 'Product Demo - New Visual Ads',
              time: '11:00 AM',
            ),
          ],
        ),
        RoutineModel(
          date: DateTime(now.year, now.month, now.day - 1),
          tasks: [
            RoutineTask(
              id: '7',
              title: 'Routine Visit 1',
              time: '10:00 AM',
              isCompleted: true,
            ),
            RoutineTask(
              id: '8',
              title: 'Routine Visit 2',
              time: '11:30 AM',
              isCompleted: true,
            ),
          ],
        ),
      ],
    );
  }
}
