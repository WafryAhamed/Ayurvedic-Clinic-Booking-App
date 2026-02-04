import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Appointment Management Screen - Admin (Future Scope)
/// View and manage all clinic appointments
///
/// Features (Stub):
/// - Filter by date
/// - Filter by doctor
/// - Status update (Confirmed / Cancelled / Completed)
/// - Appointment table with Time, Patient, Doctor, Status columns
///
/// NOTE: This is a stub/placeholder UI for future implementation.
/// All data shown is placeholder and not connected to backend.
class AppointmentManagementScreen extends StatelessWidget {
  const AppointmentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Appointment Management')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Future Scope Banner
            _buildFutureScopeBanner(context),

            SizedBox(height: AppSpacing.lg),

            // Section 1: Filter Controls
            Text(
              'Filters',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: AppSpacing.md),
            _buildFilterControls(context),

            SizedBox(height: AppSpacing.xl),

            // Section 2: Status Quick Actions
            Text(
              'Quick Status Update',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: AppSpacing.md),
            _buildStatusActions(context),

            SizedBox(height: AppSpacing.xl),

            // Section 3: Appointments Table
            Text(
              'All Appointments',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: AppSpacing.md),
            _buildAppointmentsTable(context),
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

  /// Builds the filter controls section
  Widget _buildFilterControls(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          // Filter by Date
          _buildFilterDropdown(
            context,
            icon: Icons.calendar_today_outlined,
            label: 'Filter by Date',
            value: 'Select Date',
          ),
          SizedBox(height: AppSpacing.md),

          // Filter by Doctor
          _buildFilterDropdown(
            context,
            icon: Icons.medical_services_outlined,
            label: 'Filter by Doctor',
            value: 'All Doctors',
          ),
          SizedBox(height: AppSpacing.md),

          // Filter by Status
          _buildFilterDropdown(
            context,
            icon: Icons.flag_outlined,
            label: 'Filter by Status',
            value: 'All Statuses',
          ),

          SizedBox(height: AppSpacing.md),

          // Apply Filters Button (Disabled)
          Opacity(
            opacity: 0.6,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.filter_list),
                label: const Text('Apply Filters'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a filter dropdown placeholder
  Widget _buildFilterDropdown(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  /// Builds the status quick action buttons
  Widget _buildStatusActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatusButton(
            context,
            label: 'Confirmed',
            color: AppColors.primary,
            icon: Icons.check_circle_outline,
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildStatusButton(
            context,
            label: 'Cancelled',
            color: AppColors.error,
            icon: Icons.cancel_outlined,
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildStatusButton(
            context,
            label: 'Completed',
            color: AppColors.secondary,
            icon: Icons.done_all,
          ),
        ),
      ],
    );
  }

  /// Builds a status action button
  Widget _buildStatusButton(
    BuildContext context, {
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Opacity(
      opacity: 0.6,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: color),
            SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the appointments table
  Widget _buildAppointmentsTable(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.md),
                topRight: Radius.circular(AppRadius.md),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Time',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Patient Name',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Doctor',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Status',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Empty state placeholder
          Padding(
            padding: EdgeInsets.all(AppSpacing.xl),
            child: Column(
              children: [
                Icon(
                  Icons.event_note_outlined,
                  size: 48,
                  color: AppColors.textSecondary.withValues(alpha: 0.5),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'No appointment data available',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Connect to backend to view and manage appointments',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
