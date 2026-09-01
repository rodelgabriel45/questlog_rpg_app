import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlog_rpg/core/theme/app_theme.dart';
import 'package:questlog_rpg/features/home/screens/home_screen.dart';
import 'package:questlog_rpg/features/player/providers/player_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PlayerProvider(),
      child: const QuestLogApp(),
    ),
  );
}

class QuestLogApp extends StatelessWidget {
  const QuestLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
