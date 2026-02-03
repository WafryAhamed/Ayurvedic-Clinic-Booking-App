import 'package:flutter/material.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/search/screens/search_screen.dart';
import '../../features/filter/screens/filter_screen.dart';
import '../../features/doctor_details/screens/doctor_details_screen.dart';
import '../../features/booking/screens/patient_info_screen.dart';
import '../../features/booking/screens/date_time_selection_screen.dart';
import '../../features/booking/screens/booking_review_screen.dart';
import '../../features/confirmation/screens/confirmation_screen.dart';
// Phase 2: Appointment Management Imports
import '../../features/appointments/my_appointments/screens/my_appointments_screen.dart';
import '../../features/appointments/appointment_details/screens/appointment_details_screen.dart';
import '../../features/appointments/cancel_appointment/screens/cancel_appointment_screen.dart';
import '../../features/appointments/reschedule_appointment/screens/reschedule_appointment_screen.dart';
// System Screens
import '../../features/system/screens/loading_screen.dart';
import '../../features/system/screens/no_internet_screen.dart';
import '../../features/system/screens/error_screen.dart';
import '../../features/system/screens/empty_state_screen.dart';
import '../../features/system/screens/session_expired_screen.dart';
// Profile & Settings Screens
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';
import '../../features/profile/screens/about_screen.dart';
// Legal Screens
import '../../features/legal/screens/terms_screen.dart';
import '../../features/legal/screens/privacy_screen.dart';
// Admin Screens (Future Scope)
import '../../features/admin/screens/admin_login_screen.dart';
import '../../features/admin/screens/admin_dashboard_screen.dart';
import '../../features/admin/screens/doctor_management_screen.dart';
import '../../features/admin/screens/schedule_management_screen.dart';
import '../../features/admin/screens/appointment_management_screen.dart';
import '../../features/admin/screens/reports_screen.dart';

/// Application routes configuration
class AppRoutes {
  // Phase 1 Route names
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

  // Phase 2 Route names - Appointment Management
  static const String myAppointments = '/my-appointments';
  static const String appointmentDetails = '/appointment-details';
  static const String cancelAppointment = '/cancel-appointment';
  static const String rescheduleAppointment = '/reschedule-appointment';

  // System Routes
  static const String loading = '/loading';
  static const String noInternet = '/no-internet';
  static const String error = '/error';
  static const String emptyState = '/empty-state';
  static const String sessionExpired = '/session-expired';

  // Profile & Settings Routes
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String about = '/about';

  // Legal Routes
  static const String terms = '/terms';
  static const String privacy = '/privacy';

  // Admin Routes (Future Scope)
  static const String adminLogin = '/admin-login';
  static const String adminDashboard = '/admin-dashboard';
  static const String doctorManagement = '/doctor-management';
  static const String scheduleManagement = '/schedule-management';
  static const String appointmentManagement = '/appointment-management';
  static const String reports = '/reports';

  /// Get all routes as a map
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      // Phase 1 Routes
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

      // Phase 2 Routes - Appointment Management
      myAppointments: (context) => const MyAppointmentsScreen(),
      appointmentDetails: (context) => const AppointmentDetailsScreen(),
      cancelAppointment: (context) => const CancelAppointmentScreen(),
      rescheduleAppointment: (context) => const RescheduleAppointmentScreen(),

      // System Routes
      loading: (context) => const LoadingScreen(),
      noInternet: (context) => const NoInternetScreen(),
      error: (context) => const ErrorScreen(),
      emptyState: (context) => const EmptyStateScreen(),
      sessionExpired: (context) => const SessionExpiredScreen(),

      // Profile & Settings Routes
      profile: (context) => const ProfileScreen(),
      editProfile: (context) => const EditProfileScreen(),
      about: (context) => const AboutScreen(),

      // Legal Routes
      terms: (context) => const TermsScreen(),
      privacy: (context) => const PrivacyScreen(),

      // Admin Routes (Future Scope)
      adminLogin: (context) => const AdminLoginScreen(),
      adminDashboard: (context) => const AdminDashboardScreen(),
      doctorManagement: (context) => const DoctorManagementScreen(),
      scheduleManagement: (context) => const ScheduleManagementScreen(),
      appointmentManagement: (context) => const AppointmentManagementScreen(),
      reports: (context) => const ReportsScreen(),
    };
  }

  /// Initial route
  static const String initialRoute = splash;
}
