import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_section_header.dart';
import '../../../core/utils/formatters.dart';
import '../providers/reports_provider.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(reportsDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              child: Row(
                children: [
                  _buildStatCard(context, 'Total Revenue', Formatters.compactCurrency(data.totalRevenue), AppColors.success, Icons.trending_up_rounded),
                  const SizedBox(width: AppSpacing.sm),
                  _buildStatCard(context, 'Appointments', Formatters.count(data.totalAppointments), AppColors.primary, Icons.calendar_month_rounded),
                  const SizedBox(width: AppSpacing.sm),
                  _buildStatCard(context, 'Patients', Formatters.count(data.totalPatients), AppColors.secondary, Icons.people_rounded),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppSectionHeader(title: 'Revenue Trend'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              child: _LineChartWidget(data: data.revenueByMonth),
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppSectionHeader(title: 'Appointments Overview'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              child: _BarChartWidget(data: data.appointmentsByMonth),
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppSectionHeader(title: 'Treatment Distribution'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              child: _PieChartWidget(data: data.treatmentStats),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: AppSpacing.sm),
            Text(value, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: color)),
            Text(title, style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
          ],
        ),
      ),
    );
  }
}

class _LineChartWidget extends StatelessWidget {
  final Map<String, int> data;

  const _LineChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.toList();
    final maxValue = entries.fold<double>(0, (max, e) => e.value > max ? e.value.toDouble() : max);

    final chart = LineChart(
      LineChartData(
        minY: 0,
        maxY: maxValue * 1.2,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxValue / 4,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.borderLight,
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= entries.length) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(entries[index].key, style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                );
              },
              reservedSize: 28,
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: entries.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value.toDouble())).toList(),
            isCurved: true,
            color: AppColors.primary,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                radius: 4,
                color: AppColors.primary,
                strokeWidth: 2,
                strokeColor: Colors.white,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 300),
    );

    return SizedBox(
      height: 240,
      child: AppCard(child: chart),
    );
  }
}

class _BarChartWidget extends StatelessWidget {
  final Map<String, int> data;

  const _BarChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.toList();
    final maxValue = entries.fold(0.0, (max, e) => e.value > max ? e.value.toDouble() : max.toDouble());

    return AppCard(
      child: SizedBox(
        height: 200,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: maxValue * 1.3,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    '${rod.toY.toInt()}\n${entries[groupIndex].key}',
                    TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 12),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= entries.length) return const SizedBox();
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(entries[index].key, style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                    );
                  },
                  reservedSize: 28,
                ),
              ),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: maxValue / 4),
            borderData: FlBorderData(show: false),
            barGroups: entries.asMap().entries.map((e) => BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: e.value.value.toDouble(),
                  color: AppColors.chartTeal,
                  width: 20,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                ),
              ],
            )).toList(),
          ),
        ),
      ),
    );
  }
}

class _PieChartWidget extends StatelessWidget {
  final Map<String, double> data;

  const _PieChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = [AppColors.chartGreen, AppColors.chartTeal, AppColors.chartOrange, AppColors.chartRed];
    final entries = data.entries.toList();
    final total = entries.fold(0.0, (s, e) => s + e.value);

    return AppCard(
      child: Row(
        children: [
          SizedBox(
            width: 140,
            height: 140,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 35,
                sections: entries.asMap().entries.map((e) {
                  return PieChartSectionData(
                    value: e.value.value,
                    color: colors[e.key % colors.length],
                    radius: 45,
                    title: '${((e.value.value / total) * 100).toInt()}%',
                    titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 11),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xxl),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: entries.asMap().entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  children: [
                    Container(width: 10, height: 10, decoration: BoxDecoration(
                      color: colors[e.key % colors.length],
                      shape: BoxShape.circle,
                    )),
                    const SizedBox(width: AppSpacing.sm),
                    Text(e.value.key, style: TextStyle(fontSize: 13)),
                    const Spacer(),
                    Text('${(e.value.value.toInt())}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
