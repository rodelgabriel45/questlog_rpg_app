import 'package:flutter/material.dart';
import 'package:questlog_rpg/models/quest/quest.dart';
import 'package:questlog_rpg/models/quest/sample_quests.dart';

class QuestProvider extends ChangeNotifier {
  final List<Quest> _quests = [...sampleQuests];

  List<Quest> get quests => List.unmodifiable(_quests);

  void updateQuestProgress(String questId, int newProgress) {
    final index = _quests.indexWhere((quest) => quest.id == questId);

    if (index == -1) {
      return;
    }

    final quest = _quests[index];

    final progress = newProgress.clamp(0, quest.targetProgress);

    _quests[index] = quest.copyWith(currentProgress: progress);

    notifyListeners();
  }

  Quest? completeQuest(String questId) {
    final index = _quests.indexWhere((quest) => quest.id == questId);

    if (index == -1) {
      return null;
    }

    final quest = _quests[index];

    if (quest.isCompleted) {
      return null;
    }

    final completedQuest = quest.copyWith(
      currentProgress: quest.targetProgress,
      isCompleted: true,
    );

    _quests[index] = completedQuest;

    notifyListeners();

    return completedQuest;
  }
}
