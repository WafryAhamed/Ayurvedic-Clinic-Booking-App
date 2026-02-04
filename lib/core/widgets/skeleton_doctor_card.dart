import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Skeleton loader for Doctor Card
/// Displays a shimmering placeholder while content loads
class SkeletonDoctorCard extends StatefulWidget {
  const SkeletonDoctorCard({super.key});

  @override
  State<SkeletonDoctorCard> createState() => _SkeletonDoctorCardState();
}

class _SkeletonDoctorCardState extends State<SkeletonDoctorCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: AppColors.surface,
      end: AppColors.textSecondary.withValues(alpha: 0.1),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
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
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Profile image skeleton
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name skeleton
                          Container(
                            width: 120,
                            height: 16,
                            decoration: BoxDecoration(
                              color: _colorAnimation.value,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                          ),
                          SizedBox(height: AppSpacing.xs),
                          // Specialization skeleton
                          Container(
                            width: 80,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _colorAnimation.value,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Stats skeleton
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                      ),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Container(
                      width: 30,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.sm),
                // Footer skeleton
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 60,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
