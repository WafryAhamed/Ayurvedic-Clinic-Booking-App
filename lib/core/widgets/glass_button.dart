import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Glassmorphism-style button for premium Ayurvedic UI.
///
/// Features:
/// - Semi-transparent background using Light Green Tint (#DAF1DE)
/// - Blur effect using BackdropFilter
/// - Border with Soft Green (#8EB69B) at low opacity
/// - Rounded corners (min 16px)
/// - Soft shadow (no harsh elevation)
///
/// Usage:
/// ```dart
/// GlassButton(
///   onPressed: () => doSomething(),
///   child: Text('Book Appointment'),
/// )
/// ```
class GlassButton extends StatelessWidget {
  /// The callback when button is pressed
  final VoidCallback? onPressed;

  /// The child widget (typically Text or Row with Icon)
  final Widget child;

  /// Optional icon to display before the child
  final IconData? icon;

  /// Button width - defaults to full width
  final double? width;

  /// Button height - defaults to 56
  final double height;

  /// Border radius - defaults to 16
  final double borderRadius;

  /// Whether to show loading state
  final bool isLoading;

  const GlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.width,
    this.height = 56,
    this.borderRadius = 16,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          // Blur effect for glassmorphism
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isDisabled ? null : onPressed,
              borderRadius: BorderRadius.circular(borderRadius),
              splashColor: AppColors.primary.withValues(alpha: 0.2),
              highlightColor: AppColors.primary.withValues(alpha: 0.1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  // Semi-transparent light green background
                  color: isDisabled
                      ? AppColors.lightGreenTint.withValues(alpha: 0.5)
                      : AppColors.lightGreenTint.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(borderRadius),
                  // Soft border with low opacity
                  border: Border.all(
                    color: isDisabled
                        ? AppColors.softGreen.withValues(alpha: 0.2)
                        : AppColors.softGreen.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                  // Soft shadow - no harsh elevation
                  boxShadow: isDisabled
                      ? null
                      : [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  child: Center(
                    child: isLoading
                        ? _buildLoadingIndicator()
                        : _buildContent(context, isDisabled),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the button content with optional icon
  Widget _buildContent(BuildContext context, bool isDisabled) {
    final textColor = isDisabled ? AppColors.textSecondary : AppColors.primary;

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: textColor),
          SizedBox(width: AppSpacing.sm),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
            child: child,
          ),
        ],
      );
    }

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      child: child,
    );
  }

  /// Builds loading indicator
  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    );
  }
}

/// Compact glass button variant for smaller actions
class GlassButtonCompact extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final IconData? icon;

  const GlassButtonCompact({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      onPressed: onPressed,
      height: 44,
      borderRadius: 12,
      icon: icon,
      child: child,
    );
  }
}

/// Glass icon button for icon-only actions
class GlassIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final String? tooltip;

  const GlassIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 48,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;

    Widget button = ClipRRect(
      borderRadius: BorderRadius.circular(size / 3),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(size / 3),
            splashColor: AppColors.primary.withValues(alpha: 0.2),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: AppColors.lightGreenTint.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(size / 3),
                border: Border.all(
                  color: AppColors.softGreen.withValues(alpha: 0.4),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: size * 0.5,
                color: isDisabled ? AppColors.textSecondary : AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}
