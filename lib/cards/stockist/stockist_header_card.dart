import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class StockistHeaderCard extends StatelessWidget {
  final String? photoUrl;
  final String name;

  const StockistHeaderCard({
    super.key,
    this.photoUrl,
    required this.name,
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
            width: 120,
            height: 120,
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
                  : const Icon(Iconsax.box, color: AppColors.white, size: 48),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppColors.white,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
