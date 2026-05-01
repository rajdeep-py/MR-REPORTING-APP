import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../notifiers/order_notifier.dart';
import '../../cards/order/order_card.dart';
import '../../cards/order/order_filter_card.dart';
import '../../cards/order/order_details_bottomsheet.dart';
import '../../routes/app_router.dart';
import '../../models/order.dart';

class MyOrderScreen extends ConsumerWidget {
  const MyOrderScreen({super.key});

  void _showOrderDetails(BuildContext context, WidgetRef ref, OrderModel order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OrderDetailsBottomSheet(
        order: order,
        onDelete: () {
          ref.read(orderNotifierProvider.notifier).removeOrder(order.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order deleted successfully')),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderState = ref.watch(orderNotifierProvider);
    final notifier = ref.read(orderNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const SideNavBar(currentRoute: AppRouter.orders),
      appBar: CustomAppBar(
        title: 'My Orders',
        subtitle: 'Track your commercial logs',
        showDrawerButton: true,
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () => context.push(AppRouter.createOrder),
            icon: const Icon(Iconsax.add_square, color: AppColors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Column(
          children: [
            OrderFilterCard(
              selectedStatus: orderState.filterStatus,
              selectedDateRange: orderState.filterDateRange,
              onStatusChanged: notifier.setFilterStatus,
              onDateRangeChanged: notifier.setFilterDateRange,
            ),
            AppGaps.largeV,
            if (orderState.filteredOrders.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text('No orders found.'),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orderState.filteredOrders.length,
                separatorBuilder: (context, index) => AppGaps.mediumV,
                itemBuilder: (context, index) {
                  final order = orderState.filteredOrders[index];
                  return OrderCard(
                    order: order,
                    onTap: () => _showOrderDetails(context, ref, order),
                  );
                },
              ),
            AppGaps.extraLargeV,
          ],
        ),
      ),
    );
  }
}
