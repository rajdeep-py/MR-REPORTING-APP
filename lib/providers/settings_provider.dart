import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/settings_notifier.dart';

final settingsProvider = Provider<SettingsState>((ref) {
  return ref.watch(settingsNotifierProvider);
});
