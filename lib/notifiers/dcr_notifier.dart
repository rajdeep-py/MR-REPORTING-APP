import 'package:flutter_riverpod/legacy.dart';
import '../models/dcr.dart';

class DCRState {
  final List<DCRModel> allDCRs;
  final List<DCRModel> filteredDCRs;
  final String? filterStatus;
  final DateTime? filterDate;

  DCRState({
    required this.allDCRs,
    required this.filteredDCRs,
    this.filterStatus,
    this.filterDate,
  });

  DCRState copyWith({
    List<DCRModel>? allDCRs,
    List<DCRModel>? filteredDCRs,
    String? filterStatus,
    DateTime? filterDate,
  }) {
    return DCRState(
      allDCRs: allDCRs ?? this.allDCRs,
      filteredDCRs: filteredDCRs ?? this.filteredDCRs,
      filterStatus: filterStatus,
      filterDate: filterDate,
    );
  }
}

class DCRNotifier extends StateNotifier<DCRState> {
  DCRNotifier() : super(DCRState(allDCRs: [], filteredDCRs: [])) {
    // Initial data would come from repository
  }

  void setInitialData(List<DCRModel> data) {
    state = state.copyWith(allDCRs: data, filteredDCRs: data);
  }

  void addDCR(DCRModel dcr) {
    final newList = [...state.allDCRs, dcr];
    state = state.copyWith(allDCRs: newList);
    _applyFilters();
  }

  void updateDCR(DCRModel dcr) {
    final newList = state.allDCRs.map((e) => e.id == dcr.id ? dcr : e).toList();
    state = state.copyWith(allDCRs: newList);
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
    var filtered = state.allDCRs;

    if (state.filterStatus != null) {
      filtered = filtered
          .where((dcr) => dcr.status.name == state.filterStatus)
          .toList();
    }

    if (state.filterDate != null) {
      final dateStr = state.filterDate!.toIso8601String().split('T')[0];
      filtered = filtered.where((dcr) => dcr.date == dateStr).toList();
    }

    state = state.copyWith(filteredDCRs: filtered);
  }
}

final dcrNotifierProvider = StateNotifierProvider<DCRNotifier, DCRState>((ref) {
  return DCRNotifier();
});
