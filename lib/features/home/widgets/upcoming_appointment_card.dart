import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/appointment.dart';

/// Card displaying the next upcoming appointment or empty state.
///
/// UX Decision: Shows only the NEXT appointment to reduce cognitive overload.
/// Status badges use color + text (not color alone) for accessibility.
/// Empty state is friendly and encourages booking action.
class UpcomingAppointmentCard extends StatelessWidget {
  final Appointment? appointment;
  final VoidCallback? onViewDetails;
  final VoidCallback? onBookNow;

  const UpcomingAppointmentCard({
    super.key,
    this.appointment,
    this.onViewDetails,
    this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.divider, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: appointment != null
          ? _buildAppointmentContent(context)
          : _buildEmptyState(context),
    );
  }

  /// Builds the appointment details when one exists
  Widget _buildAppointmentContent(BuildContext context) {
    final apt = appointment!;
    final dateStr = DateFormat('EEE, d MMM yyyy').format(apt.appointmentDate);
    final isConfirmed = apt.status == AppointmentStatus.confirmed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with status badge
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Appointment',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            // Status badge - uses color + text for accessibility
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: isConfirmed
                    ? AppColors.secondary.withValues(alpha: 0.2)
                    : AppColors.disabled.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                isConfirmed ? 'Confirmed' : 'Cancelled',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isConfirmed
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: AppSpacing.md),

        // Doctor info row
        Row(
          children: [
            // Doctor profile image placeholder
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  apt.doctor.profileImage,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),

            SizedBox(width: AppSpacing.md),

            // Doctor name and specialization
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    apt.doctor.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    apt.doctor.specialization,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: AppSpacing.md),

        // Date and time info
        Container(
          padding: EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Row(
            children: [
              // Date
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColors.primary,
              ),
              SizedBox(width: AppSpacing.xs),
              Text(
                dateStr,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),

              SizedBox(width: AppSpacing.md),

              // Time
              Icon(
                Icons.access_time_outlined,
                size: 16,
                color: AppColors.primary,
              ),
              SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  apt.timeSlot,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: AppSpacing.md),

        // View Details CTA
        if (onViewDetails != null)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onViewDetails,
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: const Text('View Details'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Builds the empty state when no appointments exist
  Widget _buildEmptyState(BuildContext context) {
    return Column(
      children: [
        // Friendly illustration
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: const Center(
            child: Text('📅', style: TextStyle(fontSize: 32)),
          ),
        ),

        SizedBox(height: AppSpacing.md),

        Text(
          'No Upcoming Appointments',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),

        SizedBox(height: AppSpacing.xs),

        Text(
          'Book your first appointment with our Ayurvedic specialists',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),

        SizedBox(height: AppSpacing.md),

        // Book Now CTA
        if (onBookNow != null)
          ElevatedButton.icon(
            onPressed: onBookNow,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Book Now'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
            ),
          ),
      ],
    );
  }
}
