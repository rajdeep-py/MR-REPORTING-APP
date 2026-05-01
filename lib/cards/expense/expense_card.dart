import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseModel expense;
  final VoidCallback onTap;

  const ExpenseCard({super.key, required this.expense, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text(
                            DateFormat('dd').format(expense.date),
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                          ),
                          Text(
                            DateFormat('MMM').format(expense.date).toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 10, color: AppColors.coolGrey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DAILY TOTAL',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, letterSpacing: 1),
                        ),
                        Text(
                          '₹${expense.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                _buildStatusBadge(expense.status),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Iconsax.receipt_2, size: 14, color: AppColors.coolGrey),
                const SizedBox(width: 8),
                Text(
                  '${expense.items.length} items logged',
                  style: const TextStyle(color: AppColors.coolGrey, fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const Icon(Iconsax.arrow_right_3, size: 16, color: AppColors.coolGrey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ExpenseStatus status) {
    Color color;
    String text;
    switch (status) {
      case ExpenseStatus.received:
        color = Colors.green;
        text = 'RECEIVED';
        break;
      case ExpenseStatus.rejected:
        color = Colors.red;
        text = 'REJECTED';
        break;
      default:
        color = Colors.orange;
        text = 'PENDING';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5),
      ),
    );
  }
}
