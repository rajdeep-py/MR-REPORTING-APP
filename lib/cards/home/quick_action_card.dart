import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionItem('Add Doctor', Iconsax.user_add, AppColors.black),
      _ActionItem('Add Chemist', Iconsax.shop, AppColors.black),
      _ActionItem('Visual Ads', Iconsax.gallery, AppColors.black),
      _ActionItem('Add Stockist', Iconsax.box, AppColors.black),
      _ActionItem('Attendance', Iconsax.calendar_tick, AppColors.black),
      _ActionItem('Create DCR', Iconsax.document_text, AppColors.black),
      _ActionItem('Request Gift', Iconsax.gift, AppColors.black),
      _ActionItem('Create Expense', Iconsax.money, AppColors.black),
      _ActionItem('Trip', Iconsax.map, AppColors.black),
      _ActionItem('Create Order', Iconsax.shopping_cart, AppColors.black),
      _ActionItem('Target', Iconsax.graph, AppColors.black),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUICK ACTIONS',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
        AppGaps.mediumV,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.coolGrey.withAlpha(20)),
                  ),
                  child: Icon(actions[index].icon, color: actions[index].color, size: 24),
                ),
                AppGaps.smallV,
                Text(
                  actions[index].title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ActionItem {
  final String title;
  final IconData icon;
  final Color color;

  _ActionItem(this.title, this.icon, this.color);
}
