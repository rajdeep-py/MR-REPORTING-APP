import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../notifiers/dcr_notifier.dart';
import '../../cards/dcr/dcr_card.dart';
import '../../cards/dcr/dcr_filter_card.dart';
import '../../cards/dcr/dcr_details_bottomsheet.dart';
import '../../routes/app_router.dart';
import '../../models/dcr.dart';

class DCRScreen extends ConsumerWidget {
  const DCRScreen({super.key});

  void _showDCRDetails(BuildContext context, WidgetRef ref, DCRModel dcr) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DCRDetailsBottomSheet(
        dcr: dcr,
        onStatusUpdate: (status) {
          ref
              .read(dcrNotifierProvider.notifier)
              .updateDCR(dcr.copyWith(status: status));
          context.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dcrState = ref.watch(dcrNotifierProvider);
    final dcrNotifier = ref.read(dcrNotifierProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.home);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: const SideNavBar(currentRoute: '/dcr'),
        appBar: CustomAppBar(
          title: 'Daily Call Reports',
          subtitle: 'Track your doctor visits',
          showDrawerButton: true,
          showBackButton: false,
          actions: [
            IconButton(
              onPressed: () => context.push(AppRouter.createEditDcr),
              icon: const Icon(Iconsax.add_circle, color: AppColors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppGaps.screenPadding),
          child: Column(
            children: [
              DCRFilterCard(
                selectedStatus: dcrState.filterStatus,
                selectedDate: dcrState.filterDate,
                onStatusChanged: dcrNotifier.setFilterStatus,
                onDateChanged: dcrNotifier.setFilterDate,
              ),
              AppGaps.largeV,
              if (dcrState.filteredDCRs.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text('No reports found for selected filters.'),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dcrState.filteredDCRs.length,
                  separatorBuilder: (context, index) => AppGaps.mediumV,
                  itemBuilder: (context, index) {
                    final dcr = dcrState.filteredDCRs[index];
                    return DCRCard(
                      dcr: dcr,
                      onTap: () => _showDCRDetails(context, ref, dcr),
                    );
                  },
                ),
              AppGaps.extraLargeV,
            ],
          ),
        ),
      ),
    );
  }
}
