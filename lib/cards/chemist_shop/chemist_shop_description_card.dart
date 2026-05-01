import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ChemistShopDescriptionCard extends StatelessWidget {
  final String description;

  const ChemistShopDescriptionCard({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ABOUT THIS SHOP',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 14,
              color: AppColors.darkGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
