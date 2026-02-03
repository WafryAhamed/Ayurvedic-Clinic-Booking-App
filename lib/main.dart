import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'features/home/providers/doctor_provider.dart';
import 'features/booking/providers/booking_provider.dart';

void main() {
  runApp(const AyurvedicClinicApp());
}

/// Main application widget
class AyurvedicClinicApp extends StatelessWidget {
  const AyurvedicClinicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Doctor Provider for managing doctor list and operations
        ChangeNotifierProvider(create: (_) => DoctorProvider()),

        // Booking Provider for managing booking flow
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp(
        title: 'Ayurvedic Clinic',
        debugShowCheckedModeBanner: false,

        // Theme
        theme: AppTheme.lightTheme,

        // Routes
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.getRoutes(),

        // Route generation for handling arguments
        onGenerateRoute: (settings) {
          // Handle routes with arguments if needed
          return null; // Let the routes map handle it
        },
      ),
    );
  }
}
