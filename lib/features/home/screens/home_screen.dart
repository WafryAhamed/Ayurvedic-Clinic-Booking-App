import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/doctor_provider.dart';
import '../../../domain/entities/doctor.dart';
import '../../../domain/entities/appointment.dart';
import '../../../features/appointments/providers/appointment_provider.dart';
// Dashboard widget imports
import '../widgets/dashboard_greeting_section.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/upcoming_appointment_card.dart';
import '../widgets/health_tip_card.dart';
import '../../../core/widgets/skeleton_doctor_card.dart';

/// Patient Dashboard - Home screen displaying comprehensive dashboard with:
/// - Greeting section (context & trust)
/// - Quick action cards (primary interactions)
/// - Upcoming appointment summary (conditional)
/// - Featured doctors (horizontal scroll)
/// - Health tips (value-added content)
///
/// UX Architecture: Information is organized by priority - critical actions
/// and time-sensitive information appear first. The calm aesthetic and
/// clear hierarchy reduce cognitive load for healthcare contexts.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Scroll controller for "Our Doctors" quick action
  final ScrollController _scrollController = ScrollController();

  // Key for scrolling to doctors section
  final GlobalKey _doctorsSectionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Load doctors when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DoctorProvider>().loadDoctors();
      // Also load appointments for upcoming appointment card
      context.read<AppointmentProvider>().fetchAppointments();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Scrolls to the doctors section smoothly
  void _scrollToDoctors() {
    if (_doctorsSectionKey.currentContext != null) {
      Scrollable.ensureVisible(
        _doctorsSectionKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayurvedic Wellness'),
        actions: [
          // Search icon
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Doctors',
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
          ),
          // Filter icon
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter Doctors',
            onPressed: () {
              Navigator.of(context).pushNamed('/filter');
            },
          ),
        ],
      ),
      body: Consumer2<DoctorProvider, AppointmentProvider>(
        builder: (context, doctorProvider, appointmentProvider, child) {
          // Loading state for initial load
          if (doctorProvider.isLoading && doctorProvider.doctors.isEmpty) {
            return _buildLoadingState();
          }

          // Error state
          if (doctorProvider.hasError) {
            return _buildErrorState(
              doctorProvider.errorMessage ?? 'Unknown error',
            );
          }

          // Success state with dashboard content
          return _buildDashboard(doctorProvider.doctors, appointmentProvider);
        },
      ),
    );
  }

  /// Build loading state UI with skeleton loaders
  Widget _buildLoadingState() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          // Greeting skeleton
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
          ),
          SizedBox(height: AppSpacing.lg),

          // Quick actions skeleton
          Row(
            children: List.generate(
              3,
              (index) => Expanded(
                child: Container(
                  height: 88,
                  margin: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: AppSpacing.lg),

          // Doctors List Skeleton
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 280,
                      child: const SkeletonDoctorCard(),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build error state UI
  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: AppColors.error),
            SizedBox(height: AppSpacing.md),
            Text(
              'Oops!',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: () {
                context.read<DoctorProvider>().loadDoctors();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  /// Build the main dashboard with all sections
  Widget _buildDashboard(
    List<Doctor> doctors,
    AppointmentProvider appointmentProvider,
  ) {
    // Get the next upcoming confirmed appointment
    final upcomingAppointment = _getNextUpcomingAppointment(
      appointmentProvider.appointments,
    );

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          context.read<DoctorProvider>().loadDoctors(),
          context.read<AppointmentProvider>().fetchAppointments(),
        ]);
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============================================
            // SECTION 1: Greeting (Context & Trust)
            // UX: Establishes friendly, personalized experience
            // ============================================
            const DashboardGreetingSection(),

            SizedBox(height: AppSpacing.lg),

            // ============================================
            // SECTION 2: Quick Action Cards
            // UX: Primary interactions - max 3 above fold
            // ============================================
            Row(
              children: [
                // Primary action: Book Appointment
                QuickActionCard(
                  icon: Icons.calendar_month,
                  label: 'Book\nAppointment',
                  isPrimary: true,
                  onTap: () => _scrollToDoctors(),
                ),
                SizedBox(width: AppSpacing.sm),

                // Secondary: My Appointments
                QuickActionCard(
                  icon: Icons.event_note,
                  label: 'My\nAppointments',
                  onTap: () {
                    Navigator.of(context).pushNamed('/my-appointments');
                  },
                ),
                SizedBox(width: AppSpacing.sm),

                // Secondary: Our Doctors
                QuickActionCard(
                  icon: Icons.medical_services,
                  label: 'Our\nDoctors',
                  onTap: () => _scrollToDoctors(),
                ),
              ],
            ),

            SizedBox(height: AppSpacing.lg),

            // ============================================
            // SECTION 3: Upcoming Appointment Summary
            // UX: Shows ONLY next appointment to reduce overload
            // ============================================
            UpcomingAppointmentCard(
              appointment: upcomingAppointment,
              onViewDetails: upcomingAppointment != null
                  ? () {
                      Navigator.of(context).pushNamed(
                        '/appointment-details',
                        arguments: upcomingAppointment,
                      );
                    }
                  : null,
              onBookNow: upcomingAppointment == null
                  ? () => _scrollToDoctors()
                  : null,
            ),

            SizedBox(height: AppSpacing.lg),

            // ============================================
            // SECTION 4: Featured Doctors (Horizontal Scroll)
            // UX: Encourages exploration without overwhelming
            // ============================================
            _buildDoctorsSection(doctors),

            SizedBox(height: AppSpacing.lg),

            // ============================================
            // SECTION 5: Health Tips (Value-Added Content)
            // UX: Always shown to provide value even in empty states
            // ============================================
            _buildHealthTipsSection(),

            // Bottom padding for safe area
            SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  /// Gets the next upcoming confirmed appointment
  Appointment? _getNextUpcomingAppointment(List<Appointment> appointments) {
    if (appointments.isEmpty) return null;

    final now = DateTime.now();
    final upcoming = appointments
        .where(
          (apt) =>
              apt.status == AppointmentStatus.confirmed &&
              apt.appointmentDate.isAfter(now),
        )
        .toList();

    if (upcoming.isEmpty) return null;

    // Sort by date and return the nearest one
    upcoming.sort((a, b) => a.appointmentDate.compareTo(b.appointmentDate));
    return upcoming.first;
  }

  /// Build the featured doctors section with horizontal scroll
  Widget _buildDoctorsSection(List<Doctor> doctors) {
    // Show empty state if no doctors
    if (doctors.isEmpty) {
      return _buildEmptyDoctorsState();
    }

    // Take only first 4 for featured section
    final featuredDoctors = doctors.take(4).toList();

    return Column(
      key: _doctorsSectionKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Doctors',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {
                // Already on home/doctors list - this scrolls to show more
                Navigator.of(context).pushNamed('/search');
              },
              child: Text(
                'See All',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: AppSpacing.sm),

        // Horizontal scrollable doctors list
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: featuredDoctors.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              final doctor = featuredDoctors[index];
              return SizedBox(
                width: 280,
                child: _buildCompactDoctorCard(doctor),
              );
            },
          ),
        ),

        SizedBox(height: AppSpacing.md),

        // "See all doctors" indicator
        Text(
          '${doctors.length} doctors available',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  /// Builds a compact doctor card for horizontal list
  Widget _buildCompactDoctorCard(Doctor doctor) {
    return Card(
      elevation: 2,
      shadowColor: AppColors.primary.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(
          color: AppColors.divider.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/doctor-details', arguments: doctor);
        },
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Profile image
                  Container(
                    width: 56,
                    height: 56,
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
                        doctor.profileImage,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),

                  SizedBox(width: AppSpacing.sm),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          doctor.specialization,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.primary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Experience and rating
              Row(
                children: [
                  Icon(
                    Icons.work_outline,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    '${doctor.experienceYears} yrs',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(width: AppSpacing.md),
                  Icon(Icons.star, size: 14, color: Colors.amber),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    doctor.rating.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.sm),

              // Fee and View button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(
                      'LKR ${doctor.consultationFee.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    'View →',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build empty state for doctors section
  Widget _buildEmptyDoctorsState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Icon(
            Icons.medical_services_outlined,
            size: 48,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'No Doctors Available',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Check back later for availability',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  /// Build the health tips section
  Widget _buildHealthTipsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Icon(Icons.spa_outlined, size: 20, color: AppColors.primary),
            SizedBox(width: AppSpacing.sm),
            Text(
              'Ayurvedic Wellness Tips',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),

        SizedBox(height: AppSpacing.md),

        // Health tip cards
        ...HealthTipsData.tips.map(
          (tip) => Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.sm),
            child: HealthTipCard(emoji: tip['emoji']!, tip: tip['tip']!),
          ),
        ),
      ],
    );
  }
}
