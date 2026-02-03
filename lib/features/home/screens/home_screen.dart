import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/doctor_card.dart';
import '../providers/doctor_provider.dart';
import '../../../domain/entities/doctor.dart';

/// Home screen displaying list of doctors
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load doctors when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DoctorProvider>().loadDoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your Doctor'),
        actions: [
          // Search icon
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
          ),
          // Filter icon
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              Navigator.of(context).pushNamed('/filter');
            },
          ),
        ],
      ),
      body: Consumer<DoctorProvider>(
        builder: (context, provider, child) {
          // Loading state
          if (provider.isLoading) {
            return _buildLoadingState();
          }

          // Error state
          if (provider.hasError) {
            return _buildErrorState(provider.errorMessage ?? 'Unknown error');
          }

          // Empty state
          if (provider.isEmpty) {
            return _buildEmptyState();
          }

          // Success state with doctor list
          return _buildDoctorList(provider.doctors);
        },
      ),
    );
  }

  /// Build loading state UI
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: AppSpacing.md),
          Text(
            'Loading doctors...',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
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

  /// Build empty state UI
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🔍', style: TextStyle(fontSize: 80)),
            SizedBox(height: AppSpacing.md),
            Text(
              'No Doctors Found',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              'Try adjusting your search or filters',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                context.read<DoctorProvider>().clearFilters();
                context.read<DoctorProvider>().loadDoctors();
              },
              child: const Text('Clear Filters'),
            ),
          ],
        ),
      ),
    );
  }

  /// Build doctor list UI
  Widget _buildDoctorList(List<Doctor> doctors) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<DoctorProvider>().loadDoctors();
      },
      child: ListView.builder(
        padding: EdgeInsets.all(AppSpacing.md),
        itemCount: doctors.length + 1, // +1 for header
        itemBuilder: (context, index) {
          // Header
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${doctors.length} Doctors Available',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    'Choose the right specialist for you',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          // Doctor card
          final doctor = doctors[index - 1];
          return DoctorCard(
            doctor: doctor,
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed('/doctor-details', arguments: doctor);
            },
          );
        },
      ),
    );
  }
}
