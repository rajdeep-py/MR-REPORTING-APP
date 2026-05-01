class RoutineTask {
  final String id;
  final String title;
  final String time;
  final bool isCompleted;

  RoutineTask({
    required this.id,
    required this.title,
    required this.time,
    this.isCompleted = false,
  });

  RoutineTask copyWith({bool? isCompleted}) {
    return RoutineTask(
      id: id,
      title: title,
      time: time,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class RoutineModel {
  final DateTime date;
  final List<RoutineTask> tasks;

  RoutineModel({required this.date, required this.tasks});
}
