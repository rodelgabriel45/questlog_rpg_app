import 'package:flutter/material.dart';
import 'package:questlog_rpg/core/theme/app_text_styles.dart';
import 'package:questlog_rpg/models/quest/quest_category.dart';

class CreateQuestScreen extends StatefulWidget {
  const CreateQuestScreen({super.key});

  @override
  State<CreateQuestScreen> createState() => _CreateQuestScreenState();
}

class _CreateQuestScreenState extends State<CreateQuestScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetController = TextEditingController();
  final _xpController = TextEditingController();
  final _goldController = TextEditingController();

  QuestCategory? _selectedCategory;

  String _categoryLabel(QuestCategory category) {
    switch (category) {
      case QuestCategory.fitness:
        return 'Fitness';
      case QuestCategory.learning:
        return 'Learning';
      case QuestCategory.coding:
        return 'Coding';
      case QuestCategory.chores:
        return 'Chores';
      case QuestCategory.creative:
        return 'Creative';
      case QuestCategory.custom:
        return 'Custom';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetController.dispose();
    _xpController.dispose();
    _goldController.dispose();
    super.dispose();
  }

  void _createQuest() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final category = _selectedCategory;
    final target = int.parse(_targetController.text.trim());
    final xp = int.parse(_xpController.text.trim());
    final gold = int.parse(_goldController.text.trim());

    debugPrint('Title: $title');
    debugPrint('Description: $description');
    debugPrint('Category: $category');
    debugPrint('Target: $target');
    debugPrint('XP: $xp');
    debugPrint('Gold: $gold');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Quest'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          children: [
            Text('Create a new quest', style: AppTextStyles.headlineSmall),

            const SizedBox(height: 8),

            Text(
              'Define a challenge and start your next adventure.',
              style: AppTextStyles.bodyMedium,
            ),

            const SizedBox(height: 32),

            TextFormField(
              controller: _titleController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Quest Title',
                hintText: 'e.g Walk 10,000 Steps',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a quest title';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _descriptionController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'What do you need to accomplish?',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a description';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<QuestCategory>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              items: QuestCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(_categoryLabel(category)),
                );
              }).toList(),
              onChanged: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a category';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _targetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Target',
                hintText: 'e.g. 10000',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a target';
                }

                final target = int.tryParse(value.trim());

                if (target == null) {
                  return 'Please enter a valid number';
                }

                if (target <= 0) {
                  return 'Target must be greater than 0';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            Text('Rewards', style: AppTextStyles.labelLarge),

            const SizedBox(height: 16),

            TextFormField(
              controller: _xpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'XP Reward',
                hintText: 'e.g. 100',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an XP reward';
                }

                final xp = int.tryParse(value.trim());

                if (xp == null) {
                  return 'Please enter a valid number';
                }

                if (xp <= 0) {
                  return 'XP reward must be greater than 0';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _goldController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Gold Reward',
                hintText: 'e.g. 20',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a gold reward';
                }

                final gold = int.tryParse(value.trim());

                if (gold == null) {
                  return 'Please enter a valid number';
                }

                if (gold <= 0) {
                  return 'Gold reward must be greater than 0';
                }

                return null;
              },
            ),

            const SizedBox(height: 32),

            SizedBox(
              height: 52,
              child: FilledButton(
                onPressed: _createQuest,
                child: const Text('Create Quest'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
