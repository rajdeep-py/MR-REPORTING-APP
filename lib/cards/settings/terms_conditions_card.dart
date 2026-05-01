import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/terms_conditions.dart';

class TermsConditionsCard extends StatelessWidget {
  final TermsConditionsModel term;

  const TermsConditionsCard({super.key, required this.term});

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
            term.header.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: AppColors.black,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            term.description,
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
