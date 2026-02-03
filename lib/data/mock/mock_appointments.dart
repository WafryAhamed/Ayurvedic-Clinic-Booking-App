import '../../domain/entities/appointment.dart';
import 'mock_doctors.dart';

/// Mock appointment data for demonstration purposes
/// All appointments use demo data with no backend integration
class MockAppointments {
  // In-memory storage for appointments (simulates database)
  static final List<Appointment> _appointments = [
    // Upcoming Confirmed Appointments
    Appointment(
      id: 'APT001',
      doctor: MockDoctors.getDoctorById('doc_001')!,
      patientName: 'Kasun Wickramasinghe',
      patientPhone: '+94 77 123 4567',
      patientAge: 35,
      medicalNotes: 'Experiencing digestive issues and fatigue',
      appointmentDate: DateTime.now().add(const Duration(days: 3)),
      timeSlot: '09:00 AM - 10:00 AM',
      status: AppointmentStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Appointment(
      id: 'APT002',
      doctor: MockDoctors.getDoctorById('doc_002')!,
      patientName: 'Kasun Wickramasinghe',
      patientPhone: '+94 77 123 4567',
      patientAge: 35,
      medicalNotes: 'Consultation for stress management and wellness',
      appointmentDate: DateTime.now().add(const Duration(days: 7)),
      timeSlot: '03:00 PM - 04:00 PM',
      status: AppointmentStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Appointment(
      id: 'APT003',
      doctor: MockDoctors.getDoctorById('doc_005')!,
      patientName: 'Kasun Wickramasinghe',
      patientPhone: '+94 77 123 4567',
      patientAge: 35,
      medicalNotes: 'Lower back pain treatment',
      appointmentDate: DateTime.now().add(const Duration(days: 10)),
      timeSlot: '10:00 AM - 11:00 AM',
      status: AppointmentStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),

    // Past Cancelled Appointment
    Appointment(
      id: 'APT004',
      doctor: MockDoctors.getDoctorById('doc_003')!,
      patientName: 'Kasun Wickramasinghe',
      patientPhone: '+94 77 123 4567',
      patientAge: 35,
      medicalNotes: null,
      appointmentDate: DateTime.now().subtract(const Duration(days: 5)),
      timeSlot: '02:00 PM - 03:00 PM',
      status: AppointmentStatus.cancelled,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),

    // Past Confirmed Appointment
    Appointment(
      id: 'APT005',
      doctor: MockDoctors.getDoctorById('doc_006')!,
      patientName: 'Kasun Wickramasinghe',
      patientPhone: '+94 77 123 4567',
      patientAge: 35,
      medicalNotes: 'Skin consultation for acne treatment',
      appointmentDate: DateTime.now().subtract(const Duration(days: 15)),
      timeSlot: '10:00 AM - 11:00 AM',
      status: AppointmentStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
  ];

  /// Get all appointments (simulates API call)
  static List<Appointment> getAllAppointments() {
    return List.unmodifiable(_appointments);
  }

  /// Get appointment by ID (simulates API call)
  static Appointment? getAppointmentById(String id) {
    try {
      return _appointments.firstWhere((appointment) => appointment.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Cancel an appointment by ID (simulates API call)
  /// Returns updated appointment or null if not found
  static Appointment? cancelAppointment(String id) {
    final index = _appointments.indexWhere((apt) => apt.id == id);
    if (index == -1) return null;

    // Update the appointment status to cancelled
    final updatedAppointment = _appointments[index].copyWith(
      status: AppointmentStatus.cancelled,
    );

    // Replace in the list
    _appointments[index] = updatedAppointment;

    return updatedAppointment;
  }
}
