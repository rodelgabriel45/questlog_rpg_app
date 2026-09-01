import 'package:questlog_rpg/models/quest/quest_category.dart';

class Quest {
  final String id;
  final String title;
  final String description;
  final QuestCategory category;

  final int currentProgress;
  final int targetProgress;

  final int xpReward;
  final int goldReward;

  final bool isCompleted;

  const Quest({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.currentProgress,
    required this.targetProgress,
    required this.xpReward,
    required this.goldReward,
    required this.isCompleted,
  });

  double get progress {
    if (targetProgress <= 0) {
      return 0;
    }

    return (currentProgress / targetProgress).clamp(0.0, 1.0);
  }
}
