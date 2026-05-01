import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/gift_notifier.dart';

final giftProvider = Provider<GiftState>((ref) {
  return ref.watch(giftNotifierProvider);
});
