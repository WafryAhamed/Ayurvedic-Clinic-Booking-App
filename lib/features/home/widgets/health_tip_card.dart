import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Simple card displaying Ayurvedic wellness tips.
///
/// UX Decision: Health tips add value without being instructional or diagnostic.
/// Uses calm icons and short, actionable advice to encourage healthy habits.
/// Non-medical nature avoids liability concerns while building trust.
class HealthTipCard extends StatelessWidget {
  final String emoji;
  final String tip;

  const HealthTipCard({super.key, required this.emoji, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Emoji icon - calm and friendly visual
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 20)),
            ),
          ),

          SizedBox(width: AppSpacing.md),

          // Tip text - short and informative
          Expanded(
            child: Text(
              tip,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Static health tips data for the dashboard.
///
/// These are simple lifestyle suggestions that align with Ayurvedic principles.
/// They are intentionally non-medical and non-diagnostic.
class HealthTipsData {
  static const List<Map<String, String>> tips = [
    {
      'emoji': '🌿',
      'tip':
          'Start your day with warm water for better digestion and metabolism.',
    },
    {
      'emoji': '🧘',
      'tip': 'Practice 10 minutes of deep breathing daily to reduce stress.',
    },
    {
      'emoji': '🌙',
      'tip': 'Aim for 7-8 hours of restful sleep for optimal wellness.',
    },
  ];
}
