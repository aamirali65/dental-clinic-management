import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../shared/models/notification_model.dart';
import '../providers/notifications_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () => ref.read(notificationsProvider.notifier).markAllAsRead(),
            child: const Text('Mark All Read'),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const AppEmptyState(
              title: 'No Notifications',
              description: 'You\'re all caught up!',
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _NotificationCard(
                  notification: notification,
                  onTap: () => ref.read(notificationsProvider.notifier).markAsRead(notification.id),
                );
              },
            ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const _NotificationCard({required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: notification.isRead
              ? (Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card)
              : AppColors.primary.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: !notification.isRead
              ? Border.all(color: AppColors.primary.withValues(alpha: 0.2))
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: _typeColor(notification.type).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(_typeIcon(notification.type), color: _typeColor(notification.type), size: 20),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.w700,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: TextStyle(color: AppColors.textGrey, fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMM dd, yyyy - hh:mm a').format(notification.createdAt),
                    style: TextStyle(color: AppColors.textLight, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _typeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.appointment: return Icons.calendar_month_rounded;
      case NotificationType.payment: return Icons.payments_rounded;
      case NotificationType.treatment: return Icons.medical_services_rounded;
      case NotificationType.report: return Icons.bar_chart_rounded;
      case NotificationType.reminder: return Icons.notifications_active_rounded;
      case NotificationType.system: return Icons.settings_rounded;
      case NotificationType.promotion: return Icons.discount_rounded;
    }
  }

  Color _typeColor(NotificationType type) {
    switch (type) {
      case NotificationType.appointment: return AppColors.primary;
      case NotificationType.payment: return AppColors.success;
      case NotificationType.treatment: return AppColors.secondary;
      case NotificationType.report: return AppColors.chartPurple;
      case NotificationType.reminder: return AppColors.warning;
      case NotificationType.system: return AppColors.textGrey;
      case NotificationType.promotion: return AppColors.chartPink;
    }
  }
}
