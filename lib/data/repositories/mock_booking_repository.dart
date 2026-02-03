import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';

/// Mock implementation of BookingRepository with simulated network delays
class MockBookingRepository implements BookingRepository {
  // In-memory storage for bookings
  final List<Booking> _bookings = [];

  // Simulated network delay
  static const int _delayMs = 800;

  /// Simulate network delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: _delayMs));
  }

  @override
  Future<Booking> createBooking(Booking booking) async {
    // Simulate API call delay
    await _simulateDelay();

    // Store the booking
    _bookings.add(booking);

    return booking;
  }

  @override
  Future<Booking?> getBookingById(String id) async {
    // Simulate API call delay
    await _simulateDelay();

    try {
      return _bookings.firstWhere((booking) => booking.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Booking>> getAllBookings() async {
    // Simulate API call delay
    await _simulateDelay();

    return List.unmodifiable(_bookings);
  }

  @override
  Future<bool> cancelBooking(String id) async {
    // Simulate API call delay
    await _simulateDelay();

    final index = _bookings.indexWhere((booking) => booking.id == id);
    if (index != -1) {
      // Update status to cancelled
      final booking = _bookings[index];
      _bookings[index] = booking.copyWith(status: BookingStatus.cancelled);
      return true;
    }
    return false;
  }
}
