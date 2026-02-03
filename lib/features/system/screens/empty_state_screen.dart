import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Generic empty state screen
/// Displayed when lists or data collections are empty
class EmptyStateScreen extends StatelessWidget {
  final String? title;
  final String? message;
  final IconData? icon;
  final String? actionText;
  final VoidCallback? onAction;

  const EmptyStateScreen({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Empty')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Empty icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon ?? Icons.inbox_rounded,
                  size: 60,
                  color: AppColors.secondary,
                ),
              ),

              SizedBox(height: AppSpacing.xl),

              // Title
              Text(
                title ?? 'Nothing Here Yet',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppSpacing.md),

              // Message
              Text(
                message ?? 'There\'s nothing to show at the moment.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),

              if (onAction != null && actionText != null) ...[
                SizedBox(height: AppSpacing.xl),

                // Action button
                ElevatedButton(
                  onPressed: onAction,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                  ),
                  child: Text(actionText!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
