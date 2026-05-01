import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/privacy_policy.dart';

class PrivacyPolicyCard extends StatelessWidget {
  final PrivacyPolicyModel policy;

  const PrivacyPolicyCard({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            policy.header.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: AppColors.black,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            policy.description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.darkGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
