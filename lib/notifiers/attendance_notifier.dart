import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/attendance.dart';

class AttendanceState {
  final List<AttendanceModel> attendanceList;
  final DateTime selectedDate;
  final bool isLoading;

  AttendanceState({
    required this.attendanceList,
    required this.selectedDate,
    this.isLoading = false,
  });

  AttendanceState copyWith({
    List<AttendanceModel>? attendanceList,
    DateTime? selectedDate,
    bool? isLoading,
  }) {
    return AttendanceState(
      attendanceList: attendanceList ?? this.attendanceList,
      selectedDate: selectedDate ?? this.selectedDate,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AttendanceNotifier extends StateNotifier<AttendanceState> {
  AttendanceNotifier()
      : super(AttendanceState(
          attendanceList: [],
          selectedDate: DateTime.now(),
        )) {
    _loadMockData();
  }

  void setSelectedDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void _loadMockData() {
    final now = DateTime.now();
    final mockData = [
      AttendanceModel(
        date: DateTime(now.year, now.month, now.day),
        isPresent: true,
        checkIn: "09:15 AM",
        checkOut: "06:30 PM",
        breakIn: "01:00 PM",
        breakOut: "01:45 PM",
      ),
      AttendanceModel(
        date: DateTime(now.year, now.month, now.day - 1),
        isPresent: true,
        checkIn: "09:05 AM",
        checkOut: "06:15 PM",
        breakIn: "01:10 PM",
        breakOut: "02:00 PM",
      ),
      AttendanceModel(
        date: DateTime(now.year, now.month, now.day - 2),
        isPresent: false,
      ),
      AttendanceModel(
        date: DateTime(now.year, now.month, now.day - 3),
        isPresent: true,
        checkIn: "09:20 AM",
        checkOut: "06:45 PM",
        breakIn: "01:15 PM",
        breakOut: "01:55 PM",
      ),
    ];
    state = state.copyWith(attendanceList: mockData);
  }
}
