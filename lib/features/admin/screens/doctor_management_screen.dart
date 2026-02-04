import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Doctor Management Screen (Future Scope)
/// Manage doctor profiles and information
/// Admin dashboard for managing doctors and appointments
///
/// NOTE: Doctor registration is NOT handled in the mobile app.
/// Doctors are registered and approved by clinic administrators via the admin web portal.
/// This screen only lists existing doctors for status management.
class DoctorManagementScreen extends StatelessWidget {
  const DoctorManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Doctor Management')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.medical_services_rounded,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: AppSpacing.xl),

              Text(
                'Doctor Management',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: AppSpacing.md),

              Text(
                'Add, edit, and manage doctor profiles',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppSpacing.xl),

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
            ],
          ),
        ),
      ),
    );
  }
}
