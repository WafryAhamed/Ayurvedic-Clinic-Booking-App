import '../entities/doctor.dart';

/// Repository interface for doctor operations
abstract class DoctorRepository {
  /// Get all doctors
  Future<List<Doctor>> getAllDoctors();

  /// Get doctor by ID
  Future<Doctor?> getDoctorById(String id);

  /// Search doctors by name or specialization
  Future<List<Doctor>> searchDoctors(String query);

  /// Filter doctors by criteria
  Future<List<Doctor>> filterDoctors({
    List<String>? specializations,
    int? minExperience,
    int? maxExperience,
    double? minFee,
    double? maxFee,
    double? minRating,
  });

  /// Sort doctors
  List<Doctor> sortDoctors(
    List<Doctor> doctors, {
    required DoctorSortBy sortBy,
    bool ascending = true,
  });
}

/// Sort options for doctors
enum DoctorSortBy { name, experience, fee, rating }
