import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

/// Reschedule Appointment Screen (UI-only for future implementation)
/// This screen is a placeholder showing that rescheduling will be available in a future update
class RescheduleAppointmentScreen extends StatelessWidget {
  const RescheduleAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Reschedule Appointment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.xxl),

            // Coming Soon Icon
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.event_busy_rounded,
                  size: 60,
                  color: AppColors.disabled,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Coming Soon Title
            Text(
              'Rescheduling Feature\nComing Soon',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.md),

            // Description
            Text(
              'The ability to reschedule appointments will be available in a future update. For now, you can cancel your current appointment and book a new one.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Disabled Date Picker Preview (UI Only)
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Section
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 20,
                        color: AppColors.disabled,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Select New Date',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppColors.disabled),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Disabled Date Field
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose a date',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.disabled),
                        ),
                        Icon(
                          Icons.calendar_month_rounded,
                          color: AppColors.disabled,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Time Section
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 20,
                        color: AppColors.disabled,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Select New Time Slot',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppColors.disabled),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Disabled Time Slots
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children:
                        [
                          '09:00 AM',
                          '10:00 AM',
                          '11:00 AM',
                          '02:00 PM',
                          '03:00 PM',
                        ].map((time) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                              border: Border.all(color: AppColors.divider),
                            ),
                            child: Text(
                              time,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.disabled),
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Info Box
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
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
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      'We\'re working hard to bring you this feature soon!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Back Button (Only functional button)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
