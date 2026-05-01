import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class ChemistShopContactCard extends StatelessWidget {
  final String phone;
  final String email;
  final String address;

  const ChemistShopContactCard({
    super.key,
    required this.phone,
    required this.email,
    required this.address,
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
          _buildContactRow(context, Iconsax.call, 'Store Phone', phone),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1, thickness: 0.5),
          ),
          _buildContactRow(context, Iconsax.sms, 'Email Address', email),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1, thickness: 0.5),
          ),
          _buildContactRow(context, Iconsax.location, 'Store Address', address),
        ],
      ),
    );
  }

  Widget _buildContactRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.black.withAlpha(10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.black, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
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
