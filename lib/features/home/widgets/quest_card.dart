import 'package:flutter/material.dart';
import 'package:questlog_rpg/core/constants/app_colors.dart';
import 'package:questlog_rpg/core/constants/app_radius.dart';
import 'package:questlog_rpg/core/constants/app_sizes.dart';
import 'package:questlog_rpg/core/constants/app_spacing.dart';
import 'package:questlog_rpg/core/theme/app_text_styles.dart';
import 'package:questlog_rpg/models/quest/quest.dart';
import 'package:questlog_rpg/models/quest/quest_category.dart';

class QuestCard extends StatelessWidget {
  final Quest quest;
  const QuestCard({super.key, required this.quest});

  IconData get questIcon {
    return switch (quest.category) {
      QuestCategory.fitness => Icons.directions_run_outlined,
      QuestCategory.learning => Icons.menu_book_outlined,
      QuestCategory.coding => Icons.code,
      QuestCategory.chores => Icons.cleaning_services_outlined,
      QuestCategory.creative => Icons.auto_stories_outlined,
      QuestCategory.custom => Icons.star_outline,
    };
  }

  Color get questColor {
    return switch (quest.category) {
      QuestCategory.fitness => AppColors.fitness,
      QuestCategory.learning => AppColors.learning,
      QuestCategory.coding => AppColors.coding,
      QuestCategory.chores => AppColors.chores,
      QuestCategory.creative => AppColors.creative,
      QuestCategory.custom => AppColors.custom,
    };
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
                  color: questColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  questIcon,
                  color: questColor,
                  size: AppSizes.iconMedium,
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              // Quest Title
              Expanded(
                child: Text(
                  quest.title,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              // XP reward
              Text(
                '+${quest.xpReward} XP',
                style: AppTextStyles.xp.copyWith(color: AppColors.gold),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Progress
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: LinearProgressIndicator(
                    value: quest.progress,
                    minHeight: AppSizes.progressHeightSmall,
                    backgroundColor: AppColors.surfaceSecondary,
                    valueColor: AlwaysStoppedAnimation(questColor),
                  ),
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              Text(
                '${quest.currentProgress} / ${quest.targetProgress}',
                style: AppTextStyles.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
