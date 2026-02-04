import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Tappable action card for primary dashboard interactions.
///
/// UX Decision: Large tap targets (≥48px) and clear visual hierarchy
/// make actions obvious without instructions. The elevated appearance
/// signals interactivity while maintaining a calm aesthetic.
class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.md),
          // Accessibility: Ripple effect provides clear tap feedback
          splashColor: AppColors.primary.withValues(alpha: 0.2),
          highlightColor: AppColors.primary.withValues(alpha: 0.1),
          child: Ink(
            decoration: BoxDecoration(
              // Primary cards use accent color, secondary use surface
              color: isPrimary ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              // Soft shadow for elevated appearance
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(
                    alpha: isPrimary ? 0.3 : 0.1,
                  ),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
              // Subtle border for secondary cards
              border: isPrimary
                  ? null
                  : Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      width: 1,
                    ),
            ),
            child: Container(
              // Minimum height for accessibility (≥48px)
              constraints: const BoxConstraints(minHeight: 88),
              padding: EdgeInsets.symmetric(
                vertical: AppSpacing.md,
                horizontal: AppSpacing.sm,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon with appropriate color contrast
                  Container(
                    padding: EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: isPrimary
                          ? AppColors.white.withValues(alpha: 0.2)
                          : AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(
                      icon,
                      size: 28,
                      color: isPrimary ? AppColors.white : AppColors.primary,
                    ),
                  ),

                  SizedBox(height: AppSpacing.sm),

                  // Label with icons - never icon-only for accessibility
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isPrimary
                          ? AppColors.white
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
