import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/utils/mock_data.dart';
import '../../../shared/models/doctor_model.dart';

class DoctorProfileScreen extends ConsumerWidget {
  final String doctorId;

  const DoctorProfileScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctor = MockData.doctors.firstWhere(
      (d) => d.id == doctorId,
      orElse: () => MockData.doctors.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, doctor),
            const SizedBox(height: AppSpacing.xl),
            _buildStats(context, doctor),
            const SizedBox(height: AppSpacing.xl),
            _buildAbout(context, doctor),
            const SizedBox(height: AppSpacing.xl),
            _buildServices(context, doctor),
            const SizedBox(height: AppSpacing.xl),
            _buildWorkingHours(context, doctor),
            const SizedBox(height: AppSpacing.xxl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              child: AppButton(
                label: 'Book Appointment',
                onPressed: () => context.push('/book-appointment'),
                isFullWidth: true,
                isLarge: true,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, DoctorModel doctor) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppAvatar(name: doctor.fullName, size: AppSpacing.avatarXxl, showBorder: true, isActive: doctor.isAvailable),
            const SizedBox(height: AppSpacing.lg),
            Text(doctor.fullName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
            const SizedBox(height: AppSpacing.xs),
            Text(doctor.specialization, style: TextStyle(color: Colors.white70, fontSize: 15)),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star_rounded, color: AppColors.warning, size: 20),
                Text('${doctor.rating}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                Text(' (${doctor.reviewCount} reviews)', style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(width: AppSpacing.xl),
                Icon(Icons.work_history_rounded, color: Colors.white70, size: 18),
                Text(' ${doctor.experienceText}', style: TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats(BuildContext context, DoctorModel doctor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Row(
        children: [
          _StatCard(label: 'Patients', value: MockData.appointmentsByDoctor(doctor.id).length.toString()),
          const SizedBox(width: AppSpacing.sm),
          _StatCard(label: 'Experience', value: doctor.experienceText),
          const SizedBox(width: AppSpacing.sm),
          _StatCard(label: 'Fee', value: '\$${doctor.consultationFee}'),
        ],
      ),
    );
  }

  Widget _buildAbout(BuildContext context, DoctorModel doctor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.sm),
            Text(doctor.about ?? 'Experienced dental professional dedicated to providing exceptional care.',
                style: TextStyle(color: AppColors.textGrey, height: 1.5)),
            const SizedBox(height: AppSpacing.md),
            Text('Qualifications: ${doctor.qualification ?? 'N/A'}', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
            const SizedBox(height: AppSpacing.xs),
            Text('Languages: ${doctor.languages.join(', ')}', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildServices(BuildContext context, DoctorModel doctor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Services', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: doctor.services.map((s) => Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
                ),
                child: Text(s, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkingHours(BuildContext context, DoctorModel doctor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Working Hours', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.md),
            ...doctor.workingHours.entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key, style: TextStyle(fontWeight: FontWeight.w500)),
                  Text('${entry.value[0]} - ${entry.value[1]}', style: TextStyle(color: AppColors.textGrey)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
          ],
        ),
      ),
    );
  }
}
