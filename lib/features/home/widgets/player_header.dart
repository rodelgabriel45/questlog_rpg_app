import 'package:flutter/material.dart';
import 'package:questlog_rpg/core/constants/app_colors.dart';
import 'package:questlog_rpg/core/constants/app_radius.dart';
import 'package:questlog_rpg/core/constants/app_sizes.dart';
import 'package:questlog_rpg/core/constants/app_spacing.dart';
import 'package:questlog_rpg/core/theme/app_text_styles.dart';

class PlayerHeader extends StatelessWidget {
  const PlayerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        Container(
          width: AppSizes.avatarMedium,
          height: AppSizes.avatarMedium,
          decoration: BoxDecoration(
            color: AppColors.xpLight,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: const Icon(
            Icons.person,
            color: AppColors.primary,
            size: AppSizes.iconMedium,
          ),
        ),

        const SizedBox(width: AppSpacing.md),

        // Player Information
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rod Ranger', style: AppTextStyles.labelLarge),

              const SizedBox(height: AppSpacing.xs),

              Text('Level 12', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
