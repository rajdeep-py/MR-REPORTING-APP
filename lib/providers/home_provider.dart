import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/home_notifier.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});
