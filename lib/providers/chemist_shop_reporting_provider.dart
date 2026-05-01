import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/chemist_shop_reporting_notifier.dart';

final chemistReportingProvider = Provider<ChemistReportingState>((ref) {
  return ref.watch(chemistReportingNotifierProvider);
});
