import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../shared/models/treatment_model.dart';
import '../../../core/utils/mock_data.dart';
import '../../../core/utils/formatters.dart';

class TreatmentsScreen extends ConsumerStatefulWidget {
  const TreatmentsScreen({super.key});

  @override
  ConsumerState<TreatmentsScreen> createState() => _TreatmentsScreenState();
}

class _TreatmentsScreenState extends ConsumerState<TreatmentsScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final treatments = MockData.treatments;
    final filtered = treatments.where((t) =>
      _searchQuery.isEmpty ||
      t.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      t.patientName.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Treatments'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding, AppSpacing.sm, AppSpacing.screenPadding, AppSpacing.md),
            child: AppSearchBar(
              hintText: 'Search treatments...',
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                  final treatment = filtered[index];
                  return _TreatmentCard(treatment: treatment).animate().fadeIn(duration: 300.ms, delay: (index * 50).ms).slideX(begin: 0.05, curve: Curves.easeOut);
                },
            ),
          ),
        ],
      ),
    );
  }
}

class _TreatmentCard extends StatelessWidget {
  final TreatmentModel treatment;

  const _TreatmentCard({required this.treatment});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => context.push('/treatments/${treatment.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppAvatar(name: treatment.patientName),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(treatment.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(treatment.patientName, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: _statusColor(treatment.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
                ),
                child: Text((() { final x = treatment.status.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })(),
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _statusColor(treatment.status))),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            child: LinearProgressIndicator(
              value: treatment.progress,
              backgroundColor: AppColors.borderLight,
              valueColor: AlwaysStoppedAnimation<Color>(_statusColor(treatment.status)),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${treatment.sessionsCompleted}/${treatment.sessionsTotal} sessions',
                  maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
              Text(Formatters.currency(treatment.cost), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
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
