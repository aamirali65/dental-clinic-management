import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../../shared/models/doctor_model.dart';
import '../providers/doctors_provider.dart';

class DoctorsScreen extends ConsumerStatefulWidget {
  const DoctorsScreen({super.key});

  @override
  ConsumerState<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends ConsumerState<DoctorsScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final doctors = ref.watch(doctorsProvider);
    final filtered = doctors.where((d) =>
      _searchQuery.isEmpty ||
      d.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      d.specialization.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding, AppSpacing.sm, AppSpacing.screenPadding, AppSpacing.md),
            child: AppSearchBar(
              hintText: 'Search doctors...',
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                  final doctor = filtered[index];
                  return _DoctorCard(doctor: doctor).animate().fadeIn(duration: 300.ms, delay: (index * 50).ms).slideX(begin: 0.05, curve: Curves.easeOut);
                },
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const _DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => context.push('/doctors/${doctor.id}'),
      child: Row(
        children: [
          AppAvatar(name: doctor.fullName, size: AppSpacing.avatarLg, isActive: doctor.isAvailable),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor.fullName, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(doctor.specialization, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 16, color: AppColors.warning),
                    Text('${doctor.rating}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    Text(' (${doctor.reviewCount})', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
                    const SizedBox(width: AppSpacing.md),
                    Icon(Icons.work_history_rounded, size: 14, color: AppColors.textGrey),
                    Text(' ${doctor.experienceText}', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
        ],
      ),
    );
  }
}
