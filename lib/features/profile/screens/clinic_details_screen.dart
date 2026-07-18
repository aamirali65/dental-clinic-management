import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';

class ClinicDetailsScreen extends ConsumerWidget {
  const ClinicDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinic Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: const Center(
                child: Icon(
                  Icons.medical_services_rounded,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppCard(
              child: Column(
                children: [
                  _DetailRow(icon: Icons.business_rounded, label: 'Clinic Name', value: 'DentalFix Clinic'),
                  const Divider(height: AppSpacing.xxl),
                  _DetailRow(icon: Icons.location_on_rounded, label: 'Address', value: '123 Medical Center Dr, Suite 100, New York, NY 10001'),
                  const Divider(height: AppSpacing.xxl),
                  _DetailRow(icon: Icons.phone_rounded, label: 'Phone', value: '+1 (555) 000-1234'),
                  const Divider(height: AppSpacing.xxl),
                  _DetailRow(icon: Icons.email_rounded, label: 'Email', value: 'contact@dentalfix.com'),
                  const Divider(height: AppSpacing.xxl),
                  _DetailRow(icon: Icons.schedule_rounded, label: 'Working Hours', value: 'Mon - Fri: 8:00 AM - 6:00 PM\nSat: 9:00 AM - 1:00 PM'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
              const SizedBox(height: 2),
              Text(value, style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}
