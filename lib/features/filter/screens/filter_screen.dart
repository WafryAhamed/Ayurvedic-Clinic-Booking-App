import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/primary_button.dart';
import '../../home/providers/doctor_provider.dart';
import '../../../domain/repositories/doctor_repository.dart';

/// Filter and sort screen for doctors
class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Selected specializations
  final Set<String> _selectedSpecializations = {};

  // Experience range
  RangeValues _experienceRange = const RangeValues(0, 30);

  // Fee range (in thousands)
  RangeValues _feeRange = const RangeValues(0, 5);

  // Minimum rating
  double _minRating = 0;

  // Sort option
  DoctorSortBy _sortBy = DoctorSortBy.rating;
  bool _sortAscending = false;

  // Available specializations
  final List<String> _specializations = [
    'Panchakarma Specialist',
    'Herbal Medicine Expert',
    'General Ayurvedic Physician',
    'Wellness & Lifestyle Consultant',
    'Traditional Ayurvedic Therapist',
    'Ayurvedic Dermatologist',
    'Ayurvedic Nutritionist',
    'Pediatric Ayurveda Specialist',
  ];

  void _applyFilters() {
    final provider = context.read<DoctorProvider>();

    // Apply filters
    provider.filterDoctors(
      specializations: _selectedSpecializations.isEmpty
          ? null
          : _selectedSpecializations.toList(),
      minExperience: _experienceRange.start.round(),
      maxExperience: _experienceRange.end.round(),
      minFee: _feeRange.start * 1000,
      maxFee: _feeRange.end * 1000,
      minRating: _minRating > 0 ? _minRating : null,
    );

    // Navigate back
    Navigator.of(context).pop();
  }

  void _clearFilters() {
    setState(() {
      _selectedSpecializations.clear();
      _experienceRange = const RangeValues(0, 30);
      _feeRange = const RangeValues(0, 5);
      _minRating = 0;
      _sortBy = DoctorSortBy.rating;
      _sortAscending = false;
    });

    context.read<DoctorProvider>().clearFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter & Sort'),
        actions: [
          TextButton(
            onPressed: _clearFilters,
            child: Text('Clear', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(AppSpacing.md),
              children: [
                // Specialization Filter
                _buildSectionTitle('Specialization'),
                _buildSpecializationChips(),
                SizedBox(height: AppSpacing.lg),

                // Experience Range
                _buildSectionTitle('Years of Experience'),
                _buildExperienceSlider(),
                SizedBox(height: AppSpacing.lg),

                // Fee Range
                _buildSectionTitle('Consultation Fee (LKR)'),
                _buildFeeSlider(),
                SizedBox(height: AppSpacing.lg),

                // Minimum Rating
                _buildSectionTitle('Minimum Rating'),
                _buildRatingSlider(),
                SizedBox(height: AppSpacing.lg),

                // Sort Options
                _buildSectionTitle('Sort By'),
                _buildSortOptions(),
                SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),

          // Apply Button
          Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: PrimaryButton(
              text: 'Apply Filters',
              onPressed: _applyFilters,
              icon: Icons.check,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
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

  Widget _buildSpecializationChips() {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: _specializations.map((spec) {
        final isSelected = _selectedSpecializations.contains(spec);
        return FilterChip(
          label: Text(spec),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedSpecializations.add(spec);
              } else {
                _selectedSpecializations.remove(spec);
              }
            });
          },
          selectedColor: AppColors.primary.withOpacity(0.2),
          checkmarkColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 12,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExperienceSlider() {
    return Column(
      children: [
        RangeSlider(
          values: _experienceRange,
          min: 0,
          max: 30,
          divisions: 30,
          labels: RangeLabels(
            '${_experienceRange.start.round()} yrs',
            '${_experienceRange.end.round()} yrs',
          ),
          onChanged: (values) {
            setState(() {
              _experienceRange = values;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_experienceRange.start.round()} years',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '${_experienceRange.end.round()} years',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeeSlider() {
    return Column(
      children: [
        RangeSlider(
          values: _feeRange,
          min: 0,
          max: 5,
          divisions: 10,
          labels: RangeLabels(
            'LKR ${(_feeRange.start * 1000).round()}',
            'LKR ${(_feeRange.end * 1000).round()}',
          ),
          onChanged: (values) {
            setState(() {
              _feeRange = values;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LKR ${(_feeRange.start * 1000).round()}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'LKR ${(_feeRange.end * 1000).round()}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSlider() {
    return Column(
      children: [
        Slider(
          value: _minRating,
          min: 0,
          max: 5,
          divisions: 10,
          label: _minRating > 0 ? _minRating.toStringAsFixed(1) : 'Any',
          onChanged: (value) {
            setState(() {
              _minRating = value;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Any Rating', style: Theme.of(context).textTheme.bodyMedium),
              Text(
                _minRating > 0 ? '${_minRating.toStringAsFixed(1)}+ ⭐' : '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSortOptions() {
    return Column(
      children: [
        _buildSortOption('Rating', DoctorSortBy.rating, Icons.star),
        _buildSortOption('Experience', DoctorSortBy.experience, Icons.work),
        _buildSortOption('Fee', DoctorSortBy.fee, Icons.money),
        _buildSortOption('Name', DoctorSortBy.name, Icons.sort_by_alpha),
      ],
    );
  }

  Widget _buildSortOption(String label, DoctorSortBy sortBy, IconData icon) {
    final isSelected = _sortBy == sortBy;
    return Card(
      color: isSelected ? AppColors.surface : AppColors.white,
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
        trailing: isSelected
            ? Icon(
                _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                color: AppColors.primary,
              )
            : null,
        onTap: () {
          setState(() {
            if (_sortBy == sortBy) {
              _sortAscending = !_sortAscending;
            } else {
              _sortBy = sortBy;
              _sortAscending = sortBy == DoctorSortBy.name;
            }
          });
        },
      ),
    );
  }
}
