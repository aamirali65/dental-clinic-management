import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/mock_data.dart';
import '../../../shared/models/treatment_model.dart';

final treatmentsProvider = Provider<List<TreatmentModel>>((ref) {
  return MockData.treatments;
});
