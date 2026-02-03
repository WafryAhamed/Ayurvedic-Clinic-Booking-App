import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/doctor_card.dart';
import '../../home/providers/doctor_provider.dart';
import '../../../domain/entities/doctor.dart';

/// Search screen for finding doctors
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });

    // Debounce search (simple implementation)
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_searchQuery == query) {
        context.read<DoctorProvider>().searchDoctors(query);
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearchChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Doctors')),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(AppSpacing.md),
            color: AppColors.surface,
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by name or specialization...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSearch,
                      )
                    : null,
                filled: true,
                fillColor: AppColors.white,
              ),
            ),
          ),

          // Search Results
          Expanded(
            child: Consumer<DoctorProvider>(
              builder: (context, provider, child) {
                // Initial state
                if (_searchQuery.isEmpty) {
                  return _buildInitialState();
                }

                // Loading state
                if (provider.isLoading) {
                  return _buildLoadingState();
                }

                // Empty state
                if (provider.isEmpty) {
                  return _buildEmptyState(_searchQuery);
                }

                // Success state with results
                return _buildSearchResults(provider.doctors);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Build initial state (before search)
  Widget _buildInitialState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 80, color: AppColors.textSecondary),
            SizedBox(height: AppSpacing.md),
            Text(
              'Search for Doctors',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              'Find your preferred Ayurvedic doctor by name or specialization',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  /// Build loading state
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: AppSpacing.md),
          Text(
            'Searching...',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  /// Build empty state (no results)
  Widget _buildEmptyState(String query) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🔍', style: TextStyle(fontSize: 80)),
            SizedBox(height: AppSpacing.md),
            Text(
              'No Results Found',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              'No doctors found for "$query"',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              'Try different keywords or check spelling',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  /// Build search results
  Widget _buildSearchResults(List<Doctor> doctors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Results count
        Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Text(
            '${doctors.length} Result${doctors.length != 1 ? 's' : ''} Found',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),

        // Doctor list
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
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
        ),
      ],
    );
  }
}
