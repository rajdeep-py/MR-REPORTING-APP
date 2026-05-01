import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/order_notifier.dart';

final orderProvider = Provider<OrderState>((ref) {
  return ref.watch(orderNotifierProvider);
});
