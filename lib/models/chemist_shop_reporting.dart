import 'chemist_shop.dart';

enum ChemistReportingStatus { pending, completed, cancelled }

class ChemistShopReportingModel {
  final String id;
  final ChemistShopModel chemistShop;
  final String date; // YYYY-MM-DD
  final String time;
  final String productsInterested;
  final String productsNeeded;
  final ChemistReportingStatus status;

  ChemistShopReportingModel({
    required this.id,
    required this.chemistShop,
    required this.date,
    required this.time,
    required this.productsInterested,
    required this.productsNeeded,
    this.status = ChemistReportingStatus.pending,
  });

  ChemistShopReportingModel copyWith({
    String? id,
    ChemistShopModel? chemistShop,
    String? date,
    String? time,
    String? productsInterested,
    String? productsNeeded,
    ChemistReportingStatus? status,
  }) {
    return ChemistShopReportingModel(
      id: id ?? this.id,
      chemistShop: chemistShop ?? this.chemistShop,
      date: date ?? this.date,
      time: time ?? this.time,
      productsInterested: productsInterested ?? this.productsInterested,
      productsNeeded: productsNeeded ?? this.productsNeeded,
      status: status ?? this.status,
    );
  }
}
