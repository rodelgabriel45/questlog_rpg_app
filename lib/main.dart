import 'package:flutter/material.dart';
import 'package:questlog_rpg/core/theme/app_theme.dart';
import 'package:questlog_rpg/features/home/screens/home_screen.dart';

void main() {
  runApp(const QuestLogApp());
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
