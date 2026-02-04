import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/config/api_constants.dart';
import '../../domain/entities/doctor.dart';
import '../../data/models/doctor_model.dart';
import '../../domain/repositories/doctor_repository.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  @override
  Future<List<Doctor>> getAllDoctors() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/doctors'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map<Doctor>((json) => DoctorModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load doctors: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching doctors: $e');
      throw Exception('Failed to load doctors');
    }
  }

  @override
  Future<Doctor?> getDoctorById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/doctors/$id'),
      );

      if (response.statusCode == 200) {
        return DoctorModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching doctor details: $e');
      throw Exception('Failed to load doctor details');
    }
  }

  @override
  Future<List<Doctor>> searchDoctors(String query) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/doctors/search?query=$query'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map<Doctor>((json) => DoctorModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search doctors: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching doctors: $e');
      throw Exception('Failed to search doctors');
    }
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
    try {
      final queryParams = <String, String>{};
      if (specializations != null && specializations.isNotEmpty) {
        queryParams['specialization'] = specializations.join(',');
      }
      if (minExperience != null)
        queryParams['minExperience'] = minExperience.toString();
      if (maxExperience != null)
        queryParams['maxExperience'] = maxExperience.toString();
      if (minFee != null) queryParams['minFee'] = minFee.toString();
      if (maxFee != null) queryParams['maxFee'] = maxFee.toString();
      if (minRating != null) queryParams['minRating'] = minRating.toString();

      final uri = Uri.parse(
        '${ApiConstants.baseUrl}/doctors/filter',
      ).replace(queryParameters: queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map<Doctor>((json) => DoctorModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to filter doctors: ${response.statusCode}');
      }
    } catch (e) {
      print('Error filtering doctors: $e');
      throw Exception('Failed to filter doctors');
    }
  }

  @override
  List<Doctor> sortDoctors(
    List<Doctor> doctors, {
    required DoctorSortBy sortBy,
    bool ascending = true,
  }) {
    final sortedList = List<Doctor>.from(doctors);
    switch (sortBy) {
      case DoctorSortBy.experience:
        sortedList.sort(
          (a, b) => ascending
              ? a.experienceYears.compareTo(b.experienceYears)
              : b.experienceYears.compareTo(a.experienceYears),
        );
        break;
      case DoctorSortBy.fee:
        sortedList.sort(
          (a, b) => ascending
              ? a.consultationFee.compareTo(b.consultationFee)
              : b.consultationFee.compareTo(a.consultationFee),
        );
        break;
      case DoctorSortBy.rating:
        sortedList.sort(
          (a, b) => ascending
              ? a.rating.compareTo(b.rating)
              : b.rating.compareTo(a.rating),
        );
        break;
      case DoctorSortBy.name:
        sortedList.sort(
          (a, b) =>
              ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name),
        );
        break;
    }
    return sortedList;
  }
}
