import '../../domain/entities/doctor.dart';
import '../../domain/repositories/doctor_repository.dart';
import '../mock/mock_doctors.dart';

/// Mock implementation of DoctorRepository with simulated network delays
class MockDoctorRepository implements DoctorRepository {
  // Simulated network delay range
  static const int _minDelayMs = 500;
  static const int _maxDelayMs = 1000;

  /// Simulate network delay
  Future<void> _simulateDelay() async {
    final delay =
        _minDelayMs +
        ((_maxDelayMs - _minDelayMs) * 0.5).round(); // Average delay
    await Future.delayed(Duration(milliseconds: delay));
  }

  @override
  Future<List<Doctor>> getAllDoctors() async {
    // Simulate API call delay
    await _simulateDelay();
    return MockDoctors.getAllDoctors();
  }

  @override
  Future<Doctor?> getDoctorById(String id) async {
    // Simulate API call delay
    await _simulateDelay();
    return MockDoctors.getDoctorById(id);
  }

  @override
  Future<List<Doctor>> searchDoctors(String query) async {
    // Simulate API call delay
    await _simulateDelay();

    if (query.isEmpty) {
      return MockDoctors.getAllDoctors();
    }

    final lowerQuery = query.toLowerCase();
    return MockDoctors.getAllDoctors().where((doctor) {
      return doctor.name.toLowerCase().contains(lowerQuery) ||
          doctor.specialization.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<List<Doctor>> filterDoctors({
    List<String>? specializations,
    int? minExperience,
    int? maxExperience,
    double? minFee,
    double? maxFee,
    double? minRating,
  }) async {
    // Simulate API call delay
    await _simulateDelay();

    List<Doctor> filtered = MockDoctors.getAllDoctors();

    // Filter by specializations
    if (specializations != null && specializations.isNotEmpty) {
      filtered = filtered.where((doctor) {
        return specializations.contains(doctor.specialization);
      }).toList();
    }

    // Filter by experience range
    if (minExperience != null) {
      filtered = filtered.where((doctor) {
        return doctor.experienceYears >= minExperience;
      }).toList();
    }

    if (maxExperience != null) {
      filtered = filtered.where((doctor) {
        return doctor.experienceYears <= maxExperience;
      }).toList();
    }

    // Filter by fee range
    if (minFee != null) {
      filtered = filtered.where((doctor) {
        return doctor.consultationFee >= minFee;
      }).toList();
    }

    if (maxFee != null) {
      filtered = filtered.where((doctor) {
        return doctor.consultationFee <= maxFee;
      }).toList();
    }

    // Filter by minimum rating
    if (minRating != null) {
      filtered = filtered.where((doctor) {
        return doctor.rating >= minRating;
      }).toList();
    }

    return filtered;
  }

  @override
  List<Doctor> sortDoctors(
    List<Doctor> doctors, {
    required DoctorSortBy sortBy,
    bool ascending = true,
  }) {
    final sorted = List<Doctor>.from(doctors);

    switch (sortBy) {
      case DoctorSortBy.name:
        sorted.sort(
          (a, b) =>
              ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name),
        );
        break;

      case DoctorSortBy.experience:
        sorted.sort(
          (a, b) => ascending
              ? a.experienceYears.compareTo(b.experienceYears)
              : b.experienceYears.compareTo(a.experienceYears),
        );
        break;

      case DoctorSortBy.fee:
        sorted.sort(
          (a, b) => ascending
              ? a.consultationFee.compareTo(b.consultationFee)
              : b.consultationFee.compareTo(a.consultationFee),
        );
        break;

      case DoctorSortBy.rating:
        sorted.sort(
          (a, b) => ascending
              ? a.rating.compareTo(b.rating)
              : b.rating.compareTo(a.rating),
        );
        break;
    }

    return sorted;
  }

  /// Get all unique specializations
  Future<List<String>> getAllSpecializations() async {
    await _simulateDelay();
    final doctors = MockDoctors.getAllDoctors();
    return doctors.map((d) => d.specialization).toSet().toList()..sort();
  }
}
