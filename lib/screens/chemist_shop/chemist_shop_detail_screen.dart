import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:collection/collection.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../notifiers/chemist_shop_notifier.dart';
import '../../cards/chemist_shop/chemist_shop_header_card.dart';
import '../../cards/chemist_shop/chemist_shop_description_card.dart';
import '../../cards/chemist_shop/chemist_shop_contact_card.dart';
import '../../routes/app_router.dart';

class ChemistShopDetailScreen extends ConsumerWidget {
  final String shopId;

  const ChemistShopDetailScreen({super.key, required this.shopId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopState = ref.watch(chemistShopNotifierProvider);
    final shop = shopState.allShops.firstWhereOrNull((s) => s.id == shopId);

    if (shop == null) {
      return const Scaffold(
        body: Center(child: Text('Chemist shop not found')),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.chemist);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: shop.name,
          subtitle: 'Shop Details',
          showBackButton: true,
          showDrawerButton: false,
          actions: [
            IconButton(
              onPressed: () =>
                  context.push(AppRouter.addEditChemist, extra: shop),
              icon: const Icon(Iconsax.edit, color: AppColors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppGaps.screenPadding),
          child: Column(
            children: [
              ChemistShopHeaderCard(
                name: shop.name,
                address: shop.address,
                photoUrl: shop.photoUrl,
              ),
              AppGaps.largeV,
              ChemistShopDescriptionCard(description: shop.description),
              AppGaps.largeV,
              ChemistShopContactCard(
                phone: shop.phone,
                email: shop.email,
                address: shop.address,
              ),
              AppGaps.extraLargeV,
            ],
          ),
        ),
      ),
    );
  }
}
