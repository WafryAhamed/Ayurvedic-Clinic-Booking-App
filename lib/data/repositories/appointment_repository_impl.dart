import 'dart:math';
import '../../domain/entities/appointment.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../mock/mock_appointments.dart';

/// Mock implementation of AppointmentRepository
/// Simulates API calls with Future.delayed for realistic loading states
/// NO backend integration - all data is in-memory only
class AppointmentRepositoryImpl implements AppointmentRepository {
  // Random number generator for simulating occasional errors
  final _random = Random();

  @override
  Future<List<Appointment>> getAppointments() async {
    // Simulate network delay (1-2 seconds)
    await Future.delayed(const Duration(milliseconds: 1500));

    // Simulate occasional errors (10% chance)
    if (_random.nextInt(10) == 0) {
      throw Exception('Failed to load appointments. Please try again.');
    }

    // Return mock data
    return MockAppointments.getAllAppointments();
  }

  @override
  Future<Appointment?> getAppointmentById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Simulate occasional errors (5% chance)
    if (_random.nextInt(20) == 0) {
      throw Exception('Failed to load appointment details. Please try again.');
    }

    // Return mock data
    return MockAppointments.getAppointmentById(id);
  }

  @override
  Future<Appointment?> cancelAppointment(String id) async {
    // Simulate network delay for cancellation operation
    await Future.delayed(const Duration(milliseconds: 1200));

    // Simulate occasional errors (8% chance)
    if (_random.nextInt(12) == 0) {
      throw Exception('Failed to cancel appointment. Please try again.');
    }

    // Cancel the appointment in mock data
    return MockAppointments.cancelAppointment(id);
  }
}
