import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CompanyHeaderCard extends StatelessWidget {
  final String companyName;
  final String tagline;

  const CompanyHeaderCard({
    super.key,
    required this.companyName,
    required this.tagline,
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
          Image.asset('assets/logo/logo.png', height: 80, color: AppColors.white),
          AppGaps.mediumV,
          Text(
            companyName,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppColors.white,
              fontSize: 32,
              letterSpacing: 2,
            ),
          ),
          Text(
            tagline,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.coolGrey,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
