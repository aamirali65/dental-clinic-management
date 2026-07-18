import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/utils/mock_data.dart';
import '../../../shared/models/appointment_model.dart';

class AppointmentDetailsScreen extends ConsumerWidget {
  final String appointmentId;

  const AppointmentDetailsScreen({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointment = MockData.appointments.firstWhere(
      (a) => a.id == appointmentId,
      orElse: () => MockData.appointments.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientHeader(context, appointment),
            const SizedBox(height: AppSpacing.xxl),
            _buildInfoCard(context, appointment),
            const SizedBox(height: AppSpacing.xxl),
            _buildDoctorCard(context, appointment),
            const SizedBox(height: AppSpacing.xxl),
            _buildActions(context, appointment),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientHeader(BuildContext context, AppointmentModel appointment) {
    return Row(
      children: [
        AppAvatar(name: appointment.patientName, size: AppSpacing.avatarXl),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.patientName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: _statusColor(appointment.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
                ),
                child: Text(
                  (() { final x = appointment.status.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })(),
                  style: TextStyle(fontWeight: FontWeight.w600, color: _statusColor(appointment.status)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, AppointmentModel appointment) {
    return AppCard(
      child: Column(
        children: [
          _InfoRow(icon: Icons.calendar_today_rounded, label: 'Date', value: DateFormat('EEEE, MMMM d, yyyy').format(appointment.date)),
          const Divider(height: AppSpacing.xxl),
          _InfoRow(icon: Icons.schedule_rounded, label: 'Time', value: '${DateFormat('hh:mm a').format(appointment.startTime)} - ${DateFormat('hh:mm a').format(appointment.endTime)}'),
          const Divider(height: AppSpacing.xxl),
          _InfoRow(icon: Icons.medical_services_outlined, label: 'Type', value: (() { final x = appointment.type.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })()),
          const Divider(height: AppSpacing.xxl),
          _InfoRow(icon: Icons.meeting_room_rounded, label: 'Location', value: appointment.location ?? 'Main Office'),
          if (appointment.notes != null) ...[
            const Divider(height: AppSpacing.xxl),
            _InfoRow(icon: Icons.notes_rounded, label: 'Notes', value: appointment.notes!),
          ],
        ],
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, AppointmentModel appointment) {
    return AppCard(
      child: Row(
        children: [
          AppAvatar(name: appointment.doctorName, size: AppSpacing.avatarLg),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appointment.doctorName, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text('Dentist', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, AppointmentModel appointment) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            label: 'Reschedule',
            isOutlined: true,
            onPressed: () {},
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: AppButton(
            label: 'Cancel',
            backgroundColor: AppColors.danger,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Color _statusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.scheduled: return AppColors.primary;
      case AppointmentStatus.confirmed: return AppColors.success;
      case AppointmentStatus.inProgress: return AppColors.warning;
      case AppointmentStatus.completed: return AppColors.success;
      case AppointmentStatus.cancelled: return AppColors.danger;
      case AppointmentStatus.noShow: return AppColors.textGrey;
    }
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
              Text(value, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}
