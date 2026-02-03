import 'package:flutter/material.dart';
import '../features/splash/screens/splash_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/search/screens/search_screen.dart';
import '../features/filter/screens/filter_screen.dart';
import '../features/doctor_details/screens/doctor_details_screen.dart';
import '../features/booking/screens/patient_info_screen.dart';
import '../features/booking/screens/date_time_selection_screen.dart';
import '../features/booking/screens/booking_review_screen.dart';
import '../features/confirmation/screens/confirmation_screen.dart';

/// Application routes configuration
class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String search = '/search';
  static const String filter = '/filter';
  static const String doctorDetails = '/doctor-details';
  static const String patientInfo = '/patient-info';
  static const String dateTimeSelection = '/date-time-selection';
  static const String bookingReview = '/booking-review';
  static const String confirmation = '/confirmation';

  /// Get all routes as a map
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      onboarding: (context) => const OnboardingScreen(),
      home: (context) => const HomeScreen(),
      search: (context) => const SearchScreen(),
      filter: (context) => const FilterScreen(),
      doctorDetails: (context) => const DoctorDetailsScreen(),
      patientInfo: (context) => const PatientInfoScreen(),
      dateTimeSelection: (context) => const DateTimeSelectionScreen(),
      bookingReview: (context) => const BookingReviewScreen(),
      confirmation: (context) => const ConfirmationScreen(),
    };
  }

  /// Initial route
  static const String initialRoute = splash;
}
