import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/screens/splash_screen.dart';
import 'features/auth/screens/onboarding_screen.dart';
import 'features/auth/screens/fast_login_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';
import 'features/auth/screens/forgot_password_screen.dart';
import 'features/auth/screens/otp_screen.dart';
import 'features/auth/screens/reset_password_screen.dart';
import 'features/auth/screens/complete_profile_screen.dart';
import 'features/auth/screens/clinic_setup_screen.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/appointments/screens/appointments_screen.dart';
import 'features/patients/screens/patients_screen.dart';
import 'features/reports/screens/reports_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/appointments/screens/appointment_details_screen.dart';
import 'features/appointments/screens/book_appointment_screen.dart';
import 'features/patients/screens/patient_details_screen.dart';
import 'features/doctors/screens/doctor_profile_screen.dart';
import 'features/doctors/screens/doctors_screen.dart';
import 'features/billing/screens/billing_screen.dart';
import 'features/billing/screens/payment_details_screen.dart';
import 'features/billing/screens/receipt_screen.dart';
import 'features/treatments/screens/treatments_screen.dart';
import 'features/treatments/screens/treatment_details_screen.dart';
import 'features/notifications/screens/notifications_screen.dart';
import 'features/profile/screens/settings_screen.dart';
import 'features/profile/screens/edit_profile_screen.dart';
import 'features/profile/screens/clinic_details_screen.dart';
import 'features/profile/screens/subscription_screen.dart';
import 'app_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/fast-login',
      builder: (context, state) => const FastLoginScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => const OtpScreen(),
    ),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    GoRoute(
      path: '/complete-profile',
      builder: (context, state) => const CompleteProfileScreen(),
    ),
    GoRoute(
      path: '/clinic-setup',
      builder: (context, state) => const ClinicSetupScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/appointments',
          builder: (context, state) => const AppointmentsScreen(),
        ),
        GoRoute(
          path: '/patients',
          builder: (context, state) => const PatientsScreen(),
        ),
        GoRoute(
          path: '/reports',
          builder: (context, state) => const ReportsScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/appointments/:id',
      builder: (context, state) => AppointmentDetailsScreen(
        appointmentId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/book-appointment',
      builder: (context, state) => const BookAppointmentScreen(),
    ),
    GoRoute(
      path: '/patients/:id',
      builder: (context, state) => PatientDetailsScreen(
        patientId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/doctors/:id',
      builder: (context, state) => DoctorProfileScreen(
        doctorId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/doctors',
      builder: (context, state) => const DoctorsScreen(),
    ),
    GoRoute(
      path: '/billing',
      builder: (context, state) => const BillingScreen(),
    ),
    GoRoute(
      path: '/billing/:id',
      builder: (context, state) => PaymentDetailsScreen(
        invoiceId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/receipt/:id',
      builder: (context, state) => ReceiptScreen(
        paymentId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/treatments',
      builder: (context, state) => const TreatmentsScreen(),
    ),
    GoRoute(
      path: '/treatments/:id',
      builder: (context, state) => TreatmentDetailsScreen(
        treatmentId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/clinic-details',
      builder: (context, state) => const ClinicDetailsScreen(),
    ),
    GoRoute(
      path: '/subscription',
      builder: (context, state) => const SubscriptionScreen(),
    ),
  ],
);
