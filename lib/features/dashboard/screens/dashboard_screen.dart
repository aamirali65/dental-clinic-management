import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_section_header.dart';
import '../../../core/utils/formatters.dart';

import '../providers/dashboard_provider.dart';
import '../widgets/greeting_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/appointment_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dashboardDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () => context.push('/notifications'),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.danger,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.sm),
              GreetingCard(greeting: data.greeting).animate().fadeIn().slideX(),
              const SizedBox(height: AppSpacing.xxl),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
                child: Row(
                  children: [
                    StatsCard(
                      title: 'Revenue',
                      value: Formatters.compactCurrency(data.todayRevenue),
                      icon: Icons.trending_up_rounded,
                      color: AppColors.success,
                      route: '/billing',
                    ),
                    const SizedBox(width: AppSpacing.md),
                    StatsCard(
                      title: 'Patients',
                      value: Formatters.count(data.totalPatients),
                      icon: Icons.people_rounded,
                      color: AppColors.primary,
                      route: '/patients',
                    ),
                    const SizedBox(width: AppSpacing.md),
                    StatsCard(
                      title: 'Doctors',
                      value: Formatters.count(data.totalDoctors),
                      icon: Icons.medical_services_rounded,
                      color: AppColors.secondary,
                      route: '/doctors',
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: AppSpacing.xxl),
              AppSectionHeader(
                title: "Today's Appointments",
                actionLabel: 'View All',
                onActionTap: () => context.push('/appointments'),
              ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.05, curve: Curves.easeOut),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
                  itemCount: data.todayAppointments.length.clamp(0, 5),
                  separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final apt = data.todayAppointments[index];
                    return _TodayAppointmentChip(
                      time: Formatters.time(apt.startTime),
                      patient: apt.patientName,
                       type: (() { final x = apt.type.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })(),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              AppSectionHeader(
                title: 'Revenue Overview',
                actionLabel: 'View Reports',
                onActionTap: () => context.push('/reports'),
              ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.05, curve: Curves.easeOut),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
                child: _RevenueChart(data: data.revenueByMonth),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: AppSpacing.xxl),
              AppSectionHeader(
                title: 'Upcoming Appointments',
                actionLabel: 'Book New',
                onActionTap: () => context.push('/book-appointment'),
              ).animate().fadeIn(delay: 600.ms).slideX(begin: 0.05, curve: Curves.easeOut),
              ...data.upcomingAppointments.take(4).toList().asMap().entries.map((e) =>
                AppointmentCard(appointment: e.value).animate().fadeIn(duration: 300.ms, delay: (e.key * 100).ms).slideX(begin: 0.05, curve: Curves.easeOut)
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodayAppointmentChip extends StatelessWidget {
  final String time;
  final String patient;
  final String type;

  const _TodayAppointmentChip({
    required this.time,
    required this.patient,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            patient,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            type,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textGrey,
                ),
          ),
        ],
      ),
    );
  }
}

class _RevenueChart extends StatelessWidget {
  final Map<String, int> data;

  const _RevenueChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.toList();
    final maxValue = entries.fold<double>(0, (max, e) => e.value > max ? e.value.toDouble() : max);

    return Container(
      height: 200,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxValue * 1.3,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${Formatters.compactCurrency(rod.toY)}\n${entries[groupIndex].key}',
                  TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= entries.length) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      entries[index].key,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textGrey,
                      ),
                    ),
                  );
                },
                reservedSize: 28,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxValue / 4,
            getDrawingHorizontalLine: (value) => FlLine(
              color: AppColors.borderLight,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: entries.asMap().entries.map((entry) {
            return BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value.value.toDouble(),
                  color: AppColors.primary,
                  width: 24,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}
