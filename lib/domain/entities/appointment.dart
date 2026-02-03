import 'doctor.dart';

/// Appointment entity representing a patient's scheduled appointment
class Appointment {
  final String id; // Unique booking ID
  final Doctor doctor; // Doctor reference
  final String patientName;
  final String patientPhone;
  final int? patientAge;
  final String? medicalNotes;
  final DateTime appointmentDate;
  final String timeSlot; // e.g., "10:00 AM - 11:00 AM"
  final AppointmentStatus status;
  final DateTime createdAt;

  const Appointment({
    required this.id,
    required this.doctor,
    required this.patientName,
    required this.patientPhone,
    this.patientAge,
    this.medicalNotes,
    required this.appointmentDate,
    required this.timeSlot,
    required this.status,
    required this.createdAt,
  });

  /// Create a copy with modified fields
  Appointment copyWith({
    String? id,
    Doctor? doctor,
    String? patientName,
    String? patientPhone,
    int? patientAge,
    String? medicalNotes,
    DateTime? appointmentDate,
    String? timeSlot,
    AppointmentStatus? status,
    DateTime? createdAt,
  }) {
    return Appointment(
      id: id ?? this.id,
      doctor: doctor ?? this.doctor,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
      patientAge: patientAge ?? this.patientAge,
      medicalNotes: medicalNotes ?? this.medicalNotes,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      timeSlot: timeSlot ?? this.timeSlot,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// Status of an appointment
enum AppointmentStatus { confirmed, cancelled }
