import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlog_rpg/core/constants/app_spacing.dart';
import 'package:questlog_rpg/features/home/widgets/currency_row.dart';
import 'package:questlog_rpg/features/home/widgets/player_header.dart';
import 'package:questlog_rpg/features/home/widgets/todays_quests.dart';
import 'package:questlog_rpg/features/home/widgets/xp_progress.dart';
import 'package:questlog_rpg/features/player/providers/player_provider.dart';
import 'package:questlog_rpg/features/quest/provider/quest_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerProvider>().player;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PlayerHeader(),

            const SizedBox(height: AppSpacing.xxl),

            XpProgress(
              currentXp: player.currentXp,
              requiredXp: player.xpForNextLevel,
              progress: player.xpProgress,
            ),

            const SizedBox(height: AppSpacing.xxl),

            CurrencyRow(gold: player.gold, gems: player.gems),

            const SizedBox(height: AppSpacing.xxl),

            const TodaysQuests(),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            selectedIcon: Icon(Icons.task_alt),
            label: 'Quests',
          ),
          NavigationDestination(
            icon: Icon(Icons.backpack_outlined),
            selectedIcon: Icon(Icons.backpack),
            label: 'Inventory',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
        ],
      ),
    );
  }
}
