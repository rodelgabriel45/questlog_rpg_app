import 'package:flutter/material.dart';
import 'package:questlog_rpg/core/constants/app_colors.dart';
import 'package:questlog_rpg/core/constants/app_radius.dart';
import 'package:questlog_rpg/core/constants/app_sizes.dart';
import 'package:questlog_rpg/core/constants/app_spacing.dart';
import 'package:questlog_rpg/core/theme/app_text_styles.dart';

class QuestCard extends StatelessWidget {
  final String title;
  final int currentProgress;
  final int targetProgress;
  final int xpReward;
  final IconData icon;
  final Color iconColor;
  const QuestCard({
    super.key,
    required this.title,
    required this.currentProgress,
    required this.targetProgress,
    required this.xpReward,
    required this.icon,
    required this.iconColor,
  });

  double get progress {
    if (targetProgress <= 0) {
      return 0;
    }

    return (currentProgress / targetProgress).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Quest Icon
              Container(
                width: AppSizes.questIcon,
                height: AppSizes.questIcon,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: AppSizes.iconMedium),
              ),

              const SizedBox(width: AppSpacing.md),

              // Quest Title
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              // XP reward
              Text(
                '+$xpReward XP',
                style: AppTextStyles.xp.copyWith(color: AppColors.gold),
              ),

              const SizedBox(height: AppSpacing.sm),
            ],
          ),

          // Progress
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: AppSizes.progressHeightSmall,
                    backgroundColor: AppColors.surfaceSecondary,
                    valueColor: AlwaysStoppedAnimation(iconColor),
                  ),
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              Text(
                '$currentProgress / $targetProgress',
                style: AppTextStyles.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
