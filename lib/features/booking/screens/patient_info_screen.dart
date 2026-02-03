import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_input_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../providers/booking_provider.dart';

/// Patient information screen for booking
class PatientInfoScreen extends StatefulWidget {
  const PatientInfoScreen({super.key});

  @override
  State<PatientInfoScreen> createState() => _PatientInfoScreenState();
}

class _PatientInfoScreenState extends State<PatientInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill with existing data if any
    final provider = context.read<BookingProvider>();
    _nameController.text = provider.patientName;
    _phoneController.text = provider.patientPhone;
    _ageController.text = provider.patientAge?.toString() ?? '';
    _notesController.text = provider.medicalNotes;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter patient name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter phone number';
    }
    final cleanedPhone = value.replaceAll(RegExp(r'[\s-]'), '');
    if (!RegExp(r'^0\d{9}$').hasMatch(cleanedPhone)) {
      return 'Please enter a valid Sri Lankan phone number';
    }
    return null;
  }

  String? _validateAge(String? value) {
    if (value != null && value.isNotEmpty) {
      final age = int.tryParse(value);
      if (age == null || age < 1 || age > 120) {
        return 'Please enter a valid age';
      }
    }
    return null;
  }

  void _continue() {
    if (_formKey.currentState!.validate()) {
      // Save form data
      final provider = context.read<BookingProvider>();
      provider.setPatientName(_nameController.text.trim());
      provider.setPatientPhone(_phoneController.text.trim());
      provider.setPatientAge(
        _ageController.text.isEmpty ? null : int.parse(_ageController.text),
      );
      provider.setMedicalNotes(_notesController.text.trim());

      // Navigate to date/time selection
      Navigator.of(context).pushNamed('/date-time-selection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patient Information')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(AppSpacing.md),
          children: [
            // Info card
            Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.primary),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Please provide your information for the appointment',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.lg),

            // Patient Name (Required)
            CustomInputField(
              label: 'Patient Name *',
              hint: 'Enter full name',
              controller: _nameController,
              validator: _validateName,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.person_outline),
            ),

            SizedBox(height: AppSpacing.md),

            // Phone Number (Required)
            CustomInputField(
              label: 'Phone Number *',
              hint: '0771234567',
              controller: _phoneController,
              validator: _validatePhone,
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone_outlined),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),

            SizedBox(height: AppSpacing.md),

            // Age (Optional)
            CustomInputField(
              label: 'Age (Optional)',
              hint: 'Enter age',
              controller: _ageController,
              validator: _validateAge,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.cake_outlined),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
            ),

            SizedBox(height: AppSpacing.md),

            // Medical Notes (Optional)
            CustomInputField(
              label: 'Medical Notes (Optional)',
              hint: 'Any specific health concerns or conditions...',
              controller: _notesController,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              prefixIcon: const Icon(Icons.notes_outlined),
            ),

            SizedBox(height: AppSpacing.xs),

            // Helper text
            Text(
              '* Required fields',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),

            SizedBox(height: AppSpacing.xxl),
          ],
        ),
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
        child: Consumer<BookingProvider>(
          builder: (context, provider, child) {
            return PrimaryButton(
              text: 'Continue',
              onPressed: _continue,
              icon: Icons.arrow_forward,
            );
          },
        ),
      ),
    );
  }
}
