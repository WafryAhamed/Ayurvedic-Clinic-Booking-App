import 'doctor.dart';

/// Booking entity representing an appointment
class Booking {
  final String id;
  final Doctor doctor;
  final String patientName;
  final String patientPhone;
  final int? patientAge;
  final String? medicalNotes;
  final DateTime selectedDate;
  final String selectedTimeSlot;
  final BookingStatus status;
  final DateTime createdAt;

  const Booking({
    required this.id,
    required this.doctor,
    required this.patientName,
    required this.patientPhone,
    this.patientAge,
    this.medicalNotes,
    required this.selectedDate,
    required this.selectedTimeSlot,
    required this.status,
    required this.createdAt,
  });

  /// Create a copy with modified fields
  Booking copyWith({
    String? id,
    Doctor? doctor,
    String? patientName,
    String? patientPhone,
    int? patientAge,
    String? medicalNotes,
    DateTime? selectedDate,
    String? selectedTimeSlot,
    BookingStatus? status,
    DateTime? createdAt,
  }) {
    return Booking(
      id: id ?? this.id,
      doctor: doctor ?? this.doctor,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
      patientAge: patientAge ?? this.patientAge,
      medicalNotes: medicalNotes ?? this.medicalNotes,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// Status of a booking
enum BookingStatus { pending, confirmed, cancelled, completed }
