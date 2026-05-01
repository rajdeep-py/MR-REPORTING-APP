import 'package:flutter_riverpod/legacy.dart';
import '../notifiers/attendance_notifier.dart';

final attendanceProvider =
    StateNotifierProvider<AttendanceNotifier, AttendanceState>((ref) {
      return AttendanceNotifier();
    });
