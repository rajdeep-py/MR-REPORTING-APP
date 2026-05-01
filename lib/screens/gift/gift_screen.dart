import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/side_nav_bar.dart';
import '../../notifiers/gift_notifier.dart';
import '../../cards/gift/gift_card.dart';
import '../../cards/gift/gift_filter_card.dart';
import '../../cards/gift/gift_details_bottomsheet.dart';
import '../../routes/app_router.dart';
import '../../models/gift.dart';

class GiftScreen extends ConsumerWidget {
  const GiftScreen({super.key});

  void _showGiftDetails(BuildContext context, WidgetRef ref, GiftModel gift) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GiftDetailsBottomSheet(
        gift: gift,
        onDelete: () {
          ref.read(giftNotifierProvider.notifier).removeGift(gift.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gift request deleted successfully')),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final giftState = ref.watch(giftNotifierProvider);
    final notifier = ref.read(giftNotifierProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go(AppRouter.home);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: const SideNavBar(currentRoute: AppRouter.gifts),
        appBar: CustomAppBar(
          title: 'Gift Requests',
          subtitle: 'Manage doctor rewards',
          showDrawerButton: true,
          showBackButton: false,
          actions: [
            IconButton(
              onPressed: () => context.push(AppRouter.requestGift),
              icon: const Icon(Iconsax.gift, color: AppColors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppGaps.screenPadding),
          child: Column(
            children: [
              GiftFilterCard(
                selectedDoctorId: giftState.filterDoctorId,
                selectedDate: giftState.filterDate,
                onDoctorChanged: notifier.setFilterDoctor,
                onDateChanged: notifier.setFilterDate,
              ),
              AppGaps.largeV,
              if (giftState.filteredGifts.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text('No gift requests found.'),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: giftState.filteredGifts.length,
                  separatorBuilder: (context, index) => AppGaps.mediumV,
                  itemBuilder: (context, index) {
                    final gift = giftState.filteredGifts[index];
                    return GiftCard(
                      gift: gift,
                      onTap: () => _showGiftDetails(context, ref, gift),
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
