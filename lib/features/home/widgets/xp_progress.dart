import 'package:flutter/material.dart';
import 'package:questlog_rpg/core/constants/app_colors.dart';
import 'package:questlog_rpg/core/constants/app_radius.dart';
import 'package:questlog_rpg/core/constants/app_sizes.dart';
import 'package:questlog_rpg/core/constants/app_spacing.dart';
import 'package:questlog_rpg/core/theme/app_text_styles.dart';

class XpProgress extends StatelessWidget {
  final int currentXp;
  final int requiredXp;
  const XpProgress({
    super.key,
    required this.currentXp,
    required this.requiredXp,
  });

  double get progress {
    if (requiredXp <= 0) {
      return 0;
    }

    return (currentXp / requiredXp).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'XP',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            Text('$currentXp / $requiredXp', style: AppTextStyles.bodySmall),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),

        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: AppSizes.progressHeight,
            backgroundColor: AppColors.xpLight,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
      ],
    );
  }
}
