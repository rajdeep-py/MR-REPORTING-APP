import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:collection/collection.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../notifiers/stockist_notifier.dart';
import '../../cards/stockist/stockist_header_card.dart';
import '../../cards/stockist/stockist_decription_card.dart';
import '../../cards/stockist/stockist_order_delivery_info_card.dart';
import '../../cards/stockist/stockist_contact_card.dart';
import '../../routes/app_router.dart';

class StockistDetailScreen extends ConsumerWidget {
  final String stockistId;

  const StockistDetailScreen({super.key, required this.stockistId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockistState = ref.watch(stockistNotifierProvider);
    final stockist = stockistState.allStockists.firstWhereOrNull(
      (s) => s.id == stockistId,
    );

    if (stockist == null) {
      return const Scaffold(body: Center(child: Text('Stockist not found')));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Stockist Detail',
        subtitle: 'Distribution Partner',
        showBackButton: true,
        showDrawerButton: false,
        actions: [
          IconButton(
            onPressed: () =>
                context.push(AppRouter.addEditStockist, extra: stockist),
            icon: const Icon(Iconsax.edit, color: AppColors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppGaps.screenPadding),
        child: Column(
          children: [
            StockistHeaderCard(
              name: stockist.name,
              photoUrl: stockist.photoUrl,
            ),
            AppGaps.largeV,
            StockistDescriptionCard(description: stockist.description),
            AppGaps.largeV,
            StockistOrderDeliveryInfoCard(
              minOrderValue: stockist.minOrderValue,
              expectedDeliveryTime: stockist.expectedDeliveryTime,
              medicinesInterestedIn: stockist.medicinesInterestedIn,
            ),
            AppGaps.largeV,
            StockistContactCard(
              phone: stockist.phone,
              email: stockist.email,
              address: stockist.address,
            ),
            AppGaps.extraLargeV,
          ],
        ),
      ),
    );
  }
}
