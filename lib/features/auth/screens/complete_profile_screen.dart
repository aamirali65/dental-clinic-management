import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/app_avatar.dart';

class CompleteProfileScreen extends ConsumerStatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  ConsumerState<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _specializationController = TextEditingController();
  final _qualificationController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _specializationController.dispose();
    _qualificationController.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _isLoading = false);
          context.go('/clinic-setup');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () => context.pop(),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.borderLight,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                const Text(
                  'Complete\nProfile',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                    height: 1.15,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                  'Tell us about yourself to personalize\nyour experience',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textGrey,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxl),
                Center(
                  child: Stack(
                    children: [
                      const AppAvatar(
                        size: 96,
                        name: 'Dr. Sarah Chen',
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.card, width: 3),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxl),
                AppTextField(
                  label: 'Specialization',
                  hintText: 'e.g. Orthodontics',
                  controller: _specializationController,
                  prefixIcon: const Icon(Icons.medical_services_outlined, size: 20),
                ),
                const SizedBox(height: AppSpacing.xl),
                AppTextField(
                  label: 'Qualifications',
                  hintText: 'e.g. DDS, MS - Orthodontics',
                  controller: _qualificationController,
                  prefixIcon: const Icon(Icons.school_outlined, size: 20),
                ),
                const SizedBox(height: AppSpacing.xl),
                AppTextField(
                  label: 'Years of Experience',
                  hintText: 'e.g. 10',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.work_outlined, size: 20),
                ),
                const SizedBox(height: AppSpacing.xxl),
                AppButton(
                  label: 'Continue',
                  onPressed: _onContinue,
                  isFullWidth: true,
                  isLarge: true,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
