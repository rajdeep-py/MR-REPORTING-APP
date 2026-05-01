import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/stockist_notifier.dart';

final stockistProvider = Provider<StockistState>((ref) {
  return ref.watch(stockistNotifierProvider);
});
