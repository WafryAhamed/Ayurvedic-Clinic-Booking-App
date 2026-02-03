import 'package:flutter/foundation.dart';
import '../../../domain/entities/appointment.dart';
import '../../../data/repositories/appointment_repository_impl.dart';

/// Provider for managing appointment state
/// Handles loading, success, empty, and error states
class AppointmentProvider extends ChangeNotifier {
  // Repository instance (mock implementation)
  final _repository = AppointmentRepositoryImpl();

  // State variables
  List<Appointment> _appointments = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _isCancelling = false;

  // Getters
  List<Appointment> get appointments => _appointments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isCancelling => _isCancelling;
  bool get isEmpty =>
      !_isLoading && _appointments.isEmpty && _errorMessage == null;

  /// Fetch all appointments from repository
  Future<void> fetchAppointments() async {
    // Set loading state
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Fetch appointments from mock repository (with simulated delay)
      final appointments = await _repository.getAppointments();

      // Update state with fetched data
      _appointments = appointments;
      _errorMessage = null;
    } catch (e) {
      // Handle error state
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _appointments = [];
    } finally {
      // Clear loading state
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Cancel an appointment by ID
  Future<bool> cancelAppointment(String appointmentId) async {
    // Set cancelling state
    _isCancelling = true;
    notifyListeners();

    try {
      // Cancel appointment through repository (with simulated delay)
      final updatedAppointment = await _repository.cancelAppointment(
        appointmentId,
      );

      if (updatedAppointment != null) {
        // Update the appointment in the local list
        final index = _appointments.indexWhere(
          (apt) => apt.id == appointmentId,
        );
        if (index != -1) {
          _appointments[index] = updatedAppointment;
        }

        _isCancelling = false;
        notifyListeners();
        return true;
      } else {
        _isCancelling = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      // Handle error
      _isCancelling = false;
      notifyListeners();
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Get a specific appointment by ID from the local list
  Appointment? getAppointmentById(String id) {
    try {
      return _appointments.firstWhere((apt) => apt.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
