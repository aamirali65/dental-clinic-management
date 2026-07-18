import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final bool isActive;
  final bool showBorder;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = AppSpacing.avatarMd,
    this.isActive = false,
    this.showBorder = false,
  });

  String? get _effectiveImageUrl {
    if (imageUrl != null) return imageUrl;
    if (name != null) {
      final encoded = name!.replaceAll(' ', '+');
      return 'https://ui-avatars.com/api/?name=$encoded&background=2563EB&color=fff&size=${size.toInt()}';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: showBorder
                ? Border.all(color: AppColors.card, width: 2)
                : null,
            boxShadow: showBorder
                ? [
                    BoxShadow(
                      color: AppColors.overlay,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: CircleAvatar(
            radius: size / 2,
            backgroundColor: (AppColors.primary).withValues(alpha: 0.1),
            backgroundImage: _effectiveImageUrl != null ? NetworkImage(_effectiveImageUrl!) : null,
            child: imageUrl == null && name != null
                ? Text(
                    (() { final parts = name!.split(' '); return (parts.length >= 2) ? '${parts.first[0]}${parts.last[0]}'.toUpperCase() : name![0].toUpperCase(); })(),
                    style: TextStyle(
                      fontSize: size * 0.35,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  )
                : null,
          ),
        ),
        if (isActive)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.3,
              height: size * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success,
                border: Border.all(color: AppColors.card, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

class AppAvatarGroup extends StatelessWidget {
  final List<String> names;
  final double size;
  final int maxCount;

  const AppAvatarGroup({
    super.key,
    required this.names,
    this.size = AppSpacing.avatarSm,
    this.maxCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    final displayNames = names.take(maxCount).toList();
    final remaining = names.length - maxCount;

    return SizedBox(
      height: size,
      child: Stack(
        children: [
          for (int i = 0; i < displayNames.length; i++)
            Positioned(
              left: i * (size * 0.6),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.card, width: 2),
                ),
                child: CircleAvatar(
                  radius: size / 2,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Text(
                    (() { final parts = displayNames[i].split(' '); return (parts.length >= 2) ? '${parts.first[0]}${parts.last[0]}'.toUpperCase() : displayNames[i][0].toUpperCase(); })(),
                    style: TextStyle(
                      fontSize: size * 0.3,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          if (remaining > 0)
            Positioned(
              left: maxCount * (size * 0.6),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.border,
                  border: Border.all(color: AppColors.card, width: 2),
                ),
                child: Center(
                  child: Text(
                    '+$remaining',
                    style: TextStyle(
                      fontSize: size * 0.3,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGrey,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
