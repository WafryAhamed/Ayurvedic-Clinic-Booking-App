import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';

/// Patient Profile Screen
/// Displays user profile information
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.editProfile);
            },
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            SizedBox(height: AppSpacing.lg),

            // Profile Avatar
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 3),
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 60,
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: AppSpacing.lg),

            // Name (Demo data)
            Text(
              'Kasun Wickramasinghe',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: AppSpacing.sm),

            // Email (Demo data)
            Text(
              'kasun.w@example.lk',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),

            SizedBox(height: AppSpacing.xl),

            // Future Enhancement Badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(color: AppColors.warning),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.construction_rounded,
                    size: 16,
                    color: AppColors.warning,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    '🚧 Future Enhancement – Not Implemented',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xl),

            // Profile Info Cards
            _buildInfoCard(
              context,
              icon: Icons.phone_rounded,
              label: 'Phone',
              value: '+94 77 123 4567',
            ),

            _buildInfoCard(
              context,
              icon: Icons.cake_rounded,
              label: 'Age',
              value: '35 years',
            ),

            _buildInfoCard(
              context,
              icon: Icons.location_on_rounded,
              label: 'Address',
              value: 'Colombo, Sri Lanka',
            ),

            SizedBox(height: AppSpacing.lg),

            // Settings Options
            _buildActionTile(
              context,
              icon: Icons.history_rounded,
              title: 'Appointment History',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.myAppointments);
              },
            ),

            _buildActionTile(
              context,
              icon: Icons.info_outline_rounded,
              title: 'About',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.about);
              },
            ),

            _buildActionTile(
              context,
              icon: Icons.description_outlined,
              title: 'Terms & Conditions',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.terms);
              },
            ),

            _buildActionTile(
              context,
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.privacy);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: AppColors.primary),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4),
                Text(value, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
