import '../../domain/entities/doctor.dart';

/// Data model for Doctor with JSON serialization
class DoctorModel extends Doctor {
  const DoctorModel({
    required super.id,
    required super.name,
    required super.specialization,
    required super.experienceYears,
    required super.consultationFee,
    required super.rating,
    required super.profileImage,
    required super.bio,
    required super.qualifications,
    required super.availableSlots,
  });

  /// Convert Doctor entity to DoctorModel
  factory DoctorModel.fromEntity(Doctor doctor) {
    return DoctorModel(
      id: doctor.id,
      name: doctor.name,
      specialization: doctor.specialization,
      experienceYears: doctor.experienceYears,
      consultationFee: doctor.consultationFee,
      rating: doctor.rating,
      profileImage: doctor.profileImage,
      bio: doctor.bio,
      qualifications: doctor.qualifications,
      availableSlots: doctor.availableSlots,
    );
  }

  /// Convert from JSON
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      experienceYears: json['experienceYears'] as int,
      consultationFee: (json['consultationFee'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      profileImage: json['profileImage'] as String,
      bio: json['bio'] as String,
      qualifications: List<String>.from(json['qualifications'] as List),
      availableSlots: (json['availableSlots'] as List)
          .map((slot) => TimeSlotModel.fromJson(slot as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'experienceYears': experienceYears,
      'consultationFee': consultationFee,
      'rating': rating,
      'profileImage': profileImage,
      'bio': bio,
      'qualifications': qualifications,
      'availableSlots': availableSlots
          .map((slot) => TimeSlotModel.fromEntity(slot).toJson())
          .toList(),
    };
  }
}

/// Data model for TimeSlot with JSON serialization
class TimeSlotModel extends TimeSlot {
  const TimeSlotModel({
    required super.day,
    required super.startTime,
    required super.endTime,
    super.isAvailable,
  });

  /// Convert TimeSlot entity to TimeSlotModel
  factory TimeSlotModel.fromEntity(TimeSlot slot) {
    return TimeSlotModel(
      day: slot.day,
      startTime: slot.startTime,
      endTime: slot.endTime,
      isAvailable: slot.isAvailable,
    );
  }

  /// Convert from JSON
  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      day: json['day'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'isAvailable': isAvailable,
    };
  }
}
