import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        context.go(AppRouter.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Background subtle gradients or patterns could go here
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: ZoomIn(
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.black.withAlpha(10),
                      ),
                      child: Image.asset(
                        'assets/logo/logo.png',
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ),
                ),
                AppGaps.largeV,
                FadeInUp(
                  delay: const Duration(milliseconds: 500),
                  child: Text(
                    'MR APP',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      letterSpacing: 4,
                      color: AppColors.black,
                    ),
                  ),
                ),
                AppGaps.smallV,
                FadeInUp(
                  delay: const Duration(milliseconds: 800),
                  child: Text(
                    'Empowering Medical Representatives',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 14,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: FadeIn(
              delay: const Duration(milliseconds: 1500),
              child: Center(
                child: Text(
                  'Powered by Your Organization',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.darkGrey,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
