import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'app_button.dart';

class AppEmptyState extends StatelessWidget {
  final String title;
  final String? description;
  final String? assetPath;
  final String? buttonText;
  final VoidCallback? onButtonTap;
  final Widget? icon;

  const AppEmptyState({
    super.key,
    required this.title,
    this.description,
    this.assetPath,
    this.buttonText,
    this.onButtonTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              icon!
            else if (assetPath != null)
              SvgPicture.asset(
                assetPath!,
                width: 200,
                height: 200,
              )
            else
              Container(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.inbox_rounded,
                  size: AppSpacing.iconXxl,
                  color: AppColors.primary.withValues(alpha: 0.5),
                ),
              ),
            const SizedBox(height: AppSpacing.xxl),
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
            if (buttonText != null && onButtonTap != null) ...[
              const SizedBox(height: AppSpacing.xxl),
              AppButton(
                label: buttonText!,
                onPressed: onButtonTap,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
