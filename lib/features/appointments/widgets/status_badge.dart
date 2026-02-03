import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/appointment.dart';

/// Status badge widget to display appointment status
/// Green for confirmed, Red for cancelled
class StatusBadge extends StatelessWidget {
  final AppointmentStatus status;
  final double? fontSize;

  const StatusBadge({super.key, required this.status, this.fontSize});

  @override
  Widget build(BuildContext context) {
    // Determine color and text based on status
    final isConfirmed = status == AppointmentStatus.confirmed;
    final backgroundColor = isConfirmed ? AppColors.success : AppColors.error;
    final text = isConfirmed ? 'Confirmed' : 'Cancelled';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: backgroundColor, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: backgroundColor,
          fontSize: fontSize ?? 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
