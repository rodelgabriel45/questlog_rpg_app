import 'package:flutter/material.dart';
import 'package:questlog_rpg/models/quest/quest.dart';
import 'package:questlog_rpg/models/quest/sample_quests.dart';

class QuestProvider extends ChangeNotifier {
  List<Quest> _quests = sampleQuests;

  List<Quest> get quests => _quests;
}
