import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/notification_notifier.dart';

final notificationProvider = StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  return NotificationNotifier();
});
