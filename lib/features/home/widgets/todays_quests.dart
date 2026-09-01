import 'package:flutter/material.dart';
import 'package:questlog_rpg/core/constants/app_colors.dart';
import 'package:questlog_rpg/core/constants/app_spacing.dart';
import 'package:questlog_rpg/core/constants/app_strings.dart';
import 'package:questlog_rpg/core/theme/app_text_styles.dart';
import 'package:questlog_rpg/features/home/widgets/quest_card.dart';

class TodaysQuests extends StatelessWidget {
  const TodaysQuests({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(AppStrings.todaysQuests, style: AppTextStyles.headlineSmall),

            const Spacer(),

            TextButton(
              onPressed: () {},
              child: Text(
                'View all',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),

        const QuestCard(
          title: 'Walk 10,000 Steps',
          currentProgress: 6000,
          targetProgress: 10000,
          xpReward: 100,
          icon: Icons.directions_run,
          iconColor: AppColors.fitness,
        ),

        const SizedBox(height: AppSpacing.sm),

        const QuestCard(
          title: 'Study Flutter for 1 Hour',
          currentProgress: 0,
          targetProgress: 60,
          xpReward: 150,
          icon: Icons.menu_book_outlined,
          iconColor: AppColors.learning,
        ),

        const SizedBox(height: AppSpacing.sm),

        const QuestCard(
          title: 'Read 30 Minutes',
          currentProgress: 10,
          targetProgress: 30,
          xpReward: 75,
          icon: Icons.auto_stories_outlined,
          iconColor: AppColors.creative,
        ),
      ],
    );
  }
}
