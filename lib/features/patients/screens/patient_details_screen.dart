import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_section_header.dart';
import '../../../core/utils/mock_data.dart';
import '../../../shared/models/appointment_model.dart';
import '../../../shared/models/patient_model.dart';

class PatientDetailsScreen extends ConsumerWidget {
  final String patientId;

  const PatientDetailsScreen({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patient = MockData.patients.firstWhere(
      (p) => p.id == patientId,
      orElse: () => MockData.patients.first,
    );
    final appointments = MockData.appointmentsByPatient(patientId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, patient),
            const SizedBox(height: AppSpacing.xl),
            _buildQuickInfo(context, patient),
            const SizedBox(height: AppSpacing.xl),
            AppSectionHeader(title: 'Medical History'),
            _buildMedicalInfo(context, patient),
            const SizedBox(height: AppSpacing.xl),
            AppSectionHeader(title: 'Recent Appointments'),
            ...appointments.take(3).map((a) => _buildAppointmentItem(context, a)),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PatientModel patient) {
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
            AppAvatar(name: patient.fullName, size: AppSpacing.avatarXxl, showBorder: true),
            const SizedBox(height: AppSpacing.lg),
            Text(patient.fullName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
            const SizedBox(height: AppSpacing.xs),
            Text('${patient.age} years, ${(() { final x = patient.gender.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })()}', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfo(BuildContext context, PatientModel patient) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Row(
        children: [
          _QuickInfoChip(icon: Icons.phone_outlined, label: patient.phone),
          const SizedBox(width: AppSpacing.sm),
          _QuickInfoChip(icon: Icons.email_outlined, label: patient.email ?? 'No email'),
          const SizedBox(width: AppSpacing.sm),
          _QuickInfoChip(icon: Icons.calendar_today_rounded, label: DateFormat('MMM dd, yyyy').format(patient.dateOfBirth)),
        ],
      ),
    );
  }

  Widget _buildMedicalInfo(BuildContext context, PatientModel patient) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MedicalRow(label: 'Blood Type', value: patient.bloodType?.name ?? 'Unknown'),
            const Divider(height: AppSpacing.xxl),
            _MedicalRow(label: 'Allergies', value: patient.allergies.isEmpty ? 'None' : patient.allergies.join(', ')),
            const Divider(height: AppSpacing.xxl),
            _MedicalRow(label: 'Conditions', value: patient.medicalConditions.isEmpty ? 'None' : patient.medicalConditions.join(', ')),
            const Divider(height: AppSpacing.xxl),
            _MedicalRow(label: 'Insurance', value: patient.insuranceProvider ?? 'Not provided'),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentItem(BuildContext context, AppointmentModel appointment) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding, vertical: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: const Icon(Icons.calendar_month_rounded, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat('MMM dd, yyyy').format(appointment.date), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600)),
                Text('${appointment.doctorName} - ${(() { final x = appointment.type.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })()}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
              ],
            ),
          ),
          Text(appointment.isPaid ? '\$${appointment.amount?.toStringAsFixed(0) ?? ''}' : 'Unpaid',
              maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w600, color: appointment.isPaid ? AppColors.success : AppColors.warning)),
        ],
      ),
    );
  }
}

class _QuickInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickInfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.borderLight,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: AppColors.primary),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 10, color: AppColors.textGrey), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class _MedicalRow extends StatelessWidget {
  final String label;
  final String value;

  const _MedicalRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: AppColors.textGrey)),
        Text(value, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
