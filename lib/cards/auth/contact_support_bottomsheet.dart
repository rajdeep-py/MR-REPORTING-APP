import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class ContactSupportBottomSheet extends StatelessWidget {
  const ContactSupportBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ContactSupportBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.coolGrey.withAlpha(50),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          AppGaps.largeV,
          
          Text(
            'Support Center',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 22,
              color: AppColors.black,
            ),
          ),
          AppGaps.smallV,
          Text(
            'How would you like to reach us?',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          AppGaps.largeV,

          // Support Options
          _SupportTile(
            icon: Iconsax.call,
            title: 'Call Support',
            subtitle: '+1 800 123 4567',
            onTap: () {},
          ),
          AppGaps.mediumV,
          _SupportTile(
            icon: Iconsax.message,
            title: 'Email Support',
            subtitle: 'support@mrapp.com',
            onTap: () {},
          ),
          AppGaps.mediumV,
          _SupportTile(
            icon: Iconsax.global,
            title: 'Visit Website',
            subtitle: 'www.mrapp.com/help',
            onTap: () {},
          ),
          
          AppGaps.extraLargeV,
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('DISMISS'),
          ),
          AppGaps.mediumV,
        ],
      ),
    );
  }
}

class _SupportTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SupportTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.black.withAlpha(10),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.black, size: 24),
            ),
            AppGaps.mediumH,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 0.2),
                  ),
                ],
              ),
            ),
            const Icon(Iconsax.arrow_right_3, color: AppColors.coolGrey, size: 18),
          ],
        ),
      ),
    );
  }
}
