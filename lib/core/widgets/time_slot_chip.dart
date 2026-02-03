import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Selectable time slot chip widget
class TimeSlotChip extends StatelessWidget {
  final String timeSlot;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isAvailable;

  const TimeSlotChip({
    super.key,
    required this.timeSlot,
    required this.isSelected,
    required this.onTap,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: !isAvailable
              ? AppColors.disabled.withValues(alpha: 0.2)
              : isSelected
              ? AppColors.primary
              : AppColors.surface,
          border: Border.all(
            color: !isAvailable
                ? AppColors.disabled
                : isSelected
                ? AppColors.primary
                : AppColors.divider,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Text(
          timeSlot,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: !isAvailable
                ? AppColors.textSecondary
                : isSelected
                ? AppColors.white
                : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
