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

      // Adiciona bombas com base na dificuldade
      int numBombs = _calculateNumBombs();
      _placeBombs(numBombs);
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

  // Calcula o número de bombas com base na dificuldade do jogo
  int _calculateNumBombs() {
    switch (_currentDifficulty) {
      case Difficulty.easy:
        return 10;
      case Difficulty.medium:
        return 30;
      case Difficulty.hard:
        return 100;
      default:
        return 0; // Valor padrão para dificuldades não reconhecidas
    }
  }

  // Distribui as bombas aleatoriamente no tabuleiro
  void _placeBombs(int numBombs) {
    Random random = Random();
    int bombsPlaced = 0;

    while (bombsPlaced < numBombs) {
      int row = random.nextInt(_board.length);
      int col = random.nextInt(_board[0].length);

      // Se a célula não é uma bomba, coloca uma bomba
      if (_board[row][col] != 'X') {
        _board[row][col] = 'X';
        bombsPlaced++;
      }
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

  void setBoardSizeForDifficulty(Difficulty easy) {}
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
