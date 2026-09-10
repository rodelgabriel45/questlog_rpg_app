import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:questlog_rpg/core/constants/app_colors.dart';
import 'package:questlog_rpg/core/constants/app_radius.dart';
import 'package:questlog_rpg/core/constants/app_sizes.dart';
import 'package:questlog_rpg/core/constants/app_spacing.dart';
import 'package:questlog_rpg/core/theme/app_text_styles.dart';
import 'package:questlog_rpg/features/player/providers/player_provider.dart';
import 'package:questlog_rpg/features/quest/provider/quest_provider.dart';
import 'package:questlog_rpg/features/quest/widgets/reward_card.dart';
import 'package:questlog_rpg/models/quest/quest.dart';
import 'package:questlog_rpg/models/quest/quest_category.dart';

class QuestDetailsScreen extends StatelessWidget {
  final String questId;
  const QuestDetailsScreen({super.key, required this.questId});

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    Quest quest,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Quest?'),
          content: Text('Are you sure you want to delete ${quest.title}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    if (!context.mounted) {
      return;
    }

    context.read<QuestProvider>().deleteQuest(questId);

    context.pop();
  }

  Future<void> _completeQuest(BuildContext context, Quest quest) async {
    final questProvider = context.read<QuestProvider>();
    final playerProvider = context.read<PlayerProvider>();

    final completedQuest = questProvider.completeQuest(quest.id);

    if (completedQuest == null) return;

    final levelsGained = playerProvider.rewardPlayer(
      xp: completedQuest.xpReward,
      gold: completedQuest.goldReward,
    );

    if (!context.mounted) return;

    await _showQuestCompleteDialog(context, completedQuest);

    if (levelsGained > 0 && context.mounted) {
      await _showLevelUpDialog(context, playerProvider.player.level);
    }
  }

  Future<void> _showQuestCompleteDialog(
    BuildContext context,
    Quest quest,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.success,
                  size: 40,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                'Quest Complete!',
                style: AppTextStyles.headlineSmall,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                quest.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.lg),

              Row(
                children: [
                  Expanded(
                    child: RewardCard(
                      icon: Icons.auto_awesome,
                      value: '+${quest.xpReward}',
                      label: 'XP',
                      color: AppColors.gold,
                    ),
                  ),

                  const SizedBox(width: AppSpacing.sm),

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

              const SizedBox(height: AppSpacing.lg),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Awesome!'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showLevelUpDialog(BuildContext context, int newLevel) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: AppColors.primary,
                  size: 48,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                'Level Up!',
                style: AppTextStyles.headlineSmall,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                'Level $newLevel',
                style: AppTextStyles.displayMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'You reached a new level!',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.lg),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Awesome!'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showUpdateProgressDialog(
    BuildContext context,
    Quest quest,
  ) async {
    final newProgress = await showDialog<int>(
      context: context,
      builder: (context) {
        return _UpdateProgressDialog(quest: quest);
      },
    );

    if (newProgress == null || !context.mounted) {
      return;
    }

    context.read<QuestProvider>().updateQuestProgress(quest.id, newProgress);
  }

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
      appBar: AppBar(
        title: const Text('Quest Details'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit_outlined),
                  title: Text('Edit Quest'),
                ),
              ),

              PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: Text('Delete Quest'),
                ),
              ),
            ],

            onSelected: (value) {
              if (value == 'edit') {
                context.push('/quests/$questId/edit');
              }

              if (value == 'delete') {
                _showDeleteConfirmation(context, quest);
              }
            },
          ),
        ],
      ),
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

          const SizedBox(height: AppSpacing.lg),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: ButtonStyle(
                side: WidgetStateProperty.all(
                  BorderSide(width: 1.5, color: AppColors.primary),
                ),
              ),
              onPressed: () {
                _showUpdateProgressDialog(context, quest);
              },
              child: const Text('Update Progress'),
            ),
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
                  _completeQuest(context, quest);
                },
                child: const Text('Complete Quest'),
              ),
            ),
        ],
      ),
    );
  }
}

class _UpdateProgressDialog extends StatefulWidget {
  final Quest quest;
  const _UpdateProgressDialog({required this.quest});

  @override
  State<_UpdateProgressDialog> createState() => _UpdateProgressDialogState();
}

class _UpdateProgressDialogState extends State<_UpdateProgressDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.quest.currentProgress.toString(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final progress = int.parse(_controller.text.trim());

    Navigator.of(context).pop(progress);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Progress'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Current Progress',
            hintText: '0 - ${widget.quest.targetProgress}',
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your progress';
            }

            final progress = int.tryParse(value.trim());

            if (progress == null) {
              return 'Please enter a valid number';
            }

            if (progress < 0) {
              return 'Progress cannot be negative';
            }

            if (progress > widget.quest.targetProgress) {
              return 'Progress cannot exceed ${widget.quest.targetProgress}';
            }

            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),

        FilledButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}
