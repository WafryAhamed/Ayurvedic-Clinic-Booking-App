import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/config/api_constants.dart';
import '../../domain/entities/appointment.dart';
import '../../data/models/appointment_model.dart';
import '../../domain/repositories/appointment_repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  // Hardcoded demo user phone number to fetch "My Appointments"
  final String _demoUserPhone = "0771234567";

  @override
  Future<List<Appointment>> getAppointments() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/appointments?phone=$_demoUserPhone'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map<Appointment>(
              (json) => AppointmentModel.fromJson(json).toEntity(),
            )
            .toList();
      } else {
        throw Exception('Failed to load appointments: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching appointments: $e');
      throw Exception('Failed to load appointments');
    }
  }

  @override
  Future<Appointment?> getAppointmentById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/appointments/$id'),
      );

      if (response.statusCode == 200) {
        return AppointmentModel.fromJson(json.decode(response.body)).toEntity();
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching appointment details: $e');
      throw Exception('Failed to load appointment details');
    }
  }

  @override
  Future<Appointment?> cancelAppointment(String id) async {
    try {
      final response = await http.patch(
        Uri.parse('${ApiConstants.baseUrl}/appointments/$id/cancel'),
      );

      if (response.statusCode == 200) {
        return AppointmentModel.fromJson(json.decode(response.body)).toEntity();
      } else {
        throw Exception('Failed to cancel appointment: ${response.statusCode}');
      }
    } catch (e) {
      print('Error cancelling appointment: $e');
      throw Exception('Failed to cancel appointment');
    }
  }
}
