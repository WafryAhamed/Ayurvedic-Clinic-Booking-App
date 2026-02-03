import '../../domain/entities/appointment.dart';
import '../models/doctor_model.dart';

/// Data model for Appointment with conversion utilities
/// This layer sits between data source and domain
class AppointmentModel {
  final String id;
  final DoctorModel doctor;
  final String patientName;
  final String patientPhone;
  final int? patientAge;
  final String? medicalNotes;
  final DateTime appointmentDate;
  final String timeSlot;
  final String status; // String for JSON compatibility
  final DateTime createdAt;

  AppointmentModel({
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

  /// Convert from domain entity to data model
  factory AppointmentModel.fromEntity(Appointment appointment) {
    return AppointmentModel(
      id: appointment.id,
      doctor: DoctorModel.fromEntity(appointment.doctor),
      patientName: appointment.patientName,
      patientPhone: appointment.patientPhone,
      patientAge: appointment.patientAge,
      medicalNotes: appointment.medicalNotes,
      appointmentDate: appointment.appointmentDate,
      timeSlot: appointment.timeSlot,
      status: appointment.status == AppointmentStatus.confirmed
          ? 'confirmed'
          : 'cancelled',
      createdAt: appointment.createdAt,
    );
  }

  /// Convert data model to domain entity
  Appointment toEntity() {
    return Appointment(
      id: id,
      doctor: doctor, // DoctorModel extends Doctor, so this is valid
      patientName: patientName,
      patientPhone: patientPhone,
      patientAge: patientAge,
      medicalNotes: medicalNotes,
      appointmentDate: appointmentDate,
      timeSlot: timeSlot,
      status: status == 'confirmed'
          ? AppointmentStatus.confirmed
          : AppointmentStatus.cancelled,
      createdAt: createdAt,
    );
  }

  /// Convert to JSON (for future API integration)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor': doctor.toJson(),
      'patientName': patientName,
      'patientPhone': patientPhone,
      'patientAge': patientAge,
      'medicalNotes': medicalNotes,
      'appointmentDate': appointmentDate.toIso8601String(),
      'timeSlot': timeSlot,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Convert from JSON (for future API integration)
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] as String,
      doctor: DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
      patientName: json['patientName'] as String,
      patientPhone: json['patientPhone'] as String,
      patientAge: json['patientAge'] as int?,
      medicalNotes: json['medicalNotes'] as String?,
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      timeSlot: json['timeSlot'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
