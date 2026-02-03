import 'package:flutter/material.dart';

/// Color constants for the Ayurvedic theme
class AppColors {
  // Prevent instantiation
  AppColors._();

  // Primary Colors - Leaf Green Theme
  static const Color primary = Color(0xFF2E7D32); // Leaf Green
  static const Color secondary = Color(0xFF66BB6A); // Soft Green

  // Background Colors
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color surface = Color(0xFFF1F8E9); // Light Green Tint

  // Text Colors
  static const Color textPrimary = Color(0xFF1B5E20); // Dark Green/Charcoal
  static const Color textSecondary = Color(0xFF616161); // Grey

  // Functional Colors
  static const Color error = Color(0xFFD32F2F); // Red
  static const Color success = Color(0xFF2E7D32); // Same as primary
  static const Color warning = Color(0xFFFF9800); // Orange

  // Additional UI Colors
  static const Color divider = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF2E7D32),
    Color(0xFF66BB6A),
  ];
}
