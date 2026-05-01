import 'package:flutter_riverpod/legacy.dart';
import '../models/chemist_shop.dart';

class ChemistShopState {
  final List<ChemistShopModel> allShops;
  final List<ChemistShopModel> filteredShops;
  final String searchQuery;
  final bool isLoading;

  ChemistShopState({
    required this.allShops,
    required this.filteredShops,
    this.searchQuery = '',
    this.isLoading = false,
  });

  ChemistShopState copyWith({
    List<ChemistShopModel>? allShops,
    List<ChemistShopModel>? filteredShops,
    String? searchQuery,
    bool? isLoading,
  }) {
    return ChemistShopState(
      allShops: allShops ?? this.allShops,
      filteredShops: filteredShops ?? this.filteredShops,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChemistShopNotifier extends StateNotifier<ChemistShopState> {
  ChemistShopNotifier() : super(ChemistShopState(allShops: [], filteredShops: [])) {
    _loadMockShops();
  }

  void _loadMockShops() {
    final mock = [
      ChemistShopModel(
        id: '1',
        name: 'Wellness Pharmacy',
        address: 'Ballygunge Circular Road, Kolkata',
        description: 'Leading pharmacy in South Kolkata with 24/7 service and home delivery options.',
        phone: '+91 98301 22334',
        email: 'wellness.bally@gmail.com',
      ),
      ChemistShopModel(
        id: '2',
        name: 'LifeCare Medicos',
        address: 'Salt Lake Sector 3, Kolkata',
        description: 'Authorized dealer for major pharmaceutical brands with specialized refrigerator storage.',
        phone: '+91 98302 55667',
        email: 'lifecare.sl@care.com',
      ),
    ];
    state = state.copyWith(allShops: mock, filteredShops: mock);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void _applyFilters() {
    if (state.searchQuery.isEmpty) {
      state = state.copyWith(filteredShops: state.allShops);
    } else {
      final filtered = state.allShops
          .where((s) => s.name.toLowerCase().contains(state.searchQuery.toLowerCase()))
          .toList();
      state = state.copyWith(filteredShops: filtered);
    }
  }

  void addShop(ChemistShopModel shop) {
    final newList = [...state.allShops, shop];
    state = state.copyWith(allShops: newList);
    _applyFilters();
  }

  void updateShop(ChemistShopModel shop) {
    final newList = state.allShops.map((s) => s.id == shop.id ? shop : s).toList();
    state = state.copyWith(allShops: newList);
    _applyFilters();
  }
}

final chemistShopNotifierProvider = StateNotifierProvider<ChemistShopNotifier, ChemistShopState>((ref) {
  return ChemistShopNotifier();
});
