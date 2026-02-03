import '../entities/booking.dart';

/// Repository interface for booking operations
abstract class BookingRepository {
  /// Create a new booking
  Future<Booking> createBooking(Booking booking);

  /// Get booking by ID
  Future<Booking?> getBookingById(String id);

  /// Get all bookings (for future use)
  Future<List<Booking>> getAllBookings();

  /// Cancel a booking (for future use)
  Future<bool> cancelBooking(String id);
}
