import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/utils/mock_data.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/treatment_model.dart';

class TreatmentDetailsScreen extends ConsumerWidget {
  final String treatmentId;

  const TreatmentDetailsScreen({super.key, required this.treatmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treatment = MockData.treatments.firstWhere(
      (t) => t.id == treatmentId,
      orElse: () => MockData.treatments.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Treatment Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, treatment),
            const SizedBox(height: AppSpacing.xxl),
            _buildProgressSection(context, treatment),
            const SizedBox(height: AppSpacing.xl),
            _buildInfoCard(context, treatment),
            const SizedBox(height: AppSpacing.xl),
            _buildCostCard(context, treatment),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TreatmentModel treatment) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: _statusColor(treatment.status).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          ),
          child: Icon(Icons.medical_services_rounded, color: _statusColor(treatment.status), size: 32),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(treatment.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: _statusColor(treatment.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
                ),
                child: Text((() { final x = treatment.status.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })(),
                    style: TextStyle(fontWeight: FontWeight.w600, color: _statusColor(treatment.status))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection(BuildContext context, TreatmentModel treatment) {
    final progressPercent = (treatment.progress * 100).toInt();
    return AppCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Progress', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
              Text('$progressPercent%', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            child: LinearProgressIndicator(
              value: treatment.progress,
              backgroundColor: AppColors.borderLight,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('${treatment.sessionsCompleted} of ${treatment.sessionsTotal} sessions completed',
              style: TextStyle(color: AppColors.textGrey)),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, TreatmentModel treatment) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Treatment Information', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.md),
          _InfoRow(label: 'Patient', value: treatment.patientName),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(label: 'Doctor', value: treatment.doctorName),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(label: 'Category', value: (() { final x = treatment.category.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })()),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(label: 'Start Date', value: DateFormat('MMM dd, yyyy').format(treatment.startDate)),
          if (treatment.endDate != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _InfoRow(label: 'End Date', value: DateFormat('MMM dd, yyyy').format(treatment.endDate!)),
          ],
          if (treatment.description != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(treatment.description!, style: TextStyle(color: AppColors.textGrey)),
          ],
        ],
      ),
    );
  }

  Widget _buildCostCard(BuildContext context, TreatmentModel treatment) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cost Summary', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.md),
          _InfoRow(label: 'Total Cost', value: Formatters.currency(treatment.cost)),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(label: 'Paid Amount', value: Formatters.currency(treatment.paidAmount)),
          const SizedBox(height: AppSpacing.sm),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(
            label: 'Remaining',
            value: Formatters.currency(treatment.remainingAmount),
            valueColor: treatment.isFullyPaid ? AppColors.success : AppColors.warning,
          ),
          if (!treatment.isFullyPaid) ...[
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Record Payment',
              onPressed: () {},
              isFullWidth: true,
            ),
          ],
        ],
      ),
    );
  }

  Color _statusColor(TreatmentStatus status) {
    switch (status) {
      case TreatmentStatus.notStarted: return AppColors.textGrey;
      case TreatmentStatus.inProgress: return AppColors.primary;
      case TreatmentStatus.completed: return AppColors.success;
      case TreatmentStatus.cancelled: return AppColors.danger;
    }
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: AppColors.textGrey)),
        Text(value, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, color: valueColor)),
      ],
    );
  }
}
