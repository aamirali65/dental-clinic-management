import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          children: [
            _buildCurrentPlan(context),
            const SizedBox(height: AppSpacing.xxl),
            _buildPlanOption(
              context,
              name: 'Starter',
              price: '\$49',
              period: '/month',
              features: ['Up to 500 patients', '5 doctors', 'Basic analytics', 'Email support'],
              isPopular: false,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildPlanOption(
              context,
              name: 'Professional',
              price: '\$99',
              period: '/month',
              features: ['Unlimited patients', '15 doctors', 'Advanced analytics', 'Priority support', 'Custom branding'],
              isPopular: true,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildPlanOption(
              context,
              name: 'Enterprise',
              price: '\$199',
              period: '/month',
              features: ['Unlimited everything', 'Unlimited doctors', 'All features', 'Dedicated support', 'API access', 'White label'],
              isPopular: false,
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPlan(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
      ),
      child: Column(
        children: [
          const Text('Current Plan', style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: AppSpacing.sm),
          const Text('Professional', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.white, size: 16),
                SizedBox(width: AppSpacing.sm),
                Text('Active', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Next billing: Jan 15, 2027', style: TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildPlanOption(
    BuildContext context, {
    required String name,
    required String price,
    required String period,
    required List<String> features,
    required bool isPopular,
  }) {
    return AppCard(
      borderColor: isPopular ? AppColors.primary : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              ),
              if (isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
                  ),
                  child: const Text('Popular', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(price, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
              Text(period, style: TextStyle(color: AppColors.textGrey, fontSize: 14)),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                Icon(Icons.check_circle_rounded, color: AppColors.success, size: 18),
                const SizedBox(width: AppSpacing.sm),
                Text(f, style: TextStyle(color: AppColors.textGrey)),
              ],
            ),
          )),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: isPopular ? 'Current Plan' : 'Upgrade',
            onPressed: () {},
            isFullWidth: true,
            isOutlined: !isPopular,
          ),
        ],
      ),
    );
  }
}
