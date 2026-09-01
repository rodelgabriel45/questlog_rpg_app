class Player {
  final String name;
  final int level;
  final int currentXp;
  final int xpForNextLevel;
  final int gold;
  final int gems;

  const Player({
    required this.name,
    required this.level,
    required this.currentXp,
    required this.xpForNextLevel,
    required this.gold,
    required this.gems,
  });

  double get xpProgress {
    if (xpForNextLevel <= 0) {
      return 0;
    }

    return (currentXp / xpForNextLevel).clamp(0.0, 1.0);
  }
}
