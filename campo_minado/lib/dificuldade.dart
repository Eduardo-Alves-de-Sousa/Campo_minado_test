// Enum para representar os diferentes níveis de dificuldade
enum Difficulty {
  easy, // Fácil
  medium, // Médio
  hard, // Difícil
  custom, // Personalizado
  nonExistentDifficulty, // Dificuldade não existente (usado como padrão)
}

// Extensão para a enum Difficulty, adicionando propriedades para o número de linhas e colunas do tabuleiro
extension DifficultyExtension on Difficulty {
  // Obtém o número de linhas do tabuleiro com base na dificuldade
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

  // Obtém o número de colunas do tabuleiro com base na dificuldade
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
