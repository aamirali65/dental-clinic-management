import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/mock_data.dart';
import '../../../shared/models/user_model.dart';

final currentUserProvider = Provider<UserModel>((ref) {
  return MockData.currentUser;
});
