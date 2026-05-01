import 'package:flutter_riverpod/legacy.dart';
import '../models/visual_ads.dart';

class VisualAdsState {
  final List<VisualAdModel> allAds;
  final List<VisualAdModel> filteredAds;
  final String searchQuery;

  VisualAdsState({
    required this.allAds,
    required this.filteredAds,
    this.searchQuery = '',
  });

  VisualAdsState copyWith({
    List<VisualAdModel>? allAds,
    List<VisualAdModel>? filteredAds,
    String? searchQuery,
  }) {
    return VisualAdsState(
      allAds: allAds ?? this.allAds,
      filteredAds: filteredAds ?? this.filteredAds,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class VisualAdsNotifier extends StateNotifier<VisualAdsState> {
  VisualAdsNotifier() : super(VisualAdsState(allAds: [], filteredAds: [])) {
    _loadMockAds();
  }

  void _loadMockAds() {
    final mock = [
      VisualAdModel(
        id: '1',
        productName: 'Orthocal-D3 Max',
        imageUrl: 'https://images.unsplash.com/photo-1584017962801-debd83f1f0a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
      ),
      VisualAdModel(
        id: '2',
        productName: 'CardioSafe Plus',
        imageUrl: 'https://images.unsplash.com/photo-1587854692152-cbe660dbbb88?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
      ),
      VisualAdModel(
        id: '3',
        productName: 'GastroRelief Syrup',
        imageUrl: 'https://images.unsplash.com/photo-1471864190281-a93a3072457e?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
      ),
    ];
    state = state.copyWith(allAds: mock, filteredAds: mock);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void _applyFilters() {
    if (state.searchQuery.isEmpty) {
      state = state.copyWith(filteredAds: state.allAds);
    } else {
      final filtered = state.allAds
          .where((ad) => ad.productName.toLowerCase().contains(state.searchQuery.toLowerCase()))
          .toList();
      state = state.copyWith(filteredAds: filtered);
    }
  }
}

final visualAdsNotifierProvider = StateNotifierProvider<VisualAdsNotifier, VisualAdsState>((ref) {
  return VisualAdsNotifier();
});
