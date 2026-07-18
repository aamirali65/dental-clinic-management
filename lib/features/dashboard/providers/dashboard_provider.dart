import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/mock_data.dart';
import '../../../shared/models/appointment_model.dart';
import '../../../shared/models/doctor_model.dart';

final dashboardDataProvider = Provider<DashboardData>((ref) {
  return DashboardData(
    greeting: _getGreeting(),
    upcomingAppointments: MockData.upcomingAppointments,
    todayAppointments: MockData.todayAppointments,
    todayRevenue: MockData.todayRevenue,
    totalPatients: MockData.totalPatients,
    totalDoctors: MockData.totalDoctors,
    todayAppointmentsCount: MockData.todayAppointmentsCount,
    revenueByMonth: MockData.revenueByMonth,
    appointmentsByMonth: MockData.appointmentsByMonth,
    treatmentStats: MockData.treatmentStats,
    recentPatients: MockData.patients.take(5).toList(),
    doctors: MockData.doctors,
  );
});

class DashboardData {
  final String greeting;
  final List<AppointmentModel> upcomingAppointments;
  final List<AppointmentModel> todayAppointments;
  final int todayRevenue;
  final int totalPatients;
  final int totalDoctors;
  final int todayAppointmentsCount;
  final Map<String, int> revenueByMonth;
  final Map<String, int> appointmentsByMonth;
  final Map<String, double> treatmentStats;
  final List<DoctorModel> doctors;

  DashboardData({
    required this.greeting,
    required this.upcomingAppointments,
    required this.todayAppointments,
    required this.todayRevenue,
    required this.totalPatients,
    required this.totalDoctors,
    required this.todayAppointmentsCount,
    required this.revenueByMonth,
    required this.appointmentsByMonth,
    required this.treatmentStats,
    required this.recentPatients,
    required this.doctors,
  });

  final List recentPatients;
}

String _getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) return 'Good Morning';
  if (hour < 17) return 'Good Afternoon';
  return 'Good Evening';
}
