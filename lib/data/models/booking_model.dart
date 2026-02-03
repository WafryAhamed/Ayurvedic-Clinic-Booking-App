import '../../domain/entities/booking.dart';
import 'doctor_model.dart';

/// Data model for Booking with JSON serialization
class BookingModel extends Booking {
  const BookingModel({
    required super.id,
    required super.doctor,
    required super.patientName,
    required super.patientPhone,
    super.patientAge,
    super.medicalNotes,
    required super.selectedDate,
    required super.selectedTimeSlot,
    required super.status,
    required super.createdAt,
  });

  /// Convert Booking entity to BookingModel
  factory BookingModel.fromEntity(Booking booking) {
    return BookingModel(
      id: booking.id,
      doctor: booking.doctor,
      patientName: booking.patientName,
      patientPhone: booking.patientPhone,
      patientAge: booking.patientAge,
      medicalNotes: booking.medicalNotes,
      selectedDate: booking.selectedDate,
      selectedTimeSlot: booking.selectedTimeSlot,
      status: booking.status,
      createdAt: booking.createdAt,
    );
  }

  /// Convert from JSON
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      doctor: DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
      patientName: json['patientName'] as String,
      patientPhone: json['patientPhone'] as String,
      patientAge: json['patientAge'] as int?,
      medicalNotes: json['medicalNotes'] as String?,
      selectedDate: DateTime.parse(json['selectedDate'] as String),
      selectedTimeSlot: json['selectedTimeSlot'] as String,
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == 'BookingStatus.${json['status']}',
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor': DoctorModel.fromEntity(doctor).toJson(),
      'patientName': patientName,
      'patientPhone': patientPhone,
      'patientAge': patientAge,
      'medicalNotes': medicalNotes,
      'selectedDate': selectedDate.toIso8601String(),
      'selectedTimeSlot': selectedTimeSlot,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
