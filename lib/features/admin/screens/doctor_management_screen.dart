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
///
/// This is a stub/placeholder UI for future implementation.
class DoctorManagementScreen extends StatelessWidget {
  const DoctorManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Doctor Management')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Future Scope Banner
            _buildFutureScopeBanner(context),

            SizedBox(height: AppSpacing.lg),

            // Section 1: Quick Stats
            Text(
              'Doctor Overview',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: AppSpacing.md),
            _buildDoctorStats(context),

            SizedBox(height: AppSpacing.xl),

            // Section 2: Management Actions
            Text(
              'Management Actions',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: AppSpacing.md),
            _buildManagementActions(context),

            SizedBox(height: AppSpacing.xl),

            // Section 3: Doctor List Preview
            Text(
              'Registered Doctors',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: AppSpacing.md),
            _buildDoctorListPreview(context),
          ],
        ),
      ),
    );
  }

  /// Builds the Future Scope banner indicating this is a stub
  Widget _buildFutureScopeBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.warning),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.construction_rounded,
            size: 20,
            color: AppColors.warning,
          ),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '🚧 Admin Portal – Future Scope (Stub UI)',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.warning,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the doctor statistics cards
  Widget _buildDoctorStats(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.medical_services_outlined,
            label: 'Active Doctors',
            value: '--',
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _buildStatCard(
            context,
            icon: Icons.schedule_outlined,
            label: 'On Leave',
            value: '--',
            color: AppColors.warning,
          ),
        ),
      ],
    );
  }

  /// Builds an individual statistics card
  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, size: 24, color: color),
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  /// Builds the management action buttons
  Widget _buildManagementActions(BuildContext context) {
    return Column(
      children: [
        // Add Doctor Button (Disabled Stub)
        _buildActionButton(
          context,
          icon: Icons.person_add_outlined,
          label: 'Add New Doctor',
          subtitle: 'Register a new doctor to the clinic',
          onTap: null, // Disabled - stub
        ),
        SizedBox(height: AppSpacing.sm),
        // Manage Schedules Button (Disabled Stub)
        _buildActionButton(
          context,
          icon: Icons.calendar_month_outlined,
          label: 'Manage Schedules',
          subtitle: 'Configure doctor availability and time slots',
          onTap: null, // Disabled - stub
        ),
        SizedBox(height: AppSpacing.sm),
        // View All Doctors Button (Disabled Stub)
        _buildActionButton(
          context,
          icon: Icons.people_outline,
          label: 'View All Doctors',
          subtitle: 'Browse complete doctor directory',
          onTap: null, // Disabled - stub
        ),
      ],
    );
  }

  /// Builds an individual action button
  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    final isDisabled = onTap == null;
    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.divider),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(icon, size: 24, color: AppColors.primary),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          subtitle,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: AppColors.textSecondary),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the doctor list preview (empty state)
  Widget _buildDoctorListPreview(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Icon(
            Icons.medical_services_outlined,
            size: 48,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'No doctor data available',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Connect to backend to manage doctors',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
