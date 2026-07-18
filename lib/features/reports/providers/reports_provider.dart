import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/mock_data.dart';

final reportsDataProvider = Provider<ReportsData>((ref) {
  return ReportsData(
    revenueByMonth: MockData.revenueByMonth,
    appointmentsByMonth: MockData.appointmentsByMonth,
    treatmentStats: MockData.treatmentStats,
    totalRevenue: MockData.invoices.fold(0, (s, i) => s + i.total.toInt()),
    totalAppointments: MockData.appointments.length,
    totalPatients: MockData.totalPatients,
  );
});

class ReportsData {
  final Map<String, int> revenueByMonth;
  final Map<String, int> appointmentsByMonth;
  final Map<String, double> treatmentStats;
  final int totalRevenue;
  final int totalAppointments;
  final int totalPatients;

  ReportsData({
    required this.revenueByMonth,
    required this.appointmentsByMonth,
    required this.treatmentStats,
    required this.totalRevenue,
    required this.totalAppointments,
    required this.totalPatients,
  });
}
