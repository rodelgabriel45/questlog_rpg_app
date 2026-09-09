import 'package:flutter/material.dart';
import 'package:questlog_rpg/core/constants/app_colors.dart';

enum QuestCategory { fitness, learning, coding, chores, creative, custom }

extension QuestCategoryX on QuestCategory {
  IconData get icon {
    return switch (this) {
      QuestCategory.fitness => Icons.directions_run_outlined,
      QuestCategory.learning => Icons.menu_book_outlined,
      QuestCategory.coding => Icons.code,
      QuestCategory.chores => Icons.cleaning_services_outlined,
      QuestCategory.creative => Icons.auto_stories_outlined,
      QuestCategory.custom => Icons.star_outline,
    };
  }

  Color get color {
    return switch (this) {
      QuestCategory.fitness => AppColors.fitness,
      QuestCategory.learning => AppColors.learning,
      QuestCategory.coding => AppColors.coding,
      QuestCategory.chores => AppColors.chores,
      QuestCategory.creative => AppColors.creative,
      QuestCategory.custom => AppColors.custom,
    };
  }

  String get label {
    return switch (this) {
      QuestCategory.fitness => 'Fitness',
      QuestCategory.learning => 'Learning',
      QuestCategory.coding => 'Coding',
      QuestCategory.chores => 'Chores',
      QuestCategory.creative => 'Creative',
      QuestCategory.custom => 'Custom',
    };
  }
}
