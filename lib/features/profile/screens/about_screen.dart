import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// About Screen
/// Displays app information, version, and credits
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String appVersion = '1.0.0'; // Static version

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('About')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            SizedBox(height: AppSpacing.xl),

            // App Icon/Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: const Center(
                child: Text('🌿', style: TextStyle(fontSize: 48)),
              ),
            ),

            SizedBox(height: AppSpacing.lg),

            // App Name
            Text(
              'Ayurvedic Clinic',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: AppSpacing.sm),

            // Version
            Text(
              'Version $appVersion',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),

            SizedBox(height: AppSpacing.xl),

            // Description Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About the App',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Text(
                      'Ayurvedic Clinic is your trusted companion for booking appointments '
                      'with experienced Ayurvedic practitioners. Our app makes it easy to '
                      'find and connect with qualified doctors, manage your appointments, '
                      'and take care of your health using traditional Ayurvedic medicine.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSpacing.md),

            // Features Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key Features',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: AppSpacing.sm),
                    _buildFeatureItem(context, '🔍 Search and filter doctors'),
                    _buildFeatureItem(context, '📅 Book appointments easily'),
                    _buildFeatureItem(context, '📋 Manage your appointments'),
                    _buildFeatureItem(
                      context,
                      '💚 Focus on Ayurvedic wellness',
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSpacing.md),

            // Contact Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: AppSpacing.sm),
                    _buildContactItem(
                      context,
                      Icons.email_rounded,
                      'support@ayurvedicclinic.lk',
                    ),
                    _buildContactItem(
                      context,
                      Icons.phone_rounded,
                      '+94 11 234 5678',
                    ),
                    _buildContactItem(
                      context,
                      Icons.language_rounded,
                      'www.ayurvedicclinic.lk',
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSpacing.xl),

            // Copyright
            Text(
              '© 2026 Ayurvedic Clinic\nAll rights reserved',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),

            SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String feature) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Text(
        feature,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          SizedBox(width: AppSpacing.sm),
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
