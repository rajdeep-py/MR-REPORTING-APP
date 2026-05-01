import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomFooter extends StatelessWidget {
  final String? headerText;
  final String? tagline;
  final bool showLogo;

  const CustomFooter({
    super.key,
    this.headerText,
    this.tagline,
    this.showLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Stack(
        children: [
          // Content
          Column(
            children: [
              if (showLogo)
                Image.asset(
                  'assets/logo/logo.png',
                  height: 100,
                  color: AppColors.black.withAlpha(
                    128,
                  ), // Greyish overlay effect via transparency
                ),
              if (headerText != null) ...[
                const SizedBox(height: 6),
                Text(
                  headerText!.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    letterSpacing: 4,
                    fontSize: 14,
                    color: AppColors.black.withAlpha(150),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
              if (tagline != null) ...[
                const SizedBox(height: 8),
                Text(
                  tagline!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.coolGrey,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
              const SizedBox(height: 32),
              const Divider(color: AppColors.coolGrey, thickness: 0.5),
              const SizedBox(height: 24),
              Text(
                '© 2026 NAIYO24. ALL RIGHTS RESERVED.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color: AppColors.coolGrey.withAlpha(150),
                ),
              ),
            ],
          ),

          // Subtle greyish overlay over everything if needed (Alternative interpretation)
          // Positioned.fill(
          //   child: Container(
          //     color: Colors.grey.withAlpha(10), // Very subtle tint
          //   ),
          // ),
        ],
      ),
    );
  }
}
