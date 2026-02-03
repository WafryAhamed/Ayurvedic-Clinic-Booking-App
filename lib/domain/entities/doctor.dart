/// Doctor entity representing an Ayurvedic practitioner
class Doctor {
  final String id;
  final String name;
  final String specialization;
  final int experienceYears;
  final double consultationFee;
  final double rating;
  final String profileImage;
  final String bio;
  final List<String> qualifications;
  final List<TimeSlot> availableSlots;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experienceYears,
    required this.consultationFee,
    required this.rating,
    required this.profileImage,
    required this.bio,
    required this.qualifications,
    required this.availableSlots,
  });
}

/// Time slot for doctor availability
class TimeSlot {
  final String day;
  final String startTime;
  final String endTime;
  final bool isAvailable;

  const TimeSlot({
    required this.day,
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
  });
}
