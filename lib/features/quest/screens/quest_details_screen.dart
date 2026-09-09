import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlog_rpg/core/constants/app_colors.dart';
import 'package:questlog_rpg/core/constants/app_radius.dart';
import 'package:questlog_rpg/core/constants/app_sizes.dart';
import 'package:questlog_rpg/core/constants/app_spacing.dart';
import 'package:questlog_rpg/core/theme/app_text_styles.dart';
import 'package:questlog_rpg/features/player/providers/player_provider.dart';
import 'package:questlog_rpg/features/quest/provider/quest_provider.dart';
import 'package:questlog_rpg/features/quest/widgets/reward_card.dart';
import 'package:questlog_rpg/models/quest/quest_category.dart';

class QuestDetailsScreen extends StatelessWidget {
  final String questId;
  const QuestDetailsScreen({super.key, required this.questId});

  @override
  Widget build(BuildContext context) {
    final quest = context.watch<QuestProvider>().getQuestById(questId);

    if (quest == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quest Details'), centerTitle: true),
        body: const Center(child: Text('Quest not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Quest Details'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        children: [
          // Icon
          Center(
            child: Container(
              width: AppSizes.questIcon * 1.5,
              height: AppSizes.questIcon * 1.5,
              decoration: BoxDecoration(
                color: quest.category.color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                quest.category.icon,
                color: quest.category.color,
                size: AppSizes.iconLarge,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Quest Title
          Text(
            quest.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // Category
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: quest.category.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                quest.category.label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: quest.category.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.xxxl),

          // Description Heading
          Text('Description', style: AppTextStyles.labelLarge),

          const SizedBox(height: AppSpacing.sm),

          // Description
          Text(
            quest.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),

          Text('Progress', style: AppTextStyles.labelLarge),

          const SizedBox(height: AppSpacing.md),

          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      LinearProgressIndicator(
                        value: quest.progress,
                        minHeight: 16,
                        backgroundColor: AppColors.surfaceSecondary,
                        valueColor: AlwaysStoppedAnimation(
                          quest.category.color,
                        ),
                      ),

                      Text(
                        '${(quest.progress * 100).round()}%',
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
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

          const SizedBox(height: AppSpacing.xxl),

          Text('Rewards', style: AppTextStyles.labelLarge),

          const SizedBox(height: AppSpacing.md),

          Row(
            children: [
              Expanded(
                child: RewardCard(
                  icon: Icons.bolt,
                  value: '+${quest.xpReward}',
                  label: 'XP',
                  color: AppColors.gold,
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: RewardCard(
                  icon: Icons.monetization_on_outlined,
                  value: '+${quest.goldReward}',
                  label: 'Gold',
                  color: AppColors.gold,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xxxl),

          if (quest.isCompleted)
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.success),

                  const SizedBox(width: AppSpacing.sm),

                  Text(
                    'Quest Completed',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          else
            SizedBox(
              height: 52,
              child: FilledButton(
                onPressed: () {
                  final questProvider = context.read<QuestProvider>();
                  final playerProvider = context.read<PlayerProvider>();

                  final completedQuest = questProvider.completeQuest(quest.id);

                  if (completedQuest != null) {
                    playerProvider.rewardPlayer(
                      xp: completedQuest.xpReward,
                      gold: completedQuest.goldReward,
                    );
                  }
                },
                child: const Text('Complete Quest'),
              ),
            ),
        ],
      ),
    );
  }
}
