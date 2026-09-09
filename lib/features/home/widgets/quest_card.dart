import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  @override
  Widget build(BuildContext context) {
    final questColor = quest.category.color;
    final isCompleted = quest.isCompleted;

    return InkWell(
      onTap: () {
        context.push('/quests/${quest.id}');
      },
      child: Ink(
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
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: AppSizes.questIcon,
                      height: AppSizes.questIcon,
                      decoration: BoxDecoration(
                        color: quest.category.color.withValues(
                          alpha: isCompleted ? 0.08 : 0.12,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        quest.category.icon,
                        color: quest.category.color.withValues(
                          alpha: isCompleted ? 0.65 : 1.0,
                        ),
                        size: AppSizes.iconMedium,
                      ),
                    ),

                    if (isCompleted)
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.surface,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ),
                  ],
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
                      valueColor: AlwaysStoppedAnimation(quest.category.color),
                    ),
                  ),
                ),

                const SizedBox(width: AppSpacing.sm),

                Text(
                  isCompleted
                      ? '✓ Completed'
                      : '${quest.currentProgress} / ${quest.targetProgress}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isCompleted
                        ? AppColors.success
                        : AppColors.textSecondary,
                    fontWeight: isCompleted
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
