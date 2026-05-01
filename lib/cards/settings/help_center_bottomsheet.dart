import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class HelpCenterBottomSheet extends StatelessWidget {
  const HelpCenterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
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
            Text(
              'HELP CENTER',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Need assistance? Reach out to us.',
              style: TextStyle(fontSize: 14, color: AppColors.darkGrey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: [
                  _buildContactSection(
                    context,
                    'YOUR ORGANISATION',
                    'Contact your company administrator for internal issues.',
                    '011-4567-8901',
                    'support@yourcompany.com',
                    '123, Corporate Tower, Sector 62, Noida, UP',
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 1, thickness: 0.5),
                  const SizedBox(height: 24),
                  _buildContactSection(
                    context,
                    'NAIYO24 SUPPORT',
                    'For app-related technical issues or account recovery.',
                    '+91 98765 43210',
                    'help@naiyo24.com',
                    '45, Tech Park Phase 2, Whitefield, Bangalore',
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(
    BuildContext context,
    String title,
    String subtitle,
    String phone,
    String email,
    String address,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.5),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 11, color: AppColors.coolGrey, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        _buildContactItem(Iconsax.call, phone),
        const SizedBox(height: 12),
        _buildContactItem(Iconsax.sms, email),
        const SizedBox(height: 12),
        _buildContactItem(Iconsax.location, address),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: AppColors.black),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
