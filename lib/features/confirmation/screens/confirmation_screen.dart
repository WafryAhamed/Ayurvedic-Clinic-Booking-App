import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/primary_button.dart';
import '../../booking/providers/booking_provider.dart';

/// Booking confirmation screen showing success message and booking details
class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToHome() {
    // Reset booking provider
    context.read<BookingProvider>().reset();

    // Navigate to home
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final booking = context.read<BookingProvider>().confirmedBooking;

    if (booking == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No booking confirmation found'),
              SizedBox(height: AppSpacing.md),
              ElevatedButton(
                onPressed: _goToHome,
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: AppSpacing.xxl),

                    // Success Animation
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_circle,
                          size: 80,
                          color: AppColors.success,
                        ),
                      ),
                    ),

                    SizedBox(height: AppSpacing.lg),

                    // Success Message
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            'Booking Confirmed!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.success,
                                ),
                          ),
                          SizedBox(height: AppSpacing.sm),
                          Text(
                            'Your appointment has been successfully booked',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppSpacing.xxl),

                    // Booking ID Card
                    Card(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          children: [
                            Text(
                              'Booking ID',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                            SizedBox(height: AppSpacing.xs),
                            Text(
                              booking.id,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                    letterSpacing: 1.2,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: AppSpacing.lg),

                    // Appointment Details
                    Text(
                      'Appointment Details',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: AppSpacing.sm),

                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          children: [
                            // Doctor
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.md,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      booking.doctor.profileImage,
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ),
                                SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        booking.doctor.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        booking.doctor.specialization,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppColors.textSecondary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: AppSpacing.md),
                            const Divider(),
                            SizedBox(height: AppSpacing.md),

                            // Date
                            _buildInfoRow(
                              context,
                              icon: Icons.calendar_today,
                              label: 'Date',
                              value: DateFormat(
                                'EEEE, MMMM d, y',
                              ).format(booking.selectedDate),
                            ),

                            SizedBox(height: AppSpacing.sm),

                            // Time
                            _buildInfoRow(
                              context,
                              icon: Icons.access_time,
                              label: 'Time',
                              value: booking.selectedTimeSlot,
                            ),

                            SizedBox(height: AppSpacing.sm),

                            // Patient Name
                            _buildInfoRow(
                              context,
                              icon: Icons.person,
                              label: 'Patient',
                              value: booking.patientName,
                            ),

                            SizedBox(height: AppSpacing.sm),

                            // Fee
                            _buildInfoRow(
                              context,
                              icon: Icons.payments_outlined,
                              label: 'Consultation Fee',
                              value:
                                  'LKR ${booking.doctor.consultationFee.toStringAsFixed(0)}',
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: AppSpacing.lg),

                    // Important Note
                    Container(
                      padding: EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(
                          color: AppColors.warning.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: AppColors.warning,
                                size: 20,
                              ),
                              SizedBox(width: AppSpacing.sm),
                              Text(
                                'Important',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.warning,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSpacing.sm),
                          Text(
                            '• Please arrive 10 minutes before your appointment\n'
                            '• Bring any relevant medical records\n'
                            '• Save your Booking ID for reference',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.warning,
                                  height: 1.5,
                                ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),

              // ============================================
              // ACTION BUTTONS
              // ============================================

              // Primary: View My Appointments
              PrimaryButton(
                text: 'View My Appointments',
                onPressed: () {
                  context.read<BookingProvider>().reset();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/my-appointments',
                    (route) => false,
                  );
                },
                icon: Icons.calendar_month,
              ),

              SizedBox(height: AppSpacing.sm),

              // Secondary: Book Another Appointment
              OutlinedButton.icon(
                onPressed: () {
                  context.read<BookingProvider>().reset();
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil('/home', (route) => false);
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Book Another Appointment'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),

              SizedBox(height: AppSpacing.sm),

              // Tertiary: Done (Go Home)
              TextButton(onPressed: _goToHome, child: const Text('Done')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
