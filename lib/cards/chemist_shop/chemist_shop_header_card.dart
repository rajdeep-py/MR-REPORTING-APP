import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class ChemistShopHeaderCard extends StatelessWidget {
  final String? photoUrl;
  final String name;
  final String address;

  const ChemistShopHeaderCard({
    super.key,
    this.photoUrl,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.white.withAlpha(50), width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: photoUrl != null
                  ? (photoUrl!.startsWith('http')
                      ? Image.network(photoUrl!, fit: BoxFit.cover)
                      : Image.file(File(photoUrl!), fit: BoxFit.cover))
                  : const Icon(Iconsax.hospital, color: AppColors.white, size: 40),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppColors.white,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.location, color: AppColors.coolGrey, size: 14),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  address,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.coolGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
