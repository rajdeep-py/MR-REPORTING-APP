import 'package:flutter_riverpod/legacy.dart';
import '../notifiers/home_notifier.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});
