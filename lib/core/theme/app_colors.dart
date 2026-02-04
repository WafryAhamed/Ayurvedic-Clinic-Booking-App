import 'package:flutter/material.dart';

/// Color constants for the Ayurvedic Clinic Booking App.
///
/// This palette is designed for a calm, trustworthy, healthcare-appropriate
/// aesthetic using a green + white Ayurvedic theme.
///
/// COLOR PALETTE:
/// - Darkest Green:    #051F20
/// - Dark Green:       #0B2B26
/// - Primary Green:    #163832
/// - Secondary Green:  #235347
/// - Soft Green:       #8EB69B
/// - Light Green Tint: #DAF1DE
/// - Main Background:  #FFFFFF
class AppColors {
  // Prevent instantiation
  AppColors._();

  // ============================================
  // PRIMARY PALETTE - Ayurvedic Green Theme
  // ============================================

  /// Primary Green - Main UI elements, buttons, active states
  /// Hex: #163832
  static const Color primary = Color(0xFF163832);

  /// Secondary Green - Secondary elements, accents
  /// Hex: #235347
  static const Color secondary = Color(0xFF235347);

  /// Soft Green - Inactive icons, subtle borders, dividers
  /// Hex: #8EB69B
  static const Color softGreen = Color(0xFF8EB69B);

  /// Light Green Tint - Surface cards, input backgrounds, glass effects
  /// Hex: #DAF1DE
  static const Color lightGreenTint = Color(0xFFDAF1DE);

  /// Dark Green - Deep accents, emphasis text
  /// Hex: #0B2B26
  static const Color darkGreen = Color(0xFF0B2B26);

  /// Darkest Green - Primary text color
  /// Hex: #051F20
  static const Color darkestGreen = Color(0xFF051F20);

  // ============================================
  // BACKGROUND COLORS
  // ============================================

  /// Main Background - Pure white for calm, clean aesthetic
  /// Hex: #FFFFFF
  static const Color background = Color(0xFFFFFFFF);

  /// Surface Color - Light green tint for cards and surfaces
  /// Hex: #DAF1DE
  static const Color surface = Color(0xFFDAF1DE);

  // ============================================
  // TEXT COLORS
  // ============================================

  /// Text Primary - Darkest green for main text
  /// Hex: #051F20
  static const Color textPrimary = Color(0xFF051F20);

  /// Text Secondary - Secondary green for supporting text
  /// Hex: #235347
  static const Color textSecondary = Color(0xFF235347);

  // ============================================
  // FUNCTIONAL COLORS
  // ============================================

  /// Error - Soft red for errors (kept for accessibility)
  static const Color error = Color(0xFFD32F2F);

  /// Success - Primary green (aligns with theme)
  static const Color success = Color(0xFF163832);

  /// Warning - Soft amber for warnings
  static const Color warning = Color(0xFFE6A23C);

  // ============================================
  // UI ELEMENT COLORS
  // ============================================

  /// Divider - Soft green at low opacity for subtle borders
  /// Hex: #8EB69B
  static const Color divider = Color(0xFF8EB69B);

  /// Disabled - Muted version of soft green
  static const Color disabled = Color(0xFFB8C9BC);

  /// Icon Inactive - Soft green for inactive icons
  /// Hex: #8EB69B
  static const Color iconInactive = Color(0xFF8EB69B);

  /// Pure white
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black
  static const Color black = Color(0xFF000000);

  // ============================================
  // GRADIENT COLORS
  // ============================================

  /// Primary gradient - From primary to secondary green
  static const List<Color> primaryGradient = [
    Color(0xFF163832), // Primary Green
    Color(0xFF235347), // Secondary Green
  ];

  /// Soft gradient - For subtle backgrounds
  static const List<Color> softGradient = [
    Color(0xFFDAF1DE), // Light Green Tint
    Color(0xFFFFFFFF), // White
  ];

  // ============================================
  // GLASS EFFECT COLORS
  // ============================================

  /// Glass background - Light green tint with transparency
  static Color glassBackground = const Color(0xFFDAF1DE).withValues(alpha: 0.7);

  /// Glass border - Soft green with low opacity
  static Color glassBorder = const Color(0xFF8EB69B).withValues(alpha: 0.4);

  /// Glass shadow - Soft green shadow
  static Color glassShadow = const Color(0xFF163832).withValues(alpha: 0.1);
}
