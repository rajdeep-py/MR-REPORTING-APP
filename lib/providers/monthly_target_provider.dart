import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/monthly_target_notifier.dart';

final monthlyTargetProvider = Provider<MonthlyTargetState>((ref) {
  return ref.watch(monthlyTargetNotifierProvider);
});
