import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../widgets/footer.dart';
import '../../providers/home_provider.dart';
import '../../providers/attendance_provider.dart';
import '../../providers/auth_provider.dart';
import '../../cards/home/greeting_card.dart';
import '../../cards/home/attendance_card.dart';
import '../../cards/home/quick_action_card.dart';
import '../../cards/home/attendance_graph_card.dart';

import '../../routes/app_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    ref.watch(attendanceProvider);
    final authState = ref.watch(authProvider);
    final attendanceNotifier = ref.read(attendanceProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        // Since we are already on Home, we can either do nothing or show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Press back again to exit'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: const SideNavBar(currentRoute: AppRouter.home),
        appBar: const CustomAppBar(
          title: 'Naiyo24',
          subtitle: 'MR Management System',
          showDrawerButton: true,
          showBackButton: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppGaps.screenPadding),
                child: Column(
                  children: [
                    GreetingCard(
                      greeting: homeState.greeting,
                      userName: authState.user?.name ?? 'User',
                      quote: homeState.quote,
                    ),
                    AppGaps.largeV,
                    AttendanceCard(
                      todayAttendance: attendanceNotifier.todayAttendance,
                      onCheckIn: () => attendanceNotifier.checkIn(),
                      onCheckOut: () => attendanceNotifier.checkOut(),
                      onBreakIn: () => attendanceNotifier.breakIn(),
                      onBreakOut: () => attendanceNotifier.breakOut(),
                    ),
                    AppGaps.largeV,
                    const QuickActionCard(),
                    AppGaps.largeV,
                    const AttendanceGraphCard(),
                  ],
                ),
              ),
              const CustomFooter(
                headerText: "Naiyo24",
                tagline: "Where Innovation meets Business!",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
