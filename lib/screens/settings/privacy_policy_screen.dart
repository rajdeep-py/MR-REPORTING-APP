import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../notifiers/settings_notifier.dart';
import '../../cards/settings/privacy_policy_card.dart';

class PrivacyPolicyScreen extends ConsumerWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policies = ref.watch(settingsNotifierProvider).privacyPolicies;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Privacy Policy',
        subtitle: 'How we handle your data',
        showBackButton: true,
        showDrawerButton: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        itemCount: policies.length,
        itemBuilder: (context, index) => PrivacyPolicyCard(policy: policies[index]),
      ),
    );
  }
}
