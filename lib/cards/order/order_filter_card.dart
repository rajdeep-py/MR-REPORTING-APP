import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../models/order.dart';

class OrderFilterCard extends ConsumerWidget {
  final OrderStatus? selectedStatus;
  final DateTimeRange? selectedDateRange;
  final Function(OrderStatus?) onStatusChanged;
  final Function(DateTimeRange?) onDateRangeChanged;

  const OrderFilterCard({
    super.key,
    this.selectedStatus,
    this.selectedDateRange,
    required this.onStatusChanged,
    required this.onDateRangeChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FILTERS',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              if (selectedStatus != null || selectedDateRange != null)
                TextButton(
                  onPressed: () {
                    onStatusChanged(null);
                    onDateRangeChanged(null);
                  },
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatusFilter(),
          const SizedBox(height: 12),
          _buildDateRangePicker(context),
        ],
      ),
    );
  }

  Widget _buildStatusFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<OrderStatus>(
          isExpanded: true,
          hint: const Text(
            'Filter by Status',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          value: selectedStatus,
          icon: const Icon(Iconsax.arrow_down_1, size: 16),
          items: OrderStatus.values
              .map(
                (status) => DropdownMenuItem(
                  value: status,
                  child: Text(
                    status.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onStatusChanged,
        ),
      ),
    );
  }

  Widget _buildDateRangePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final range = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          initialDateRange: selectedDateRange,
        );
        onDateRangeChanged(range);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.calendar_1, size: 18, color: AppColors.black),
            const SizedBox(width: 12),
            Text(
              selectedDateRange == null
                  ? 'Select Date Range'
                  : '${DateFormat('dd MMM').format(selectedDateRange!.start)} - ${DateFormat('dd MMM').format(selectedDateRange!.end)}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const Spacer(),
            const Icon(Iconsax.edit_2, size: 14, color: AppColors.coolGrey),
          ],
        ),
      ),
    );
  }
}
