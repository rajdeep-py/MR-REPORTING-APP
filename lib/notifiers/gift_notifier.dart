import 'package:flutter_riverpod/legacy.dart';
import '../models/gift.dart';

class GiftState {
  final List<GiftModel> allGifts;
  final List<GiftModel> filteredGifts;
  final String? filterDoctorId;
  final DateTime? filterDate;

  GiftState({
    required this.allGifts,
    required this.filteredGifts,
    this.filterDoctorId,
    this.filterDate,
  });

  GiftState copyWith({
    List<GiftModel>? allGifts,
    List<GiftModel>? filteredGifts,
    String? filterDoctorId,
    DateTime? filterDate,
  }) {
    return GiftState(
      allGifts: allGifts ?? this.allGifts,
      filteredGifts: filteredGifts ?? this.filteredGifts,
      filterDoctorId: filterDoctorId,
      filterDate: filterDate,
    );
  }
}

class GiftNotifier extends StateNotifier<GiftState> {
  GiftNotifier() : super(GiftState(allGifts: [], filteredGifts: []));

  void setInitialData(List<GiftModel> data) {
    state = state.copyWith(allGifts: data, filteredGifts: data);
  }

  void addGift(GiftModel gift) {
    final newList = [...state.allGifts, gift];
    state = state.copyWith(allGifts: newList);
    _applyFilters();
  }

  void removeGift(String id) {
    final newList = state.allGifts.where((g) => g.id != id).toList();
    state = state.copyWith(allGifts: newList);
    _applyFilters();
  }

  void setFilterDoctor(String? doctorId) {
    state = state.copyWith(filterDoctorId: doctorId);
    _applyFilters();
  }

  void setFilterDate(DateTime? date) {
    state = state.copyWith(filterDate: date);
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = state.allGifts;

    if (state.filterDoctorId != null) {
      filtered = filtered
          .where((g) => g.doctor.id == state.filterDoctorId)
          .toList();
    }

    if (state.filterDate != null) {
      final dateStr = state.filterDate!.toIso8601String().split('T')[0];
      filtered = filtered.where((g) => g.date == dateStr).toList();
    }

    state = state.copyWith(filteredGifts: filtered);
  }
}

final giftNotifierProvider = StateNotifierProvider<GiftNotifier, GiftState>((
  ref,
) {
  return GiftNotifier();
});
