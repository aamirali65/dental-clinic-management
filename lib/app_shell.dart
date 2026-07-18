import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_spacing.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/appointments/screens/appointments_screen.dart';
import 'features/patients/screens/patients_screen.dart';
import 'features/reports/screens/reports_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'shared/providers/app_provider.dart';

class AppShell extends ConsumerWidget {
  final Widget child;
  final int currentIndex;

  AppShell({
    super.key,
    required this.child,
  }) : currentIndex = _getIndexForLocation(child);

  static int _getIndexForLocation(Widget child) {
    if (child is DashboardScreen) return 0;
    if (child is AppointmentsScreen) return 1;
    if (child is PatientsScreen) return 2;
    if (child is ReportsScreen) return 3;
    if (child is ProfileScreen) return 4;
    return 0;
  }

  void _onTabSelected(BuildContext context, int index, WidgetRef ref) {
    ref.read(selectedBottomNavProvider.notifier).state = index;
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/appointments');
        break;
      case 2:
        context.go('/patients');
        break;
      case 3:
        context.go('/reports');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedBottomNavProvider);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: SalomonBottomBar(
              currentIndex: selectedIndex,
              onTap: (index) => _onTabSelected(context, index, ref),
              duration: const Duration(milliseconds: 300),
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textGrey,
              backgroundColor: Colors.transparent,
              itemPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              items: [
                SalomonBottomBarItem(
                  icon: const Icon(Icons.grid_view_rounded, size: 24),
                  title: const Text('Dashboard', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.calendar_month_rounded, size: 24),
                  title: const Text('Appointments', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.people_rounded, size: 24),
                  title: const Text('Patients', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.bar_chart_rounded, size: 24),
                  title: const Text('Reports', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.person_rounded, size: 24),
                  title: const Text('Profile', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
