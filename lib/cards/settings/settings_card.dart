import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../theme/app_theme.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const SettingsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColors.black).withAlpha(15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor ?? AppColors.black, size: 20),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: textColor ?? AppColors.black,
                ),
              ),
              const Spacer(),
              const Icon(Iconsax.arrow_right_3, size: 16, color: AppColors.coolGrey),
            ],
          ),
        ),
      ),
    );
  }
}
