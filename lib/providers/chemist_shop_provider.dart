import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/chemist_shop_notifier.dart';

final chemistShopProvider = Provider<ChemistShopState>((ref) {
  return ref.watch(chemistShopNotifierProvider);
});
