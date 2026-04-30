import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppColors {
  // Brand Palette
  static const Color black = Color(0xFF000000);
  static const Color darkGrey = Color(0xFF515151);
  static const Color midGrey = Color(0xFFB0B0B0);
  static const Color coolGrey = Color(0xFFABABA9);
  static const Color lightGrey = Color(0xFFF5F5F5); // Light grey for surfaces
  static const Color white = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF00C853);
  static const Color error = Color(0xFFFF5252);

  // Backgrounds
  static const Color background = white;
  static const Color surface = Color(0xFFF9F9F9);
}

class AppGaps {
  static const double screenPadding = 24.0;
  static const double hGap = 16.0;
  static const double vGap = 24.0;
  
  static const Widget smallV = SizedBox(height: 8);
  static const Widget mediumV = SizedBox(height: 16);
  static const Widget largeV = SizedBox(height: 24);
  static const Widget extraLargeV = SizedBox(height: 48);

  static const Widget smallH = SizedBox(width: 8);
  static const Widget mediumH = SizedBox(width: 16);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.black,
      colorScheme: const ColorScheme.light(
        primary: AppColors.black,
        secondary: AppColors.darkGrey,
        surface: AppColors.surface,
        onSurface: AppColors.black,
        error: AppColors.error,
      ),

      // Typography
      fontFamily: 'Lexend',
      textTheme: const TextTheme(
        // Header Text - Bold & Premium
        displayLarge: TextStyle(
          fontFamily: 'Fraunces',
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: AppColors.black,
          letterSpacing: -0.5,
        ),
        // Tagline Text
        displayMedium: TextStyle(
          fontFamily: 'Fraunces',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.darkGrey,
          letterSpacing: -0.2,
        ),
        // Subheading / Title
        titleLarge: TextStyle(
          fontFamily: 'Lexend',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        // Description Text
        bodyLarge: TextStyle(
          fontFamily: 'Lexend',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.darkGrey,
          height: 1.5,
          letterSpacing: 0.15,
        ),
        // Caption Text
        bodySmall: TextStyle(
          fontFamily: 'Lexend',
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: AppColors.coolGrey,
          letterSpacing: 1.0,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.coolGrey.withAlpha(50)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.black, width: 1.5),
        ),
        hintStyle: const TextStyle(color: AppColors.coolGrey),
      ),

      // SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.black,
        contentTextStyle: const TextStyle(color: AppColors.white, fontFamily: 'Lexend'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
      ),
    );
  }

  // Modern Popups
  static void showModernDialog({
    required BuildContext context,
    required String title,
    required String message,
    bool isError = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: (isError ? AppColors.error : AppColors.success).withAlpha(26),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isError ? Iconsax.close_circle : Iconsax.tick_circle,
                  color: isError ? AppColors.error : AppColors.success,
                  size: 40,
                ),
              ),
              AppGaps.mediumV,
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              AppGaps.smallV,
              Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              AppGaps.largeV,
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isError ? AppColors.error : AppColors.success,
                  foregroundColor: AppColors.white,
                ),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Super Sexy SnackBar
  static void showPremiumSnackBar({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: (isError ? AppColors.error : AppColors.success).withAlpha(128),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withAlpha(26),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                isError ? Iconsax.info_circle : Iconsax.tick_circle,
                color: isError ? AppColors.error : AppColors.success,
              ),
              AppGaps.mediumH,
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
