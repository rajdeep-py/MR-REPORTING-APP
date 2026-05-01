import 'package:flutter_riverpod/legacy.dart';
import '../models/chemist_shop_reporting.dart';

class ChemistReportingState {
  final List<ChemistShopReportingModel> allReports;
  final List<ChemistShopReportingModel> filteredReports;
  final String? filterStatus;
  final DateTime? filterDate;

  ChemistReportingState({
    required this.allReports,
    required this.filteredReports,
    this.filterStatus,
    this.filterDate,
  });

  ChemistReportingState copyWith({
    List<ChemistShopReportingModel>? allReports,
    List<ChemistShopReportingModel>? filteredReports,
    String? filterStatus,
    DateTime? filterDate,
  }) {
    return ChemistReportingState(
      allReports: allReports ?? this.allReports,
      filteredReports: filteredReports ?? this.filteredReports,
      filterStatus: filterStatus,
      filterDate: filterDate,
    );
  }
}

class ChemistReportingNotifier extends StateNotifier<ChemistReportingState> {
  ChemistReportingNotifier()
    : super(ChemistReportingState(allReports: [], filteredReports: [])) {
    // Initial data can be loaded here
  }

  void setInitialData(List<ChemistShopReportingModel> data) {
    state = state.copyWith(allReports: data, filteredReports: data);
  }

  void addReport(ChemistShopReportingModel report) {
    final newList = [...state.allReports, report];
    state = state.copyWith(allReports: newList);
    _applyFilters();
  }

  void updateReport(ChemistShopReportingModel report) {
    final newList = state.allReports
        .map((e) => e.id == report.id ? report : e)
        .toList();
    state = state.copyWith(allReports: newList);
    _applyFilters();
  }

  void setFilterStatus(String? status) {
    state = state.copyWith(filterStatus: status);
    _applyFilters();
  }

  void setFilterDate(DateTime? date) {
    state = state.copyWith(filterDate: date);
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = state.allReports;

    if (state.filterStatus != null) {
      filtered = filtered
          .where((r) => r.status.name == state.filterStatus)
          .toList();
    }

    if (state.filterDate != null) {
      final dateStr = state.filterDate!.toIso8601String().split('T')[0];
      filtered = filtered.where((r) => r.date == dateStr).toList();
    }

    state = state.copyWith(filteredReports: filtered);
  }
}

final chemistReportingNotifierProvider =
    StateNotifierProvider<ChemistReportingNotifier, ChemistReportingState>((
      ref,
    ) {
      return ChemistReportingNotifier();
    });
