import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.gradientStart, AppColors.gradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXxxl),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.medical_services_outlined,
                  size: 64,
                  color: Colors.white,
                ),
              ).animate().fadeIn(duration: 600.ms).scale(
                    begin: const Offset(0.7, 0.7),
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(height: AppSpacing.huge),
              const Text(
                'Welcome to\nDentalFix',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  height: 1.15,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'The premium platform for modern\ndental practice management.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textGrey,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
              const Spacer(flex: 2),
              AppButton(
                label: 'Create Account',
                onPressed: () => context.go('/register'),
                isFullWidth: true,
                isLarge: true,
              ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(
                    begin: 20,
                    curve: Curves.easeOut,
                  ),
              const SizedBox(height: AppSpacing.md),
              AppButton(
                label: 'Sign In',
                onPressed: () => context.go('/login'),
                isFullWidth: true,
                isLarge: true,
                isOutlined: true,
              ).animate().fadeIn(duration: 600.ms, delay: 700.ms).slideY(
                    begin: 20,
                    curve: Curves.easeOut,
                  ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
