import 'package:flutter_riverpod/legacy.dart';
import '../models/notification.dart';

class NotificationState {
  final List<NotificationModel> notifications;
  final bool isLoading;

  NotificationState({required this.notifications, this.isLoading = false});

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  NotificationNotifier() : super(NotificationState(notifications: [])) {
    _loadMockNotifications();
  }

  void _loadMockNotifications() {
    final now = DateTime.now();
    final mock = [
      NotificationModel(
        id: '1',
        title: 'Monthly Target Updated',
        description:
            'Your target for May 2026 has been updated. Please check the Target section.',
        time: now.subtract(const Duration(hours: 2)),
      ),
      NotificationModel(
        id: '2',
        title: 'New Doctor Added',
        description:
            'Dr. Smith has been added to your list of physicians in South Mumbai.',
        time: now.subtract(const Duration(days: 1)),
      ),
      NotificationModel(
        id: '3',
        title: 'DCR Pending',
        description:
            'You have a pending DCR for yesterday. Please submit it by end of day.',
        time: now.subtract(const Duration(days: 2)),
        isRead: true,
      ),
      NotificationModel(
        id: '4',
        title: 'Meeting Scheduled',
        description:
            'Monthly team review meeting scheduled for Friday at 10:00 AM.',
        time: now.subtract(const Duration(days: 3)),
        isRead: true,
      ),
    ];
    state = state.copyWith(notifications: mock);
  }

  void markAsRead(String id) {
    final newList = state.notifications.map((n) {
      if (n.id == id) {
        return NotificationModel(
          id: n.id,
          title: n.title,
          description: n.description,
          time: n.time,
          isRead: true,
        );
      }
      return n;
    }).toList();
    state = state.copyWith(notifications: newList);
  }
}
