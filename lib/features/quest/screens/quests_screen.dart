import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questlog_rpg/core/constants/app_colors.dart';
import 'package:questlog_rpg/core/constants/app_radius.dart';
import 'package:questlog_rpg/features/home/widgets/quest_card.dart';
import 'package:questlog_rpg/features/quest/provider/quest_provider.dart';
import 'package:questlog_rpg/models/quest/quest.dart';

class QuestsScreen extends StatefulWidget {
  const QuestsScreen({super.key});

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  int _selectedFilter = 0;

  List<Quest> _getFilteredQuests(List<Quest> quests) {
    switch (_selectedFilter) {
      case 1:
        return quests.where((quest) => !quest.isCompleted).toList();

      case 2:
        return quests.where((quest) => quest.isCompleted).toList();

      case 0:
      default:
        return quests;
    }
  }

  @override
  Widget build(BuildContext context) {
    final quests = context.watch<QuestProvider>().quests;
    final filteredQuests = _getFilteredQuests(quests);

    return Scaffold(
      appBar: AppBar(title: const Text('Quests'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        children: [
          Text(
            'Manage your challenges',
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          const SizedBox(height: 24),

          SegmentedButton<int>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: 0, label: Text('All')),
              ButtonSegment(value: 1, label: Text('Active')),
              ButtonSegment(value: 2, label: Text('Completed')),
            ],
            selected: {_selectedFilter},
            onSelectionChanged: (selection) {
              setState(() {
                _selectedFilter = selection.first;
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.primary;
                }

                return Colors.white;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white;
                }

                return AppColors.textSecondary;
              }),

              side: WidgetStateProperty.all(
                BorderSide(color: AppColors.border),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          if (filteredQuests.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(child: Text('No Quests here yet.')),
            )
          else
            for (int i = 0; i < filteredQuests.length; i++) ...[
              QuestCard(quest: filteredQuests[i]),

              if (i < filteredQuests.length - 1) const SizedBox(height: 12),
            ],
        ],
      ),
    );
  }
}
