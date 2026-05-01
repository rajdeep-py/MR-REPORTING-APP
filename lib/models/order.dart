import 'doctor.dart';
import 'chemist_shop.dart';
import 'visual_ads.dart';
import 'stockist.dart';

enum OrderStatus { pending, shipped, delivered, cancelled }

class OrderItem {
  final VisualAdModel product;
  final double price;
  final int quantity;

  OrderItem({
    required this.product,
    required this.price,
    required this.quantity,
  });

  double get total => price * quantity;
}

class OrderModel {
  final String id;
  final DateTime orderDate;
  final DateTime deliveryDate;
  final OrderStatus status;
  final List<OrderItem> items;
  final DoctorModel doctor;
  final ChemistShopModel chemistShop;
  final StockistModel stockist;

  OrderModel({
    required this.id,
    required this.orderDate,
    required this.deliveryDate,
    required this.status,
    required this.items,
    required this.doctor,
    required this.chemistShop,
    required this.stockist,
  });

  double get totalAmount => items.fold(0, (sum, item) => sum + item.total);

  OrderModel copyWith({
    String? id,
    DateTime? orderDate,
    DateTime? deliveryDate,
    OrderStatus? status,
    List<OrderItem>? items,
    DoctorModel? doctor,
    ChemistShopModel? chemistShop,
    StockistModel? stockist,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderDate: orderDate ?? this.orderDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      status: status ?? this.status,
      items: items ?? this.items,
      doctor: doctor ?? this.doctor,
      chemistShop: chemistShop ?? this.chemistShop,
      stockist: stockist ?? this.stockist,
    );
  }
}
