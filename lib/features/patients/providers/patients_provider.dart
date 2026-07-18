import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/mock_data.dart';
import '../../../shared/models/patient_model.dart';

final patientsProvider = Provider<List<PatientModel>>((ref) {
  return MockData.patients;
});

final patientByIdProvider = Provider.family<PatientModel?, String>((ref, id) {
  try {
    return MockData.patients.firstWhere((p) => p.id == id);
  } catch (_) {
    return null;
  }
});
