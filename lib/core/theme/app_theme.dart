import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_sizes.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // ==========================================
    // COLOR
    // ==========================================
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,

      secondary: AppColors.gold,
      onSecondary: AppColors.textPrimary,

      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,

      error: AppColors.error,
      onError: Colors.white,
    ),

    scaffoldBackgroundColor: AppColors.background,

    // ==========================================
    // TYPOGRAPHY
    // ==========================================
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,

      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,

      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,

      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    ),

    // ==========================================
    // APP BAR
    // ==========================================
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
    ),

    // ==========================================
    // CARD
    // ==========================================
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: const BorderSide(color: AppColors.border),
      ),
    ),

    // ==========================================
    // ELEVATED BUTTON
    // ==========================================
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,

        minimumSize: const Size(double.infinity, AppSizes.buttonHeight),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),

        elevation: 0,

        textStyle: AppTextStyles.labelLarge.copyWith(
          color: AppColors.textOnPrimary,
        ),
      ),
    ),

    // ==========================================
    // OUTLINED BUTTON
    // ==========================================
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,

        minimumSize: const Size(double.infinity, AppSizes.buttonHeight),

        side: const BorderSide(color: AppColors.primary),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),

        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    // ==========================================
    // INPUT
    // ==========================================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.border),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.border),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.error),
      ),

      hintStyle: AppTextStyles.bodyMedium,
    ),

    // ==========================================
    // BOTTOM NAVIGATION
    // ==========================================
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      elevation: 0,

      height: AppSizes.bottomNavHeight,

      indicatorColor: AppColors.xpLight,

      labelTextStyle: WidgetStatePropertyAll(AppTextStyles.labelSmall),

      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary);
        }

        return const IconThemeData(color: AppColors.textSecondary);
      }),
    ),

    // ==========================================
    // DIVIDER
    // ==========================================
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    // ==========================================
    // CHIP
    // ==========================================
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceSecondary,

      selectedColor: AppColors.xpLight,

      labelStyle: AppTextStyles.labelMedium,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),

      side: BorderSide.none,
    ),
  );
}
