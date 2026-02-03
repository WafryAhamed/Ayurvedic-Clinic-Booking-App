import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Edit Profile Screen
/// Allows users to edit their profile information
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            SizedBox(height: AppSpacing.lg),

            // Avatar with edit button
            Stack(
              children: [
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
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(AppSpacing.sm),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      size: 20,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
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
                  Flexible(
                    child: Text(
                      '🚧 Future Enhancement – Not Implemented',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.warning,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xl),

            // Disabled form fields (UI demonstration)
            _buildDisabledTextField(
              context,
              label: 'Full Name',
              value: 'Kasun Wickramasinghe',
              icon: Icons.person_rounded,
            ),

            _buildDisabledTextField(
              context,
              label: 'Email',
              value: 'kasun.w@example.lk',
              icon: Icons.email_rounded,
            ),

            _buildDisabledTextField(
              context,
              label: 'Phone Number',
              value: '+94 77 123 4567',
              icon: Icons.phone_rounded,
            ),

            _buildDisabledTextField(
              context,
              label: 'Age',
              value: '35',
              icon: Icons.cake_rounded,
            ),

            _buildDisabledTextField(
              context,
              label: 'Address',
              value: 'Colombo, Sri Lanka',
              icon: Icons.location_on_rounded,
            ),

            SizedBox(height: AppSpacing.xl),

            // Info message
            Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.secondary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.secondary,
                    size: 24,
                  ),
                  SizedBox(width: AppSpacing.md),
                  Flexible(
                    child: Text(
                      'Profile editing will be available in a future update',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisabledTextField(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: TextField(
        enabled: false,
        controller: TextEditingController(text: value),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.disabled),
          filled: true,
          fillColor: AppColors.surface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
