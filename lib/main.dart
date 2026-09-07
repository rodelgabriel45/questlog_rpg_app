import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlog_rpg/core/router/app_router.dart';
import 'package:questlog_rpg/core/theme/app_theme.dart';
import 'package:questlog_rpg/features/player/providers/player_provider.dart';
import 'package:questlog_rpg/features/quest/provider/quest_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerProvider()),

        ChangeNotifierProvider(create: (_) => QuestProvider()),
      ],
      child: const QuestLogApp(),
    ),
  );
}

class QuestLogApp extends StatelessWidget {
  const QuestLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
