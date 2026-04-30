import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class GreetingCard extends StatelessWidget {
  final String greeting;
  final String userName;
  final String quote;

  const GreetingCard({
    super.key,
    required this.greeting,
    required this.userName,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(50),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$greeting,',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppColors.coolGrey,
              fontSize: 16,
            ),
          ),
          Text(
            userName,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppColors.white,
              fontSize: 28,
            ),
          ),
          AppGaps.mediumV,
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_outline, color: AppColors.white, size: 18),
                AppGaps.smallH,
                Expanded(
                  child: Text(
                    quote,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
