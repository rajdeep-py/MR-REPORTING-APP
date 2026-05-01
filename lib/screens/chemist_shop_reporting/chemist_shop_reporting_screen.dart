import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../notifiers/chemist_shop_reporting_notifier.dart';
import '../../cards/chemist_shop_reporting/chemist_shop_reporting_card.dart';
import '../../cards/chemist_shop_reporting/chemist_shop_reporting_filter_card.dart';
import '../../cards/chemist_shop_reporting/chemist_shop_reporting_details_bottomsheet.dart';
import '../../routes/app_router.dart';
import '../../models/chemist_shop_reporting.dart';

class ChemistShopReportingScreen extends ConsumerWidget {
  const ChemistShopReportingScreen({super.key});

  void _showReportDetails(BuildContext context, WidgetRef ref, ChemistShopReportingModel report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChemistShopReportingDetailsBottomSheet(
        report: report,
        onUpdate: (updated) {
          ref.read(chemistReportingNotifierProvider.notifier).updateReport(updated);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportingState = ref.watch(chemistReportingNotifierProvider);
    final notifier = ref.read(chemistReportingNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const SideNavBar(currentRoute: AppRouter.chemistReporting),
      appBar: CustomAppBar(
        title: 'Pharmacy Reporting',
        subtitle: 'Chemist shop visit logs',
        showDrawerButton: true,
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () => context.push(AppRouter.createEditChemistReporting),
            icon: const Icon(Iconsax.document_filter, color: AppColors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Column(
          children: [
            ChemistShopReportingFilterCard(
              selectedStatus: reportingState.filterStatus,
              selectedDate: reportingState.filterDate,
              onStatusChanged: notifier.setFilterStatus,
              onDateChanged: notifier.setFilterDate,
            ),
            AppGaps.largeV,
            if (reportingState.filteredReports.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text('No pharmacy reports found.'),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reportingState.filteredReports.length,
                separatorBuilder: (context, index) => AppGaps.mediumV,
                itemBuilder: (context, index) {
                  final report = reportingState.filteredReports[index];
                  return ChemistShopReportingCard(
                    report: report,
                    onTap: () => _showReportDetails(context, ref, report),
                  );
                },
              ),
            AppGaps.extraLargeV,
          ],
        ),
      ),
    );
  }
}
