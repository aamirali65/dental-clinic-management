import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/mock_data.dart';
import '../../../shared/models/doctor_model.dart';

final doctorsProvider = Provider<List<DoctorModel>>((ref) {
  return MockData.doctors;
});

final doctorByIdProvider = Provider.family<DoctorModel?, String>((ref, id) {
  try {
    return MockData.doctors.firstWhere((d) => d.id == id);
  } catch (_) {
    return null;
  }
});
