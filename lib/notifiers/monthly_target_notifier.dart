import 'package:flutter_riverpod/legacy.dart';
import '../models/monthly_target.dart';

class MonthlyTargetState {
  final List<MonthlyTargetModel> allTargets;
  final int selectedMonth;
  final int selectedYear;

  MonthlyTargetState({
    required this.allTargets,
    required this.selectedMonth,
    required this.selectedYear,
  });

  MonthlyTargetState copyWith({
    List<MonthlyTargetModel>? allTargets,
    int? selectedMonth,
    int? selectedYear,
  }) {
    return MonthlyTargetState(
      allTargets: allTargets ?? this.allTargets,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedYear: selectedYear ?? this.selectedYear,
    );
  }
}

class MonthlyTargetNotifier extends StateNotifier<MonthlyTargetState> {
  MonthlyTargetNotifier()
    : super(
        MonthlyTargetState(
          allTargets: [],
          selectedMonth: DateTime.now().month,
          selectedYear: DateTime.now().year,
        ),
      ) {
    _loadMockData();
  }

  void _loadMockData() {
    state = state.copyWith(
      allTargets: [
        MonthlyTargetModel(id: '1', month: 4, year: 2026, targetAmount: 500000),
        MonthlyTargetModel(id: '2', month: 5, year: 2026, targetAmount: 600000),
      ],
    );
  }

  void setMonth(int month) => state = state.copyWith(selectedMonth: month);
  void setYear(int year) => state = state.copyWith(selectedYear: year);

  MonthlyTargetModel? get currentTarget {
    try {
      return state.allTargets.firstWhere(
        (t) => t.month == state.selectedMonth && t.year == state.selectedYear,
      );
    } catch (_) {
      return null;
    }
  }
}

final monthlyTargetNotifierProvider =
    StateNotifierProvider<MonthlyTargetNotifier, MonthlyTargetState>((ref) {
      return MonthlyTargetNotifier();
    });
