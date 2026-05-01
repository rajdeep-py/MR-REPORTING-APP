import 'package:flutter_riverpod/legacy.dart';
import '../models/expense.dart';

class ExpenseState {
  final List<ExpenseModel> allExpenses;
  final List<ExpenseModel> filteredExpenses;
  final int selectedMonth; // 1-12
  final int selectedYear;

  ExpenseState({
    required this.allExpenses,
    required this.filteredExpenses,
    required this.selectedMonth,
    required this.selectedYear,
  });

  ExpenseState copyWith({
    List<ExpenseModel>? allExpenses,
    List<ExpenseModel>? filteredExpenses,
    int? selectedMonth,
    int? selectedYear,
  }) {
    return ExpenseState(
      allExpenses: allExpenses ?? this.allExpenses,
      filteredExpenses: filteredExpenses ?? this.filteredExpenses,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedYear: selectedYear ?? this.selectedYear,
    );
  }
}

class ExpenseNotifier extends StateNotifier<ExpenseState> {
  ExpenseNotifier()
    : super(
        ExpenseState(
          allExpenses: [],
          filteredExpenses: [],
          selectedMonth: DateTime.now().month,
          selectedYear: DateTime.now().year,
        ),
      ) {
    _loadMockData();
  }

  void _loadMockData() {
    final now = DateTime.now();
    final mock = [
      ExpenseModel(
        id: 'EXP001',
        date: now.subtract(const Duration(days: 1)),
        items: [
          ExpenseItem(title: 'Travel - Local', amount: 450.0),
          ExpenseItem(title: 'Lunch with Dr. Sharma', amount: 800.0),
        ],
        proofImages: [],
        status: ExpenseStatus.pending,
      ),
      ExpenseModel(
        id: 'EXP002',
        date: now.subtract(const Duration(days: 5)),
        items: [ExpenseItem(title: 'Stationery', amount: 200.0)],
        proofImages: [],
        status: ExpenseStatus.received,
      ),
    ];
    state = state.copyWith(allExpenses: mock);
    _applyFilters();
  }

  void addExpense(ExpenseModel expense) {
    final newList = [...state.allExpenses, expense];
    state = state.copyWith(allExpenses: newList);
    _applyFilters();
  }

  void setFilter(int month, int year) {
    state = state.copyWith(selectedMonth: month, selectedYear: year);
    _applyFilters();
  }

  void _applyFilters() {
    final filtered = state.allExpenses.where((exp) {
      return exp.date.month == state.selectedMonth &&
          exp.date.year == state.selectedYear;
    }).toList();

    // Sort by date descending
    filtered.sort((a, b) => b.date.compareTo(a.date));

    state = state.copyWith(filteredExpenses: filtered);
  }
}

final expenseNotifierProvider =
    StateNotifierProvider<ExpenseNotifier, ExpenseState>((ref) {
      return ExpenseNotifier();
    });
