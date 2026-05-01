import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/visual_ads_notifier.dart';

final visualAdsProvider = Provider<VisualAdsState>((ref) {
  return ref.watch(visualAdsNotifierProvider);
});
