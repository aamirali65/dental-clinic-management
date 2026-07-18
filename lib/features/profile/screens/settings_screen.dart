import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/providers/app_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          _buildSectionHeader(context, 'Appearance'),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingTile(
            context,
            icon: Icons.dark_mode_rounded,
            title: 'Dark Mode',
            trailing: Switch(
              value: isDark,
              onChanged: (v) {
                ref.read(themeModeProvider.notifier).state =
                    v ? ThemeMode.dark : ThemeMode.light;
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          _buildSectionHeader(context, 'Notifications'),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingTile(
            context,
            icon: Icons.notifications_active_outlined,
            title: 'Push Notifications',
            trailing: Switch(value: true, onChanged: (v) {}),
          ),
          _buildSettingTile(
            context,
            icon: Icons.email_outlined,
            title: 'Email Notifications',
            trailing: Switch(value: true, onChanged: (v) {}),
          ),
          _buildSettingTile(
            context,
            icon: Icons.sms_outlined,
            title: 'SMS Reminders',
            trailing: Switch(value: false, onChanged: (v) {}),
          ),
          const SizedBox(height: AppSpacing.xxl),
          _buildSectionHeader(context, 'Preferences'),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingTile(
            context,
            icon: Icons.language_rounded,
            title: 'Language',
            subtitle: 'English',
            trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
          ),
          _buildSettingTile(
            context,
            icon: Icons.attach_money_rounded,
            title: 'Currency',
            subtitle: 'USD (\$)',
            trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
          ),
          const SizedBox(height: AppSpacing.xxl),
          _buildSectionHeader(context, 'Support'),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingTile(
            context,
            icon: Icons.help_outline_rounded,
            title: 'Help Center',
            trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
          ),
          _buildSettingTile(
            context,
            icon: Icons.description_outlined,
            title: 'Privacy Policy',
            trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
          ),
          _buildSettingTile(
            context,
            icon: Icons.gavel_outlined,
            title: 'Terms of Service',
            trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.sm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
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
                  child: Icon(icon, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
                      if (subtitle != null) Text(subtitle, style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
                    ],
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
