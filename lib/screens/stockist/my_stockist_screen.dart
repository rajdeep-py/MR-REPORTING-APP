import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../notifiers/stockist_notifier.dart';
import '../../cards/stockist/stockist_card.dart';
import '../../cards/stockist/stockist_search_card.dart';
import '../../routes/app_router.dart';

class MyStockistScreen extends ConsumerWidget {
  const MyStockistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockistState = ref.watch(stockistNotifierProvider);
    final stockistNotifier = ref.read(stockistNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const SideNavBar(currentRoute: '/stockist'),
      appBar: CustomAppBar(
        title: 'My Stockists',
        subtitle: 'Manage distribution partners',
        showDrawerButton: true,
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () => context.push(AppRouter.addEditStockist),
            icon: const Icon(Iconsax.box_add, color: AppColors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Column(
          children: [
            StockistSearchCard(onSearch: stockistNotifier.setSearchQuery),
            AppGaps.largeV,
            if (stockistState.filteredStockists.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text('No stockists found.'),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stockistState.filteredStockists.length,
                separatorBuilder: (context, index) => AppGaps.mediumV,
                itemBuilder: (context, index) {
                  final stockist = stockistState.filteredStockists[index];
                  return StockistCard(
                    stockist: stockist,
                    onTap: () => context.push(
                      AppRouter.stockistDetail.replaceFirst(':stockistId', stockist.id),
                    ),
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
