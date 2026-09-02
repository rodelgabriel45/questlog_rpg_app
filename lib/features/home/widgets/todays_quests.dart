import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlog_rpg/core/constants/app_colors.dart';
import 'package:questlog_rpg/core/constants/app_spacing.dart';
import 'package:questlog_rpg/core/constants/app_strings.dart';
import 'package:questlog_rpg/core/theme/app_text_styles.dart';
import 'package:questlog_rpg/features/home/widgets/quest_card.dart';
import 'package:questlog_rpg/features/quest/provider/quest_provider.dart';

class TodaysQuests extends StatelessWidget {
  const TodaysQuests({super.key});

  @override
  Widget build(BuildContext context) {
    final quests = context.watch<QuestProvider>().quests;

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

        Column(
          children: [
            for (int i = 0; i < quests.length; i++) ...[
              QuestCard(quest: quests[i]),

              if (i < quests.length - 1) const SizedBox(height: AppSpacing.sm),
            ],
          ],
        ),
      ],
    );
  }
}
