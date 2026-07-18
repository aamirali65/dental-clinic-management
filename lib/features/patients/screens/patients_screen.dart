import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../shared/models/patient_model.dart';
import '../providers/patients_provider.dart';

class PatientsScreen extends ConsumerStatefulWidget {
  const PatientsScreen({super.key});

  @override
  ConsumerState<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends ConsumerState<PatientsScreen> {
  String _searchQuery = '';
  String _genderFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final patients = ref.watch(patientsProvider);
    final filteredPatients = _filterPatients(patients);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: () => _showFilterSheet(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding,
              AppSpacing.sm,
              AppSpacing.screenPadding,
              AppSpacing.md,
            ),
            child: AppSearchBar(
              hintText: 'Search patients...',
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
          Expanded(
            child: filteredPatients.isEmpty
                ? const AppEmptyState(
                    title: 'No Patients Found',
                    description: 'Try a different search term',
                  )
                : RefreshIndicator(
                    onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
                      itemCount: filteredPatients.length,
                      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          final patient = filteredPatients[index];
                          return _PatientTile(patient: patient).animate().fadeIn(duration: 300.ms, delay: (index * 50).ms).slideX(begin: 0.05, curve: Curves.easeOut);
                        },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  List<PatientModel> _filterPatients(List<PatientModel> patients) {
    return patients.where((p) {
      final searchMatch = _searchQuery.isEmpty ||
          p.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (p.email?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
          p.phone.contains(_searchQuery);
      return searchMatch;
    }).toList();
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXxl)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: AppSpacing.xl),
            const Text('Filter Patients', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.xxl),
            const Text('Gender'),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              children: ['All', 'Male', 'Female'].map((g) => FilterChip(
                label: Text(g),
                selected: _genderFilter == g,
                onSelected: (_) {
                  setState(() => _genderFilter = g);
                  Navigator.pop(context);
                },
              )).toList(),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _PatientTile extends StatelessWidget {
  final PatientModel patient;

  const _PatientTile({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: InkWell(
        onTap: () => context.push('/patients/${patient.id}'),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              AppAvatar(name: patient.fullName, size: AppSpacing.avatarMd),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(patient.fullName, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.person_outlined, size: 14, color: AppColors.textGrey),
                        const SizedBox(width: 4),
                        Text('${patient.age} yrs', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                        const SizedBox(width: AppSpacing.md),
                        Icon(Icons.phone_outlined, size: 14, color: AppColors.textGrey),
                        const SizedBox(width: 4),
                        Text(patient.phone, style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                      ],
                    ),
                  ],
                ),
              ),
              Text('${patient.totalVisits} visits', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
            ],
          ),
        ),
      ),
    );
  }
}
