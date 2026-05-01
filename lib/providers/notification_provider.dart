import 'package:flutter_riverpod/legacy.dart';
import '../notifiers/notification_notifier.dart';

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
      return NotificationNotifier();
    });
