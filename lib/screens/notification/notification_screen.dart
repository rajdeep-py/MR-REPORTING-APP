import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../providers/notification_provider.dart';
import '../../cards/notification/notification_card.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(notificationProvider);
    final notificationNotifier = ref.read(notificationProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.settings);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: const SideNavBar(currentRoute: '/notifications'),
        appBar: const CustomAppBar(
          title: 'Notifications',
          subtitle: 'Stay updated with your activities',
          showDrawerButton: true,
          showBackButton: false,
        ),
        body: notificationState.notifications.isEmpty
            ? Center(
                child: Text(
                  'No notifications yet',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(AppGaps.screenPadding),
                itemCount: notificationState.notifications.length,
                separatorBuilder: (context, index) => AppGaps.mediumV,
                itemBuilder: (context, index) {
                  final notification = notificationState.notifications[index];
                  return NotificationCard(
                    notification: notification,
                    onTap: () =>
                        notificationNotifier.markAsRead(notification.id),
                  );
                },
              ),
      ),
    );
  }
}
