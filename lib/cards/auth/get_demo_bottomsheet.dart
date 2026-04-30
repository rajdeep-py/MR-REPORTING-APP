import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class GetDemoBottomSheet extends StatelessWidget {
  const GetDemoBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const GetDemoBottomSheet(),
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
          
          const Icon(Iconsax.monitor_recorder, size: 48, color: AppColors.black),
          AppGaps.mediumV,
          
          Text(
            'Demo Credentials',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 22,
              color: AppColors.black,
            ),
          ),
          AppGaps.smallV,
          Text(
            'Use these credentials to explore the app',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          AppGaps.largeV,

          // Credentials Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
            ),
            child: Column(
              children: [
                _CredentialRow(
                  label: 'Phone Number',
                  value: '9876543210',
                  icon: Iconsax.call,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1, thickness: 0.5),
                ),
                _CredentialRow(
                  label: 'Password',
                  value: 'password',
                  icon: Iconsax.lock,
                ),
              ],
            ),
          ),
          
          AppGaps.extraLargeV,
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: AppColors.white,
            ),
            child: const Text('GOT IT'),
          ),
          AppGaps.mediumV,
        ],
      ),
    );
  }
}

class _CredentialRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _CredentialRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.darkGrey, size: 20),
        AppGaps.mediumH,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            AppTheme.showPremiumSnackBar(
              context: context,
              message: '$label copied to clipboard',
            );
          },
          icon: const Icon(Iconsax.copy, size: 20, color: AppColors.coolGrey),
        ),
      ],
    );
  }
}
