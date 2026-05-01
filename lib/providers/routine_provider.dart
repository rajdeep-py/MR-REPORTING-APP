import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/routine_notifier.dart';

final routineProvider = StateNotifierProvider<RoutineNotifier, RoutineState>((ref) {
  return RoutineNotifier();
});
