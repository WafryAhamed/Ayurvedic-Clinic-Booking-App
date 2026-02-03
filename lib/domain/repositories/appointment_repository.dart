import '../entities/appointment.dart';

/// Repository interface for appointment operations
/// This defines the contract for appointment data access
abstract class AppointmentRepository {
  /// Fetch all appointments for the current user
  Future<List<Appointment>> getAppointments();

  /// Fetch a single appointment by ID
  Future<Appointment?> getAppointmentById(String id);

  /// Cancel an appointment by ID
  /// Returns the updated appointment or null if not found
  Future<Appointment?> cancelAppointment(String id);
}
