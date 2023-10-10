// ignore: unused_import
import 'dart:math';

class Game {
  List<List<String>> _board = [];
  Difficulty _currentDifficulty = Difficulty.easy;
  int _customBoardRows = 0;
  int _customBoardCols = 0;

  // Inicializa o jogo com as configurações padrão
  void init() {
    _generateBoard();
  }

  // Gera o tabuleiro com base nas configurações de dificuldade ou tamanho personalizado
  void _generateBoard() {
    if (_currentDifficulty != Difficulty.custom) {
      _board = List.generate(
        _currentDifficulty.boardRows,
        (_) => List.generate(_currentDifficulty.boardCols, (_) => ' '),
      );
    } else {
      if (_customBoardRows <= 0 || _customBoardCols <= 0) {
        throw ArgumentError(
            'O número de linhas e colunas deve ser maior que zero.');
      }
      _board = List.generate(
        _customBoardRows,
        (_) => List.generate(_customBoardCols, (_) => ' '),
      );
    }
  }

  // Retorna o tabuleiro atual
  List<List<String>> getBoard() {
    return _board;
  }

  // Define a dificuldade do jogo
  void setDifficulty(Difficulty difficulty) {
    _currentDifficulty = difficulty;
    _generateBoard(); // Regenera o tabuleiro com as novas configurações de dificuldade
  }

  // Define o tamanho do tabuleiro diretamente (para personalização)
  void setBoardSize(int rows, int cols) {
    if (rows <= 0 || cols <= 0) {
      throw ArgumentError(
          'O número de linhas e colunas deve ser maior que zero.');
    }
    _currentDifficulty = Difficulty
        .custom; // Define a dificuldade como custom para personalização
    _customBoardRows = rows; // Armazena o tamanho personalizado
    _customBoardCols = cols;
    _generateBoard(); // Regenera o tabuleiro com as novas configurações de tamanho
  }
}

enum Difficulty {
  easy,
  medium,
  hard,
  custom, // Adicionamos uma dificuldade "custom" para personalização
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
