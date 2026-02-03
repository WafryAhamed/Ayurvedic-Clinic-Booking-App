import 'package:flutter/material.dart';
import '../../../domain/entities/booking.dart';
import '../../../domain/entities/doctor.dart';
import '../../../domain/repositories/booking_repository.dart';
import '../../../data/repositories/mock_booking_repository.dart';

/// Booking provider state enum
enum BookingState { initial, loading, success, error }

/// Provider for managing booking flow and validation
class BookingProvider extends ChangeNotifier {
  final BookingRepository _repository = MockBookingRepository();

  // State
  BookingState _state = BookingState.initial;
  String? _errorMessage;

  // Booking data
  Doctor? _selectedDoctor;
  String _patientName = '';
  String _patientPhone = '';
  int? _patientAge;
  String _medicalNotes = '';
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  Booking? _confirmedBooking;

  // Getters
  BookingState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == BookingState.loading;

  Doctor? get selectedDoctor => _selectedDoctor;
  String get patientName => _patientName;
  String get patientPhone => _patientPhone;
  int? get patientAge => _patientAge;
  String get medicalNotes => _medicalNotes;
  DateTime? get selectedDate => _selectedDate;
  String? get selectedTimeSlot => _selectedTimeSlot;
  Booking? get confirmedBooking => _confirmedBooking;

  // Validation getters
  bool get isPatientInfoValid {
    return _patientName.trim().isNotEmpty &&
        _patientPhone.trim().isNotEmpty &&
        _isValidPhoneNumber(_patientPhone);
  }

  bool get isDateTimeValid {
    return _selectedDate != null && _selectedTimeSlot != null;
  }

  bool get canConfirmBooking {
    return _selectedDoctor != null && isPatientInfoValid && isDateTimeValid;
  }

  /// Validate phone number (basic Sri Lankan format)
  bool _isValidPhoneNumber(String phone) {
    // Remove spaces and dashes
    final cleanedPhone = phone.replaceAll(RegExp(r'[\s-]'), '');
    // Check if it's 10 digits and starts with 0
    return RegExp(r'^0\d{9}$').hasMatch(cleanedPhone);
  }

  /// Set selected doctor
  void setDoctor(Doctor doctor) {
    _selectedDoctor = doctor;
    notifyListeners();
  }

  /// Set patient name
  void setPatientName(String name) {
    _patientName = name;
    notifyListeners();
  }

  /// Set patient phone
  void setPatientPhone(String phone) {
    _patientPhone = phone;
    notifyListeners();
  }

  /// Set patient age
  void setPatientAge(int? age) {
    _patientAge = age;
    notifyListeners();
  }

  /// Set medical notes
  void setMedicalNotes(String notes) {
    _medicalNotes = notes;
    notifyListeners();
  }

  /// Set selected date
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  /// Set selected time slot
  void setSelectedTimeSlot(String timeSlot) {
    _selectedTimeSlot = timeSlot;
    notifyListeners();
  }

  /// Create booking
  Future<bool> confirmBooking() async {
    if (!canConfirmBooking) {
      _errorMessage = 'Please fill all required fields';
      return false;
    }

    _setState(BookingState.loading);
    _errorMessage = null;

    try {
      // Generate a unique booking ID
      final bookingId = 'BK${DateTime.now().millisecondsSinceEpoch}';

      // Create booking object
      final booking = Booking(
        id: bookingId,
        doctor: _selectedDoctor!,
        patientName: _patientName,
        patientPhone: _patientPhone,
        patientAge: _patientAge,
        medicalNotes: _medicalNotes.isEmpty ? null : _medicalNotes,
        selectedDate: _selectedDate!,
        selectedTimeSlot: _selectedTimeSlot!,
        status: BookingStatus.confirmed,
        createdAt: DateTime.now(),
      );

      // Submit booking
      _confirmedBooking = await _repository.createBooking(booking);

      _setState(BookingState.success);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to confirm booking. Please try again.';
      _setState(BookingState.error);
      return false;
    }
  }

  /// Reset booking data
  void reset() {
    _state = BookingState.initial;
    _errorMessage = null;
    _selectedDoctor = null;
    _patientName = '';
    _patientPhone = '';
    _patientAge = null;
    _medicalNotes = '';
    _selectedDate = null;
    _selectedTimeSlot = null;
    _confirmedBooking = null;
    notifyListeners();
  }

  /// Reset only the booking confirmation (keep doctor selected)
  void resetBookingOnly() {
    _state = BookingState.initial;
    _errorMessage = null;
    _patientName = '';
    _patientPhone = '';
    _patientAge = null;
    _medicalNotes = '';
    _selectedDate = null;
    _selectedTimeSlot = null;
    _confirmedBooking = null;
    notifyListeners();
  }

  /// Set state and notify listeners
  void _setState(BookingState newState) {
    _state = newState;
    notifyListeners();
  }
}
