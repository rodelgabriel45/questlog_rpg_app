import 'package:questlog_rpg/models/quest/quest.dart';
import 'package:questlog_rpg/models/quest/quest_category.dart';

const sampleQuests = [
  Quest(
    id: 'quest_001',
    title: 'Walk 10,000 Steps',
    description: 'Walk 10,000 steps today.',
    category: QuestCategory.fitness,
    currentProgress: 6000,
    targetProgress: 10000,
    xpReward: 100,
    goldReward: 25,
    isCompleted: false,
  ),

  Quest(
    id: 'quest_002',
    title: 'Study Flutter for 1 Hour',
    description: 'Spend one hour learning Flutter.',
    category: QuestCategory.learning,
    currentProgress: 0,
    targetProgress: 60,
    xpReward: 150,
    goldReward: 40,
    isCompleted: false,
  ),

  Quest(
    id: 'quest_003',
    title: 'Read 30 Minutes',
    description: 'Read for at least 30 minutes.',
    category: QuestCategory.creative,
    currentProgress: 10,
    targetProgress: 30,
    xpReward: 75,
    goldReward: 20,
    isCompleted: false,
  ),
];
