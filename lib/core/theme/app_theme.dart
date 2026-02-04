import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Application theme configuration for Ayurvedic Clinic Booking App.
///
/// Theme follows a calm, Ayurvedic, trustworthy design with:
/// - White space dominant
/// - Green used as accent, not overload
/// - Soft shadows only
/// - Rounded cards
/// - No aggressive contrast
class AppTheme {
  // Prevent instantiation
  AppTheme._();

  /// Light theme for the application
  /// Optimized for calm, healthcare-appropriate aesthetic
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // ============================================
      // COLOR SCHEME
      // ============================================
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimary,
        onError: AppColors.white,
        outline: AppColors.softGreen,
        surfaceContainerHighest: AppColors.lightGreenTint,
      ),

      // ============================================
      // SCAFFOLD BACKGROUND
      // ============================================
      scaffoldBackgroundColor: AppColors.background,

      // ============================================
      // APP BAR THEME
      // ============================================
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        shadowColor: AppColors.glassShadow,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        actionsIconTheme: const IconThemeData(color: AppColors.primary),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),

      // ============================================
      // TEXT THEME
      // ============================================
      textTheme: TextTheme(
        // Display
        displayLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),

        // Headline
        headlineLarge: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),

        // Title
        titleLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),

        // Body
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
          height: 1.4,
        ),

        // Label
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
      ),

      // ============================================
      // ELEVATED BUTTON THEME
      // ============================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shadowColor: AppColors.glassShadow,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ============================================
      // OUTLINED BUTTON THEME
      // ============================================
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ============================================
      // TEXT BUTTON THEME
      // ============================================
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ============================================
      // INPUT DECORATION THEME
      // ============================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.softGreen.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.textSecondary.withValues(alpha: 0.7),
        ),
      ),

      // ============================================
      // CARD THEME
      // ============================================
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: AppColors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.glassShadow,
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),

      // ============================================
      // DIVIDER THEME
      // ============================================
      dividerTheme: DividerThemeData(
        color: AppColors.softGreen.withValues(alpha: 0.3),
        thickness: 1,
        space: 1,
      ),

      // ============================================
      // ICON THEME
      // ============================================
      iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),

      // ============================================
      // CHIP THEME
      // ============================================
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primary,
        disabledColor: AppColors.disabled,
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        secondaryLabelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: AppColors.softGreen.withValues(alpha: 0.3)),
      ),

      // ============================================
      // FLOATING ACTION BUTTON THEME
      // ============================================
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // ============================================
      // BOTTOM NAVIGATION BAR THEME
      // ============================================
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.iconInactive,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),

      // ============================================
      // SNACKBAR THEME
      // ============================================
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkGreen,
        contentTextStyle: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),

      // ============================================
      // DIALOG THEME
      // ============================================
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        elevation: 8,
        shadowColor: AppColors.glassShadow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        contentTextStyle: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      ),

      // ============================================
      // BOTTOM SHEET THEME
      // ============================================
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.white,
        elevation: 8,
        shadowColor: AppColors.glassShadow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
    );
  }
}

/// App spacing constants
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

/// App border radius constants
class AppRadius {
  AppRadius._();

  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double pill = 100.0;
}
