import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../domain/entities/doctor.dart';
import '../../booking/providers/booking_provider.dart';

/// Doctor details screen showing complete doctor information
class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get doctor from route arguments
    final doctor = ModalRoute.of(context)!.settings.arguments as Doctor;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Doctor Image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: AppColors.primaryGradient,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 4),
                    ),
                    child: Center(
                      child: Text(
                        doctor.profileImage,
                        style: const TextStyle(fontSize: 80),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Doctor Information
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          doctor.name,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.amber,
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Text(
                              doctor.rating.toString(),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSpacing.xs),

                  // Specialization
                  Text(
                    doctor.specialization,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg),

                  // Info Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          icon: Icons.work_outline,
                          label: 'Experience',
                          value: '${doctor.experienceYears} Years',
                        ),
                      ),
                      SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _buildInfoCard(
                          context,
                          icon: Icons.payments_outlined,
                          label: 'Consultation',
                          value:
                              'LKR ${doctor.consultationFee.toStringAsFixed(0)}',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSpacing.lg),

                  // About Section
                  _buildSectionTitle(context, 'About'),
                  Text(
                    doctor.bio,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg),

                  // Qualifications Section
                  _buildSectionTitle(context, 'Qualifications'),
                  ...doctor.qualifications.map(
                    (qual) => Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 20,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              qual,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg),

                  // Available Time Slots Section
                  _buildSectionTitle(context, 'Available Time Slots'),
                  ...doctor.availableSlots.map(
                    (slot) => Card(
                      color: AppColors.surface,
                      child: ListTile(
                        leading: Icon(Icons.schedule, color: AppColors.primary),
                        title: Text(
                          slot.day,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text('${slot.startTime} - ${slot.endTime}'),
                        trailing: slot.isAvailable
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xs,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.sm,
                                  ),
                                ),
                                child: Text(
                                  'Available',
                                  style: TextStyle(
                                    color: AppColors.success,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
        ],
      ),

      // Book Appointment Button
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
        child: PrimaryButton(
          text: 'Book Appointment',
          onPressed: () {
            // Set the selected doctor in booking provider
            context.read<BookingProvider>().setDoctor(doctor);

            // Navigate to patient info screen
            Navigator.of(context).pushNamed('/patient-info');
          },
          icon: Icons.calendar_today,
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
    return Card(
      color: AppColors.surface,
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
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
}
