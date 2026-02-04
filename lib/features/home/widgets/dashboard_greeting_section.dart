import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Dashboard greeting section with time-based welcome message and date display.
///
/// UX Decision: Establishes trust and context immediately upon screen load.
/// The friendly greeting reduces cognitive load and creates a calm,
/// personalized experience suitable for healthcare applications.
class DashboardGreetingSection extends StatelessWidget {
  const DashboardGreetingSection({super.key});

  /// Returns appropriate greeting based on current time of day.
  /// Morning: 5AM - 12PM, Afternoon: 12PM - 5PM, Evening: 5PM - 5AM
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  /// Formats today's date in a friendly, readable format.
  /// Example: "Tuesday, 4 February 2025"
  String _getFormattedDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, d MMMM yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        // Subtle gradient for visual interest while maintaining calm aesthetic
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.secondary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main greeting with wave emoji for friendly tone
          Row(
            children: [
              Text(
                _getGreeting(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(width: AppSpacing.sm),
              // Wave emoji adds warmth without being unprofessional
              const Text('👋', style: TextStyle(fontSize: 24)),
            ],
          ),

          SizedBox(height: AppSpacing.xs),

          // Subtitle establishes trust and care
          Text(
            'Your health, our priority',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: AppSpacing.sm),

          // Date display helps users orient themselves
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColors.primary,
              ),
              SizedBox(width: AppSpacing.xs),
              Text(
                _getFormattedDate(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
