import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../notifiers/settings_notifier.dart';
import '../../cards/settings/terms_conditions_card.dart';

class TermsConditionsScreen extends ConsumerWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final terms = ref.watch(settingsNotifierProvider).termsConditions;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.settings);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const CustomAppBar(
          title: 'Terms & Conditions',
          subtitle: 'User agreement and rules',
          showBackButton: true,
          showDrawerButton: false,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(AppGaps.screenPadding),
          itemCount: terms.length,
          itemBuilder: (context, index) =>
              TermsConditionsCard(term: terms[index]),
        ),
      ),
    );
  }
}
