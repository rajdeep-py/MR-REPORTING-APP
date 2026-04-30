import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
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
    : super(AttendanceState(attendanceList: [], selectedDate: DateTime.now())) {
    _loadMockData();
  }

  void setSelectedDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  AttendanceModel? get todayAttendance {
    final now = DateTime.now();
    try {
      return state.attendanceList.firstWhere((a) => isSameDay(a.date, now));
    } catch (_) {
      return null;
    }
  }

  Future<void> checkIn() async {
    final now = DateTime.now();
    final time = DateFormat('hh:mm a').format(now);
    _updateTodayRecord(checkIn: time, isPresent: true);
  }

  Future<void> checkOut() async {
    final now = DateTime.now();
    final time = DateFormat('hh:mm a').format(now);
    _updateTodayRecord(checkOut: time);
  }

  Future<void> breakIn() async {
    final now = DateTime.now();
    final time = DateFormat('hh:mm a').format(now);
    _updateTodayRecord(breakIn: time);
  }

  Future<void> breakOut() async {
    final now = DateTime.now();
    final time = DateFormat('hh:mm a').format(now);
    _updateTodayRecord(breakOut: time);
  }

  void _updateTodayRecord({
    String? checkIn,
    String? checkOut,
    String? breakIn,
    String? breakOut,
    bool? isPresent,
  }) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    List<AttendanceModel> newList = List.from(state.attendanceList);
    int index = newList.indexWhere((a) => isSameDay(a.date, today));

    if (index != -1) {
      final existing = newList[index];
      newList[index] = AttendanceModel(
        date: existing.date,
        isPresent: isPresent ?? existing.isPresent,
        checkIn: checkIn ?? existing.checkIn,
        checkOut: checkOut ?? existing.checkOut,
        breakIn: breakIn ?? existing.breakIn,
        breakOut: breakOut ?? existing.breakOut,
      );
    } else {
      newList.add(
        AttendanceModel(
          date: today,
          isPresent: isPresent ?? false,
          checkIn: checkIn,
          checkOut: checkOut,
          breakIn: breakIn,
          breakOut: breakOut,
        ),
      );
    }

    state = state.copyWith(attendanceList: newList);
  }

  void _loadMockData() {
    final now = DateTime.now();
    final mockData = [
      // Today will be empty or updated by actions
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
