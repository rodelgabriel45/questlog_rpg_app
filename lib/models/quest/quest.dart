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

  Quest copyWith({
    String? id,
    String? title,
    String? description,
    QuestCategory? category,
    int? currentProgress,
    int? targetProgress,
    int? xpReward,
    int? goldReward,
    bool? isCompleted,
  }) {
    return Quest(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      currentProgress: currentProgress ?? this.currentProgress,
      targetProgress: targetProgress ?? this.targetProgress,
      xpReward: xpReward ?? this.xpReward,
      goldReward: goldReward ?? this.goldReward,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
