import 'package:flutter/material.dart';
import 'package:questlog_rpg/core/constants/app_colors.dart';
import 'package:questlog_rpg/core/constants/app_radius.dart';
import 'package:questlog_rpg/core/constants/app_spacing.dart';
import 'package:questlog_rpg/core/theme/app_text_styles.dart';

class CurrencyRow extends StatelessWidget {
  final int gold;
  final int gems;
  const CurrencyRow({super.key, required this.gold, required this.gems});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _CurrencyCard(
            icon: Icons.monetization_on_outlined,
            iconColor: AppColors.gold,
            value: gold,
            label: 'Gold',
          ),
        ),

        const SizedBox(width: AppSpacing.md),

        Expanded(
          child: _CurrencyCard(
            icon: Icons.diamond_outlined,
            iconColor: AppColors.xp,
            value: gems,
            label: 'Gems',
          ),
        ),
      ],
    );
  }
}

class _CurrencyCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final int value;
  final String label;
  const _CurrencyCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),

          const SizedBox(width: AppSpacing.sm),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$value',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(label, style: AppTextStyles.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
