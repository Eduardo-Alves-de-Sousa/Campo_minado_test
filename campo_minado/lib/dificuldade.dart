enum Difficulty {
  easy,
  medium,
  hard,
  custom,
  nonExistentDifficulty, // Adicionamos uma dificuldade "custom" para personalização
}

extension DifficultyExtension on Difficulty {
  int get boardRows {
    switch (this) {
      case Difficulty.easy:
        return 8;
      case Difficulty.medium:
        return 10;
      case Difficulty.hard:
        return 24;
      default:
        return 8; // Valor padrão para dificuldades não reconhecidas
    }
  }

  int get boardCols {
    switch (this) {
      case Difficulty.easy:
        return 8;
      case Difficulty.medium:
        return 16;
      case Difficulty.hard:
        return 24;
      default:
        return 8; // Valor padrão para dificuldades não reconhecidas
    }
  }
}
