import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../domain/entities/appointment.dart';
import '../../widgets/status_badge.dart';

/// Appointment Details Screen
/// Displays full appointment information with cancel option
class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Receive appointment from navigation arguments
    final appointment =
        ModalRoute.of(context)?.settings.arguments as Appointment?;

    // Handle null appointment
    if (appointment == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Appointment Details')),
        body: const Center(child: Text('Appointment not found')),
      );
    }

    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    final formattedDate = dateFormat.format(appointment.appointmentDate);
    final isCancelled = appointment.status == AppointmentStatus.cancelled;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Appointment Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Badge Section
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatusBadge(status: appointment.status, fontSize: 14),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Booking ID Card
            _buildInfoCard(
              context,
              icon: Icons.confirmation_number_rounded,
              title: 'Booking ID',
              value: appointment.id,
              highlighted: true,
            ),

            // Doctor Information Card
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Doctor Information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      // Doctor Avatar
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          appointment.doctor.profileImage,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment.doctor.name,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              appointment.doctor.specialization,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: AppColors.warning,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${appointment.doctor.rating}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Text(
                                  '${appointment.doctor.experienceYears} years exp.',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Patient Information Card
            _buildInfoCard(
              context,
              icon: Icons.person_rounded,
              title: 'Patient Name',
              value: appointment.patientName,
            ),

            _buildInfoCard(
              context,
              icon: Icons.phone_rounded,
              title: 'Phone Number',
              value: appointment.patientPhone,
            ),

            if (appointment.patientAge != null)
              _buildInfoCard(
                context,
                icon: Icons.cake_rounded,
                title: 'Age',
                value: '${appointment.patientAge} years',
              ),

            // Appointment Date & Time
            _buildInfoCard(
              context,
              icon: Icons.calendar_today_rounded,
              title: 'Appointment Date',
              value: formattedDate,
            ),

            _buildInfoCard(
              context,
              icon: Icons.access_time_rounded,
              title: 'Time Slot',
              value: appointment.timeSlot,
            ),

            // Medical Notes (if any)
            if (appointment.medicalNotes != null &&
                appointment.medicalNotes!.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.notes_rounded,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'Medical Notes',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      appointment.medicalNotes!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

            const SizedBox(height: AppSpacing.xl),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                children: [
                  // Cancel Appointment Button (only if confirmed)
                  if (!isCancelled)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to cancel confirmation
                          Navigator.pushNamed(
                            context,
                            AppRoutes.cancelAppointment,
                            arguments: appointment,
                          );
                        },
                        icon: const Icon(Icons.cancel_rounded),
                        label: const Text('Cancel Appointment'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),

                  const SizedBox(height: AppSpacing.md),

                  // Back Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text('Back to My Appointments'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.divider),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  // Helper method to build info card
  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    bool highlighted = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: highlighted ? AppColors.surface : AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: highlighted
            ? Border.all(color: AppColors.primary, width: 2)
            : null,
        boxShadow: highlighted
            ? null
            : [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: highlighted ? AppColors.primary : AppColors.secondary,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: highlighted ? FontWeight.bold : FontWeight.w600,
                    color: highlighted
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
