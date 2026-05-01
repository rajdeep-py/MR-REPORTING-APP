import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class DoctorHeaderCard extends StatelessWidget {
  final String? photoUrl;
  final String name;
  final String specialization;
  final String birthday;

  const DoctorHeaderCard({
    super.key,
    this.photoUrl,
    required this.name,
    required this.specialization,
    required this.birthday,
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
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white.withAlpha(50), width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: photoUrl != null
                  ? Image.network(photoUrl!, fit: BoxFit.cover)
                  : const Icon(Iconsax.user, color: AppColors.white, size: 40),
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
          Text(
            specialization,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.coolGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.cake, color: AppColors.white, size: 14),
                const SizedBox(width: 8),
                Text(
                  'Birthday: $birthday',
                  style: const TextStyle(color: AppColors.white, fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
