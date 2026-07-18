import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/mock_data.dart';
import '../../../shared/models/appointment_model.dart';
import '../../../shared/models/doctor_model.dart';
import '../../../shared/models/patient_model.dart';

final appointmentsProvider = Provider<List<AppointmentModel>>((ref) {
  return MockData.appointments;
});

final upcomingAppointmentsProvider = Provider<List<AppointmentModel>>((ref) {
  return MockData.upcomingAppointments;
});

final todayAppointmentsProvider = Provider<List<AppointmentModel>>((ref) {
  return MockData.todayAppointments;
});

final allPatientsProvider = Provider<List<PatientModel>>((ref) {
  return MockData.patients;
});

final allDoctorsProvider = Provider<List<DoctorModel>>((ref) {
  return MockData.doctors;
});
