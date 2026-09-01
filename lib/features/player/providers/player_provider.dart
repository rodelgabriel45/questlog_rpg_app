import 'package:flutter/material.dart';
import 'package:questlog_rpg/models/player/player.dart';
import 'package:questlog_rpg/models/player/sample_player.dart';

class PlayerProvider extends ChangeNotifier {
  Player _player = samplePlayer;

  Player get player => _player;
}
