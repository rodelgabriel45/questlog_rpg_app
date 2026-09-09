import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:questlog_rpg/features/home/screens/home_screen.dart';
import 'package:questlog_rpg/features/inventory/screens/inventory_screen.dart';
import 'package:questlog_rpg/features/navigation/screens/main_screen.dart';
import 'package:questlog_rpg/features/quest/provider/quest_provider.dart';
import 'package:questlog_rpg/features/quest/screens/create_quest_screen.dart';
import 'package:questlog_rpg/features/quest/screens/quest_details_screen.dart';
import 'package:questlog_rpg/features/quest/screens/quests_screen.dart';
import 'package:questlog_rpg/features/stats/screens/stats_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) {
                return const HomeScreen();
              },
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/quests',
              builder: (context, state) {
                return const QuestsScreen();
              },
              routes: [
                GoRoute(
                  path: 'create',
                  builder: (context, state) {
                    return const CreateQuestScreen();
                  },
                ),

                GoRoute(
                  path: ':questId',
                  builder: (context, state) {
                    final questId = state.pathParameters['questId']!;

                    return QuestDetailsScreen(questId: questId);
                  },
                ),

                GoRoute(
                  path: ':questId/edit',
                  builder: (context, state) {
                    final questId = state.pathParameters['questId']!;

                    final quest = context.read<QuestProvider>().getQuestById(
                      questId,
                    );

                    if (quest == null) {
                      return Scaffold(
                        body: Center(child: const Text('Quest not found.')),
                      );
                    }

                    return CreateQuestScreen(quest: quest);
                  },
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/inventory',
              builder: (context, state) {
                return const InventoryScreen();
              },
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stats',
              builder: (context, state) {
                return const StatsScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
