import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../notifiers/chemist_shop_notifier.dart';
import '../../cards/chemist_shop/chemist_shop_card.dart';
import '../../cards/chemist_shop/chemist_shop_search_card.dart';
import '../../routes/app_router.dart';

class MyChemistShopScreen extends ConsumerWidget {
  const MyChemistShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopState = ref.watch(chemistShopNotifierProvider);
    final shopNotifier = ref.read(chemistShopNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const SideNavBar(currentRoute: '/chemist'),
      appBar: CustomAppBar(
        title: 'My Chemist Shops',
        subtitle: 'Manage pharmacy partners',
        showDrawerButton: true,
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () => context.push(AppRouter.addEditChemist),
            icon: const Icon(Iconsax.add_circle, color: AppColors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Column(
          children: [
            ChemistShopSearchCard(onSearch: shopNotifier.setSearchQuery),
            AppGaps.largeV,
            if (shopState.filteredShops.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text('No chemist shops found.'),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: shopState.filteredShops.length,
                separatorBuilder: (context, index) => AppGaps.mediumV,
                itemBuilder: (context, index) {
                  final shop = shopState.filteredShops[index];
                  return ChemistShopCard(
                    shop: shop,
                    onTap: () => context.push(
                      AppRouter.chemistDetail.replaceFirst(':shopId', shop.id),
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
