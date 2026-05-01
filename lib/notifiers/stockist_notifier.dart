import 'package:flutter_riverpod/legacy.dart';
import '../models/stockist.dart';

class StockistState {
  final List<StockistModel> allStockists;
  final List<StockistModel> filteredStockists;
  final String searchQuery;
  final bool isLoading;

  StockistState({
    required this.allStockists,
    required this.filteredStockists,
    this.searchQuery = '',
    this.isLoading = false,
  });

  StockistState copyWith({
    List<StockistModel>? allStockists,
    List<StockistModel>? filteredStockists,
    String? searchQuery,
    bool? isLoading,
  }) {
    return StockistState(
      allStockists: allStockists ?? this.allStockists,
      filteredStockists: filteredStockists ?? this.filteredStockists,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class StockistNotifier extends StateNotifier<StockistState> {
  StockistNotifier()
    : super(StockistState(allStockists: [], filteredStockists: [])) {
    _loadMockStockists();
  }

  void _loadMockStockists() {
    final mock = [
      StockistModel(
        id: '1',
        name: 'Bharat Pharma Distributors',
        address: 'Chandni Chowk, Delhi',
        description:
            'Major stockist for North India specializing in generic and branded life-saving drugs.',
        phone: '+91 98100 22334',
        email: 'bharat.pharma@dist.com',
        minOrderValue: '₹25,000',
        expectedDeliveryTime: '24-48 Hours',
        medicinesInterestedIn: 'Antibiotics, Vaccines, Cardiology',
      ),
      StockistModel(
        id: '2',
        name: 'Apex Medical Agencies',
        address: 'Park Street, Kolkata',
        description:
            'One of the oldest stockists in West Bengal with a massive cold storage facility.',
        phone: '+91 98300 55667',
        email: 'apex.med@agencies.com',
        minOrderValue: '₹15,000',
        expectedDeliveryTime: 'Same Day (within city)',
        medicinesInterestedIn: 'Oncology, Nephrology, Ortho',
      ),
    ];
    state = state.copyWith(allStockists: mock, filteredStockists: mock);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void _applyFilters() {
    if (state.searchQuery.isEmpty) {
      state = state.copyWith(filteredStockists: state.allStockists);
    } else {
      final filtered = state.allStockists
          .where(
            (s) =>
                s.name.toLowerCase().contains(state.searchQuery.toLowerCase()),
          )
          .toList();
      state = state.copyWith(filteredStockists: filtered);
    }
  }

  void addStockist(StockistModel stockist) {
    final newList = [...state.allStockists, stockist];
    state = state.copyWith(allStockists: newList);
    _applyFilters();
  }

  void updateStockist(StockistModel stockist) {
    final newList = state.allStockists
        .map((s) => s.id == stockist.id ? stockist : s)
        .toList();
    state = state.copyWith(allStockists: newList);
    _applyFilters();
  }
}

final stockistNotifierProvider =
    StateNotifierProvider<StockistNotifier, StockistState>((ref) {
      return StockistNotifier();
    });
