import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../cards/settings/settings_card.dart';
import '../../routes/app_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const SideNavBar(currentRoute: AppRouter.settings),
      appBar: const CustomAppBar(
        title: 'Settings',
        subtitle: 'App preferences and support',
        showDrawerButton: true,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('SUPPORT & FEEDBACK'),
            SettingsCard(
              title: 'Help Center',
              icon: Iconsax.message_question,
              onTap: () {},
            ),
            SettingsCard(
              title: 'Give Feedback',
              icon: Iconsax.like_1,
              onTap: () {},
            ),
            
            const SizedBox(height: 24),
            _buildSectionHeader('LEGAL & ABOUT'),
            SettingsCard(
              title: 'About Us',
              icon: Iconsax.info_circle,
              onTap: () => context.push(AppRouter.about),
            ),
            SettingsCard(
              title: 'Privacy Policies',
              icon: Iconsax.lock,
              onTap: () => context.push(AppRouter.privacyPolicy),
            ),
            SettingsCard(
              title: 'Terms and Conditions',
              icon: Iconsax.document_text,
              onTap: () => context.push(AppRouter.termsConditions),
            ),
            
            const SizedBox(height: 24),
            _buildSectionHeader('ACCOUNT ACTIONS'),
            SettingsCard(
              title: 'Delete Account',
              icon: Iconsax.user_remove,
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () => _showDeleteConfirmation(context),
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                'App Version 1.0.0',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.coolGrey),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: AppColors.coolGrey,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Delete Account', style: TextStyle(fontWeight: FontWeight.w800)),
        content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(color: AppColors.coolGrey, fontWeight: FontWeight.w700)),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle account deletion
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('DELETE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}
