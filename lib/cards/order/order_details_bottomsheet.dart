import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../models/order.dart';

class OrderDetailsBottomSheet extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onDelete;

  const OrderDetailsBottomSheet({
    super.key,
    required this.order,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.coolGrey.withAlpha(50),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildHeader(context),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: [
                  _buildSectionTitle('STAKEHOLDERS'),
                  _buildInfoItem(Iconsax.user, 'Ordering Doctor', order.doctor.name),
                  _buildInfoItem(Iconsax.shop, 'Chemist Shop', order.chemistShop.name),
                  _buildInfoItem(Iconsax.truck, 'Stockist Incharge', order.stockist.name),
                  
                  const SizedBox(height: 24),
                  _buildSectionTitle('TIMELINE'),
                  _buildInfoItem(Iconsax.calendar_1, 'Order Date', DateFormat('dd MMM, yyyy').format(order.orderDate)),
                  _buildInfoItem(Iconsax.truck, 'Expected Delivery', DateFormat('dd MMM, yyyy').format(order.deliveryDate)),
                  
                  const SizedBox(height: 24),
                  _buildSectionTitle('ORDER ITEMS'),
                  ...order.items.map((item) => _buildOrderItem(item)),
                  
                  const SizedBox(height: 24),
                  _buildTotalSection(),
                  
                  const SizedBox(height: 40),
                  _buildDeleteButton(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ORDER DETAILS',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
            ),
            Text(
              '#${order.id}',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
          ],
        ),
        _buildStatusBadge(order.status),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.coolGrey, letterSpacing: 1),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 16, color: AppColors.black),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: AppColors.coolGrey, fontWeight: FontWeight.w700)),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.productName, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                Text('Qty: ${item.quantity} × ₹${item.price.toStringAsFixed(2)}', 
                     style: const TextStyle(fontSize: 11, color: AppColors.darkGrey, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Text(
            '₹${item.total.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('TOTAL AMOUNT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 1, fontSize: 12)),
          Text('₹${order.totalAmount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () {
          context.pop();
          onDelete();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.withAlpha(20),
          foregroundColor: Colors.red,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          side: const BorderSide(color: Colors.red, width: 1),
        ),
        icon: const Icon(Iconsax.trash, size: 20),
        label: const Text('CANCEL & DELETE ORDER', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }

  Widget _buildStatusBadge(OrderStatus status) {
    Color color;
    switch (status) {
      case OrderStatus.delivered: color = Colors.green; break;
      case OrderStatus.cancelled: color = Colors.red; break;
      case OrderStatus.shipped: color = Colors.blue; break;
      default: color = Colors.orange;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withAlpha(20), borderRadius: BorderRadius.circular(10)),
      child: Text(status.name.toUpperCase(), style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900)),
    );
  }
}
