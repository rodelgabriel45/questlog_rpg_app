import 'package:flutter/material.dart';
import 'package:questlog_rpg/models/player/player.dart';
import 'package:questlog_rpg/models/player/sample_player.dart';

class PlayerProvider extends ChangeNotifier {
  Player _player = samplePlayer;

  Player get player => _player;

  int rewardPlayer({required int xp, required int gold}) {
    var newXp = _player.currentXp + xp;
    var newLevel = _player.level;
    var newXpForNextLevel = _player.xpForNextLevel;
    var levelsGained = 0;

    const xpIncreasePerLevel = 500;

    while (newXp >= newXpForNextLevel) {
      newXp -= newXpForNextLevel;

      newLevel++;
      levelsGained++;
      newXpForNextLevel += xpIncreasePerLevel;
    }

    _player = _player.copyWith(
      level: newLevel,
      currentXp: newXp,
      xpForNextLevel: newXpForNextLevel,
      gold: _player.gold + gold,
    );

    notifyListeners();

    return levelsGained;
  }
}
