import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.light;
});

final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(themeModeProvider) == ThemeMode.dark;
});

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final selectedBottomNavProvider = StateProvider<int>((ref) {
  return 0;
});

final searchQueryProvider = StateProvider<String>((ref) {
  return '';
});

final isSearchActiveProvider = StateProvider<bool>((ref) {
  return false;
});
