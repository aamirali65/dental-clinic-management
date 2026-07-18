import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'app_button.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String? description;
  final Widget? content;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final IconData? icon;
  final Color? iconColor;
  final bool isLoading;
  final bool isDanger;

  const AppDialog({
    super.key,
    required this.title,
    this.description,
    this.content,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.icon,
    this.iconColor,
    this.isLoading = false,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColors.primary).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? AppColors.primary,
                  size: AppSpacing.iconXl,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
            if (description != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textGrey,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            if (content != null) ...[
              const SizedBox(height: AppSpacing.lg),
              content!,
            ],
            const SizedBox(height: AppSpacing.xxl),
            if (confirmText != null)
              AppButton(
                label: confirmText!,
                onPressed: onConfirm,
                isFullWidth: true,
                isLoading: isLoading,
                backgroundColor: isDanger ? AppColors.danger : null,
              ),
            if (cancelText != null) ...[
              const SizedBox(height: AppSpacing.sm),
              AppButton(
                label: cancelText!,
                onPressed: onCancel ?? () => Navigator.of(context).pop(),
                isFullWidth: true,
                isOutlined: true,
                textColor: AppColors.textGrey,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AppSuccessDialog extends StatelessWidget {
  final String title;
  final String? description;
  final String? buttonText;
  final VoidCallback? onPressed;

  const AppSuccessDialog({
    super.key,
    required this.title,
    this.description,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: title,
      description: description,
      icon: Icons.check_circle_rounded,
      iconColor: AppColors.success,
      confirmText: buttonText ?? 'Done',
      onConfirm: onPressed ?? () => Navigator.of(context).pop(),
    );
  }
}

class AppConfirmDialog extends StatelessWidget {
  final String title;
  final String description;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final bool isDanger;
  final bool isLoading;

  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.description,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.isDanger = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: title,
      description: description,
      icon: isDanger ? Icons.warning_rounded : Icons.info_rounded,
      iconColor: isDanger ? AppColors.danger : AppColors.primary,
      confirmText: confirmText ?? (isDanger ? 'Delete' : 'Confirm'),
      cancelText: cancelText ?? 'Cancel',
      onConfirm: onConfirm,
      onCancel: () => Navigator.of(context).pop(),
      isDanger: isDanger,
      isLoading: isLoading,
    );
  }
}
