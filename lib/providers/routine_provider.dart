import 'package:flutter_riverpod/legacy.dart';
import '../notifiers/routine_notifier.dart';

final routineProvider = StateNotifierProvider<RoutineNotifier, RoutineState>((
  ref,
) {
  return RoutineNotifier();
});
