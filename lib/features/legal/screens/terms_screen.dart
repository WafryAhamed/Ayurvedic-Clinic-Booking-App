import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Terms and Conditions Screen
/// Displays app terms and conditions
class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: AppSpacing.sm),

            Text(
              'Last updated: February 2026',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),

            SizedBox(height: AppSpacing.xl),

            _buildSection(
              context,
              title: '1. Acceptance of Terms',
              content:
                  'By accessing and using the Ayurvedic Clinic mobile application, '
                  'you accept and agree to be bound by the terms and provision of this agreement.',
            ),

            _buildSection(
              context,
              title: '2. Use of Service',
              content:
                  'This application allows you to search for and book appointments with Ayurvedic practitioners. '
                  'You agree to use the service only for lawful purposes and in accordance with these terms.',
            ),

            _buildSection(
              context,
              title: '3. User Responsibilities',
              content:
                  'You are responsible for maintaining the confidentiality of your account information. '
                  'You agree to provide accurate and complete information when booking appointments.',
            ),

            _buildSection(
              context,
              title: '4. Appointment Booking',
              content:
                  'Appointments are subject to doctor availability. The clinic reserves the right to '
                  'reschedule or cancel appointments if necessary. Cancellation policies may apply.',
            ),

            _buildSection(
              context,
              title: '5. Medical Disclaimer',
              content:
                  'This app is a booking platform only. All medical consultations and treatments '
                  'are provided by licensed practitioners. The app does not provide medical advice.',
            ),

            _buildSection(
              context,
              title: '6. Limitation of Liability',
              content:
                  'The clinic shall not be liable for any indirect, incidental, special, consequential '
                  'or punitive damages resulting from your use of the application.',
            ),

            _buildSection(
              context,
              title: '7. Changes to Terms',
              content:
                  'We reserve the right to modify these terms at any time. Continued use of the service '
                  'after changes constitutes acceptance of the modified terms.',
            ),

            _buildSection(
              context,
              title: '8. Contact Information',
              content:
                  'For questions about these Terms and Conditions, please contact us at '
                  'legal@ayurvedicclinic.lk',
            ),

            SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
