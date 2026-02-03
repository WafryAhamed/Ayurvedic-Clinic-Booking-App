import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/routes/app_routes.dart';
import '../../providers/appointment_provider.dart';
import '../../widgets/appointment_card.dart';

/// My Appointments Screen - Main appointments list view
/// Displays all user appointments with loading, empty, and error states
class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch appointments when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppointmentProvider>().fetchAppointments();
    });
  }

  // Pull to refresh functionality
  Future<void> _onRefresh() async {
    await context.read<AppointmentProvider>().fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Appointments'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, provider, child) {
          // Loading State
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          // Error State
          if (provider.errorMessage != null) {
            return _buildErrorState(provider.errorMessage!);
          }

          // Empty State
          if (provider.isEmpty) {
            return _buildEmptyState();
          }

          // Success State - Display appointments list
          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: AppColors.primary,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              itemCount: provider.appointments.length,
              itemBuilder: (context, index) {
                final appointment = provider.appointments[index];
                return AppointmentCard(
                  appointment: appointment,
                  onTap: () {
                    // Navigate to appointment details
                    Navigator.pushNamed(
                      context,
                      AppRoutes.appointmentDetails,
                      arguments: appointment,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate back to home
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.home_rounded, color: AppColors.white),
        label: const Text('Home', style: TextStyle(color: AppColors.white)),
      ),
    );
  }

  // Empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.calendar_today_rounded,
                size: 60,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Empty state title
            Text(
              'No Appointments Yet',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),

            // Empty state message
            Text(
              'You haven\'t booked any appointments.\nStart by finding a doctor and booking a consultation.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Action button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              icon: const Icon(Icons.search_rounded),
              label: const Text('Find a Doctor'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Error state widget
  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 60,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Error title
            Text(
              'Oops! Something went wrong',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),

            // Error message
            Text(
              errorMessage,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Retry button
            ElevatedButton.icon(
              onPressed: () {
                context.read<AppointmentProvider>().fetchAppointments();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
