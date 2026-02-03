import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Privacy Policy Screen
/// Displays app privacy policy
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
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
              title: '1. Information We Collect',
              content:
                  'We collect information you provide when creating an account, booking appointments, '
                  'and using our services. This includes your name, contact details, and health information '
                  'relevant to your consultations.',
            ),

            _buildSection(
              context,
              title: '2. How We Use Your Information',
              content:
                  'Your information is used to facilitate appointment bookings, communicate with you about '
                  'your appointments, improve our services, and comply with legal obligations.',
            ),

            _buildSection(
              context,
              title: '3. Information Sharing',
              content:
                  'We share your information with healthcare practitioners for appointment purposes. '
                  'We do not sell your personal information to third parties.',
            ),

            _buildSection(
              context,
              title: '4. Data Security',
              content:
                  'We implement appropriate security measures to protect your personal information. '
                  'However, no method of transmission over the internet is 100% secure.',
            ),

            _buildSection(
              context,
              title: '5. Your Rights',
              content:
                  'You have the right to access, correct, or delete your personal information. '
                  'You can also object to processing or request data portability.',
            ),

            _buildSection(
              context,
              title: '6. Cookies and Tracking',
              content:
                  'We may use cookies and similar technologies to enhance your experience and '
                  'analyze app usage. You can control cookie settings through your device.',
            ),

            _buildSection(
              context,
              title: '7. Children\'s Privacy',
              content:
                  'Our service is not intended for children under 13. We do not knowingly collect '
                  'information from children under 13 without parental consent.',
            ),

            _buildSection(
              context,
              title: '8. Changes to Privacy Policy',
              content:
                  'We may update this privacy policy from time to time. We will notify you of any changes '
                  'by posting the new privacy policy on this page.',
            ),

            _buildSection(
              context,
              title: '9. Contact Us',
              content:
                  'If you have questions about this Privacy Policy, please contact us at '
                  'privacy@ayurvedicclinic.lk',
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
