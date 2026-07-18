import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_button.dart';
import '../../../shared/models/user_model.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),
            _buildProfileHeader(context, user),
            const SizedBox(height: AppSpacing.xxl),
            _buildMenuSection(context),
            const SizedBox(height: AppSpacing.xxl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              child: AppButton(
                label: 'Log Out',
                onPressed: () => context.go('/welcome'),
                isOutlined: true,
                isFullWidth: true,
                textColor: AppColors.danger,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserModel user) {
    return Column(
      children: [
        Stack(
          children: [
            AppAvatar(name: user.fullName, size: AppSpacing.avatarXxl, showBorder: true),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => context.push('/edit-profile'),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.card, width: 3),
                  ),
                  child: const Icon(Icons.camera_alt_rounded, size: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(user.fullName, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: AppSpacing.xs),
        Text(user.specialization ?? 'Dentist', style: TextStyle(color: AppColors.textGrey, fontSize: 15)),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
          ),
          child: Text(user.isAdmin ? 'Admin' : 'Doctor', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          context,
          icon: Icons.person_outlined,
          title: 'Edit Profile',
          subtitle: 'Personal information',
          onTap: () => context.push('/edit-profile'),
        ),
        _buildMenuItem(
          context,
          icon: Icons.business_outlined,
          title: 'Clinic Details',
          subtitle: 'View clinic information',
          onTap: () => context.push('/clinic-details'),
        ),
        _buildMenuItem(
          context,
          icon: Icons.workspace_premium_outlined,
          title: 'Subscription',
          subtitle: 'Premium plan',
          onTap: () => context.push('/subscription'),
        ),
        _buildMenuItem(
          context,
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          subtitle: 'Manage alerts',
          onTap: () => context.push('/notifications'),
        ),
        _buildMenuItem(
          context,
          icon: Icons.security_outlined,
          title: 'Security',
          subtitle: 'Password & security',
          onTap: () {},
        ),
        _buildMenuItem(
          context,
          icon: Icons.help_outline_rounded,
          title: 'Help Center',
          subtitle: 'Get support',
          onTap: () {},
        ),
        _buildMenuItem(
          context,
          icon: Icons.info_outline_rounded,
          title: 'About',
          subtitle: 'Version 1.0.0',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding, vertical: AppSpacing.xs),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 22),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(subtitle, style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
