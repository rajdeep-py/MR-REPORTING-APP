import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';
import '../../models/chemist_shop.dart';

class ChemistShopCard extends StatelessWidget {
  final ChemistShopModel shop;
  final VoidCallback onTap;

  const ChemistShopCard({
    super.key,
    required this.shop,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAlpha(5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: shop.photoUrl != null
                    ? (shop.photoUrl!.startsWith('http')
                        ? Image.network(shop.photoUrl!, fit: BoxFit.cover)
                        : Image.file(File(shop.photoUrl!), fit: BoxFit.cover))
                    : const Icon(Iconsax.hospital, color: AppColors.coolGrey, size: 28),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Iconsax.location, size: 14, color: AppColors.coolGrey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          shop.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.black.withAlpha(150),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Iconsax.arrow_right_3, size: 18, color: AppColors.black),
          ],
        ),
      ),
    );
  }
}
