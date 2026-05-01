import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/dcr_notifier.dart';

final dcrProvider = Provider<DCRState>((ref) {
  return ref.watch(dcrNotifierProvider);
});
