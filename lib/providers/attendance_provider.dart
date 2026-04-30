import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/attendance_notifier.dart';

final attendanceProvider = StateNotifierProvider<AttendanceNotifier, AttendanceState>((ref) {
  return AttendanceNotifier();
});
