import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/about_us_notifier.dart';
import '../models/about_us.dart';

final aboutUsDataProvider = StateNotifierProvider<AboutUsNotifier, AboutUsModel?>((ref) {
  return AboutUsNotifier();
});
