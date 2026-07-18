import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/utils/mock_data.dart';
import '../../../shared/models/doctor_model.dart';
import '../../../shared/models/patient_model.dart';

class BookAppointmentScreen extends ConsumerStatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  ConsumerState<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends ConsumerState<BookAppointmentScreen> {
  PatientModel? _selectedPatient;
  DoctorModel? _selectedDoctor;
  DateTime? _selectedDate;
  String? _selectedTime;
  String? _selectedService;
  int _step = 0;

  final _services = [
    'Consultation', 'Checkup', 'Cleaning', 'Filling',
    'Root Canal', 'Extraction', 'Whitening', 'Orthodontic',
  ];

  final _timeSlots = [
    '09:00 AM', '09:30 AM', '10:00 AM', '10:30 AM',
    '11:00 AM', '11:30 AM', '01:00 PM', '01:30 PM',
    '02:00 PM', '02:30 PM', '03:00 PM', '03:30 PM',
  ];

  void _nextStep() => setState(() => _step++);
  void _prevStep() => setState(() => _step--);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          _buildStepper(),
          Expanded(
            child: _buildStepContent(),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    final steps = ['Patient', 'Doctor', 'Service', 'Time', 'Confirm'];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Row(
        children: List.generate(steps.length, (index) {
          final isActive = index == _step;
          final isCompleted = index < _step;
          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : isCompleted ? AppColors.success : AppColors.border,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : Text('${index + 1}',
                            style: TextStyle(
                              color: isActive ? Colors.white : AppColors.textGrey,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            )),
                  ),
                ),
                const SizedBox(height: 4),
                Text(steps[index],
                    style: TextStyle(
                      fontSize: 10,
                      color: isActive ? AppColors.primary : AppColors.textGrey,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    )),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 0:
        return _buildPatientSelection();
      case 1:
        return _buildDoctorSelection();
      case 2:
        return _buildServiceSelection();
      case 3:
        return _buildTimeSelection();
      case 4:
        return _buildConfirmation();
      default:
        return const SizedBox();
    }
  }

  Widget _buildPatientSelection() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      itemCount: MockData.patients.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final patient = MockData.patients[index];
        final isSelected = _selectedPatient?.id == patient.id;
        return AppCard(
          onTap: () => setState(() => _selectedPatient = patient),
          color: isSelected ? AppColors.primary.withValues(alpha: 0.05) : null,
          borderColor: isSelected ? AppColors.primary : null,
          child: Row(
            children: [
              AppAvatar(name: patient.fullName),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(patient.fullName, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                    Text('${patient.age} years', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  ],
                ),
              ),
              if (isSelected) const Icon(Icons.check_circle_rounded, color: AppColors.primary),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDoctorSelection() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      itemCount: MockData.doctors.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final doctor = MockData.doctors[index];
        final isSelected = _selectedDoctor?.id == doctor.id;
        return AppCard(
          onTap: () => setState(() => _selectedDoctor = doctor),
          color: isSelected ? AppColors.primary.withValues(alpha: 0.05) : null,
          borderColor: isSelected ? AppColors.primary : null,
          child: Row(
            children: [
              AppAvatar(name: doctor.fullName),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.fullName, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                    Text(doctor.specialization, style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                  ],
                ),
              ),
              if (isSelected) const Icon(Icons.check_circle_rounded, color: AppColors.primary),
            ],
          ),
        );
      },
    );
  }

  Widget _buildServiceSelection() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      child: Column(
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _services.map((service) {
              final isSelected = _selectedService == service;
              return ChoiceChip(
                label: Text(service),
                selected: isSelected,
                onSelected: (selected) => setState(() => _selectedService = service),
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textDark,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelection() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Date', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: List.generate(7, (index) {
              final date = DateTime.now().add(Duration(days: index));
              final isSelected = _selectedDate != null && date.year == _selectedDate!.year && date.month == _selectedDate!.month && date.day == _selectedDate!.day;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedDate = date),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.borderLight,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(DateFormat('E').format(date).substring(0, 1),
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            )),
                        Text('${date.day}',
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textDark,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text('Select Time', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                childAspectRatio: 2.5,
              ),
              itemCount: _timeSlots.length,
              itemBuilder: (context, index) {
                final time = _timeSlots[index];
                final isSelected = _selectedTime == time;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTime = time),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.borderLight,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      border: isSelected ? null : Border.all(color: AppColors.border),
                    ),
                    child: Center(
                      child: Text(time,
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textDark,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          )),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmation() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Review your booking',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.xxl),
          AppCard(
            child: Column(
              children: [
                _ConfirmRow(label: 'Patient', value: _selectedPatient?.fullName ?? ''),
                const Divider(),
                _ConfirmRow(label: 'Doctor', value: _selectedDoctor?.fullName ?? ''),
                const Divider(),
                _ConfirmRow(label: 'Service', value: _selectedService ?? ''),
                const Divider(),
                _ConfirmRow(label: 'Date', value: _selectedDate != null ? DateFormat('MMM dd, yyyy').format(_selectedDate!) : ''),
                const Divider(),
                _ConfirmRow(label: 'Time', value: _selectedTime ?? ''),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_rounded, color: AppColors.success),
                const SizedBox(width: AppSpacing.md),
                const Expanded(
                  child: Text('No payment required at booking. You can pay at the clinic.',
                      style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_step > 0)
            Expanded(
              child: AppButton(
                label: 'Back',
                onPressed: _prevStep,
                isOutlined: true,
              ),
            ),
          if (_step > 0) const SizedBox(width: AppSpacing.md),
          Expanded(
            child: AppButton(
              label: _step == 4 ? 'Confirm Booking' : 'Continue',
              onPressed: _step == 4
                  ? () {
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Appointment booked successfully!'),
                          backgroundColor: AppColors.success,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  : _nextStep,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfirmRow extends StatelessWidget {
  final String label;
  final String value;

  const _ConfirmRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: AppColors.textGrey)),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

