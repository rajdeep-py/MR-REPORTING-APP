import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class StockistOrderDeliveryInfoCard extends StatelessWidget {
  final String minOrderValue;
  final String expectedDeliveryTime;
  final String medicinesInterestedIn;

  const StockistOrderDeliveryInfoCard({
    super.key,
    required this.minOrderValue,
    required this.expectedDeliveryTime,
    required this.medicinesInterestedIn,
  });

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
            'ORDER & DELIVERY TERMS',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(
            context,
            Iconsax.money_send,
            'MIN ORDER VALUE',
            minOrderValue,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 0.5),
          ),
          _buildInfoRow(
            context,
            Iconsax.truck_fast,
            'EXPECTED DELIVERY',
            expectedDeliveryTime,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 0.5),
          ),
          _buildInfoRow(
            context,
            Icons.medical_services,
            'INTERESTED PRODUCTS',
            medicinesInterestedIn,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, color: AppColors.black, size: 20),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontSize: 10, letterSpacing: 1),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
