import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/primary_button.dart';
import '../providers/booking_provider.dart';

/// Booking review screen to confirm all details before booking
class BookingReviewScreen extends StatelessWidget {
  const BookingReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Booking')),
      body: Consumer<BookingProvider>(
        builder: (context, provider, child) {
          final doctor = provider.selectedDoctor;
          final selectedDate = provider.selectedDate;
          final selectedTimeSlot = provider.selectedTimeSlot;

          if (doctor == null ||
              selectedDate == null ||
              selectedTimeSlot == null) {
            return const Center(child: Text('Missing booking information'));
          }

          return ListView(
            padding: EdgeInsets.all(AppSpacing.md),
            children: [
              // Review info message
              Container(
                padding: EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.primary),
                    SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Please review your booking details carefully before confirming',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.lg),

              // Doctor Information Section
              _buildSectionTitle(context, 'Doctor Information'),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(AppRadius.md),
                            ),
                            child: Center(
                              child: Text(
                                doctor.profileImage,
                                style: const TextStyle(fontSize: 35),
                              ),
                            ),
                          ),
                          SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor.name,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: AppSpacing.xs),
                                Text(
                                  doctor.specialization,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: AppColors.primary),
                                ),
                                SizedBox(height: AppSpacing.xs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(width: AppSpacing.xs),
                                    Text(
                                      '${doctor.rating} • ${doctor.experienceYears} years exp.',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
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
              ),

              SizedBox(height: AppSpacing.lg),

              // Appointment Details Section
              _buildSectionTitle(context, 'Appointment Details'),
              Card(
                child: Column(
                  children: [
                    _buildDetailRow(
                      context,
                      icon: Icons.calendar_today,
                      label: 'Date',
                      value: DateFormat('EEEE, MMMM d, y').format(selectedDate),
                    ),
                    const Divider(height: 1),
                    _buildDetailRow(
                      context,
                      icon: Icons.access_time,
                      label: 'Time',
                      value: selectedTimeSlot,
                    ),
                    const Divider(height: 1),
                    _buildDetailRow(
                      context,
                      icon: Icons.payments_outlined,
                      label: 'Consultation Fee',
                      value: 'LKR ${doctor.consultationFee.toStringAsFixed(0)}',
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.lg),

              // Patient Information Section
              _buildSectionTitle(context, 'Patient Information'),
              Card(
                child: Column(
                  children: [
                    _buildDetailRow(
                      context,
                      icon: Icons.person,
                      label: 'Name',
                      value: provider.patientName,
                    ),
                    const Divider(height: 1),
                    _buildDetailRow(
                      context,
                      icon: Icons.phone,
                      label: 'Phone',
                      value: provider.patientPhone,
                    ),
                    if (provider.patientAge != null) ...[
                      const Divider(height: 1),
                      _buildDetailRow(
                        context,
                        icon: Icons.cake,
                        label: 'Age',
                        value: '${provider.patientAge} years',
                      ),
                    ],
                    if (provider.medicalNotes.isNotEmpty) ...[
                      const Divider(height: 1),
                      _buildDetailRow(
                        context,
                        icon: Icons.notes,
                        label: 'Medical Notes',
                        value: provider.medicalNotes,
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.xxl),
            ],
          );
        },
      ),

      // Confirm Button
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Consumer<BookingProvider>(
          builder: (context, provider, child) {
            return PrimaryButton(
              text: 'Confirm Booking',
              onPressed: () => _confirmBooking(context, provider),
              isLoading: provider.isLoading,
              icon: Icons.check_circle,
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirmBooking(
    BuildContext context,
    BookingProvider provider,
  ) async {
    final success = await provider.confirmBooking();

    if (success && context.mounted) {
      // Navigate to confirmation screen
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/confirmation',
        (route) => route.settings.name == '/home',
      );
    } else if (context.mounted) {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage ?? 'Failed to confirm booking'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
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
                SizedBox(height: AppSpacing.xs),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
