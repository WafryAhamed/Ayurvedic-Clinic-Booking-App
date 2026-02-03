import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/time_slot_chip.dart';
import '../providers/booking_provider.dart';

/// Date and time selection screen for booking
class DateTimeSelectionScreen extends StatefulWidget {
  const DateTimeSelectionScreen({super.key});

  @override
  State<DateTimeSelectionScreen> createState() =>
      _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  DateTime? _selectedDate;
  String? _selectedTimeSlot;

  // Generate time slots for a day
  final List<String> _timeSlots = [
    '08:00 AM - 09:00 AM',
    '09:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '12:00 PM - 01:00 PM',
    '02:00 PM - 03:00 PM',
    '03:00 PM - 04:00 PM',
    '04:00 PM - 05:00 PM',
    '05:00 PM - 06:00 PM',
    '06:00 PM - 07:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    // Pre-fill with existing data if any
    final provider = context.read<BookingProvider>();
    _selectedDate = provider.selectedDate;
    _selectedTimeSlot = provider.selectedTimeSlot;
  }

  void _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = now;
    final DateTime lastDate = now.add(const Duration(days: 90));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // Reset time slot when date changes
        _selectedTimeSlot = null;
      });
    }
  }

  void _continue() {
    if (_selectedDate != null && _selectedTimeSlot != null) {
      // Save to provider
      final provider = context.read<BookingProvider>();
      provider.setSelectedDate(_selectedDate!);
      provider.setSelectedTimeSlot(_selectedTimeSlot!);

      // Navigate to review screen
      Navigator.of(context).pushNamed('/booking-review');
    } else {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select both date and time slot'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();
    final doctor = provider.selectedDoctor;

    return Scaffold(
      appBar: AppBar(title: const Text('Select Date & Time')),
      body: doctor == null
          ? const Center(child: Text('No doctor selected'))
          : ListView(
              padding: EdgeInsets.all(AppSpacing.md),
              children: [
                // Doctor info card
                Card(
                  color: AppColors.surface,
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: Center(
                            child: Text(
                              doctor.profileImage,
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                doctor.specialization,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppSpacing.lg),

                // Select Date Section
                Text(
                  'Select Date',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),

                SizedBox(height: AppSpacing.sm),

                // Date Selection Card
                Card(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, color: AppColors.primary),
                          SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedDate == null
                                      ? 'Choose a date'
                                      : DateFormat(
                                          'EEEE, MMMM d, y',
                                        ).format(_selectedDate!),
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                if (_selectedDate != null)
                                  Text(
                                    DateFormat(
                                      'd MMMM y',
                                    ).format(_selectedDate!),
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                  ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: AppSpacing.lg),

                // Select Time Section
                Text(
                  'Select Time Slot',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),

                SizedBox(height: AppSpacing.sm),

                // Info message if no date selected
                if (_selectedDate == null)
                  Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: AppColors.warning.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.warning),
                        SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'Please select a date first to view available time slots',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.warning),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Time slots grid
                if (_selectedDate != null)
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: _timeSlots.map((slot) {
                      final isSelected = _selectedTimeSlot == slot;
                      return TimeSlotChip(
                        timeSlot: slot,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _selectedTimeSlot = slot;
                          });
                        },
                      );
                    }).toList(),
                  ),

                SizedBox(height: AppSpacing.xxl),
              ],
            ),

      // Continue Button
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: PrimaryButton(
          text: 'Continue',
          onPressed: _continue,
          isDisabled: _selectedDate == null || _selectedTimeSlot == null,
          icon: Icons.arrow_forward,
        ),
      ),
    );
  }
}
