import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../notifiers/monthly_target_notifier.dart';
import '../../notifiers/order_notifier.dart';
import '../../cards/monthly_target/monthly_target_filter_card.dart';
import '../../cards/monthly_target/monthly_target_details_card.dart';
import '../../cards/monthly_target/monthly_target_card.dart';
import '../../routes/app_router.dart';
import '../../models/order.dart';

class MonthlyTargetScreen extends ConsumerWidget {
  const MonthlyTargetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetState = ref.watch(monthlyTargetNotifierProvider);
    final targetNotifier = ref.read(monthlyTargetNotifierProvider.notifier);
    final orderState = ref.watch(orderNotifierProvider);

    // Filter orders for the selected period
    final relevantOrders = orderState.allOrders.where((o) => 
      o.orderDate.month == targetState.selectedMonth && 
      o.orderDate.year == targetState.selectedYear &&
      o.status != OrderStatus.cancelled
    ).toList();

    final achieved = relevantOrders.fold(0.0, (sum, o) => sum + o.totalAmount);
    final currentTarget = targetNotifier.currentTarget;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const SideNavBar(currentRoute: AppRouter.target),
      appBar: const CustomAppBar(
        title: 'Monthly Target',
        subtitle: 'Track your periodic progress',
        showDrawerButton: true,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MonthlyTargetFilterCard(
              selectedMonth: targetState.selectedMonth,
              selectedYear: targetState.selectedYear,
              onMonthChanged: targetNotifier.setMonth,
              onYearChanged: targetNotifier.setYear,
            ),
            AppGaps.largeV,
            MonthlyTargetDetailsCard(
              target: currentTarget?.targetAmount ?? 0.0,
              achieved: achieved,
            ),
            AppGaps.extraLargeV,
            Text(
              'CONTRIBUTING ORDERS',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
            ),
            AppGaps.mediumV,
            if (relevantOrders.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text('No orders contributed to this period.', style: TextStyle(color: AppColors.coolGrey)),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: relevantOrders.length,
                separatorBuilder: (context, index) => AppGaps.mediumV,
                itemBuilder: (context, index) => MonthlyTargetCard(order: relevantOrders[index]),
              ),
            AppGaps.extraLargeV,
          ],
        ),
      ),
    );
  }
}
