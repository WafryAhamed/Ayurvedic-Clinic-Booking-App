import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/config/api_constants.dart';
import '../../domain/entities/booking.dart';
import '../../data/models/booking_model.dart';
import '../../domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  @override
  Future<Booking> createBooking(Booking booking) async {
    try {
      final requestBody = {
        'doctorId': booking.doctor.id,
        'patientName': booking.patientName,
        'patientPhone': booking.patientPhone,
        'patientAge': booking.patientAge,
        'medicalNotes': booking.medicalNotes,
        'appointmentDate': booking.selectedDate.toIso8601String().split('T')[0],
        'timeSlot': booking.selectedTimeSlot,
      };

      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/appointments'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        return BookingModel.fromJson(responseData);
      } else {
        throw Exception(
          'Failed to create booking: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error creating booking: $e');
      throw Exception('Failed to create booking');
    }
  }

  @override
  Future<List<Booking>> getAllBookings() async {
    // Not used in current flow
    return [];
  }

  @override
  Future<Booking?> getBookingById(String id) async {
    // Not used in current flow
    return null;
  }

  @override
  Future<bool> cancelBooking(String id) async {
    // Not used in current flow
    return false;
  }
}
