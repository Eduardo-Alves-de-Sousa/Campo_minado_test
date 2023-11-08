import 'dart:math';
import 'package:campo_minado/dificuldade.dart';
import 'package:campo_minado/excepition/campo_minado_exceptions.dart';

class Game {
  List<List<String>> _board = [];
  Difficulty _currentDifficulty = Difficulty.easy;
  int _customBoardRows = 0;
  int _customBoardCols = 0;
  bool _gameOver = false;
  bool _gameLost = false;
  int _numFlags = 0;

  void init() {
    _generateBoard();
  }

  void _generateBoard() {
    if (_currentDifficulty != Difficulty.custom) {
      _board = List.generate(
        _currentDifficulty.boardRows,
        (_) => List.generate(_currentDifficulty.boardCols, (_) => ' '),
      );

      int numBombs = _calculateNumBombs();
      _placeBombs(numBombs);
    } else {
      if (_customBoardRows <= 0 || _customBoardCols <= 0) {
        throw InvalidBoardSizeException(
            'O número de linhas e colunas deve ser maior que zero.');
      }
      _board = List.generate(
        _customBoardRows,
        (_) => List.generate(_customBoardCols, (_) => ' '),
      );
    }
  }

  int _calculateNumBombs() {
    switch (_currentDifficulty) {
      case Difficulty.easy:
        return 10;
      case Difficulty.medium:
        return 30;
      case Difficulty.hard:
        return 100;
      default:
        return 0;
    }
  }

  void _placeBombs(int numBombs) {
    Random random = Random();
    int bombsPlaced = 0;

    while (bombsPlaced < numBombs) {
      int row = random.nextInt(_board.length);
      int col = random.nextInt(_board[0].length);

      if (_board[row][col] != 'X') {
        _board[row][col] = 'X';
        bombsPlaced++;
      }
    }
  }

  List<List<String>> getBoard() {
    return _board;
  }

  void setDifficulty(Difficulty difficulty) {
    _currentDifficulty = difficulty;
    _generateBoard();
  }

  void setBoardSize(int rows, int cols) {
    if (rows <= 0 || cols <= 0) {
      throw InvalidBoardSizeException(
          'O número de linhas e colunas deve ser maior que zero.');
    }
    _currentDifficulty = Difficulty.custom;
    _customBoardRows = rows;
    _customBoardCols = cols;
    _generateBoard();
  }

  void play(int row, int col) {
    if (_gameOver) {
      throw GameOverException(
          'Não é possível jogar depois de um jogo terminado');
    }

    if (_board[row][col] == 'X') {
      _gameOver = true;
      throw GameLostException('O jogo foi perdido');
    }
  }

  bool isGameOver() {
    return _gameOver;
  }

  bool isGameLost() {
    return _gameLost;
  }

  int _calculateMaxFlags() {
    int bombCount = _calculateNumBombs();
    return bombCount;
  }

  void toggleFlag(int row, col) {
    if (_gameOver) {
      return;
    }

    if (_board[row][col] == 'F') {
      _board[row][col] = ' ';
      _numFlags--;
    } else if (_board[row][col] == ' ' && _numFlags < _calculateMaxFlags()) {
      _board[row][col] = 'F';
      _numFlags++;
    }
  }

  int getBombsAdjacent(int row, col) {
    int count = 0;

    final List<int> dr = [-1, -1, -1, 0, 0, 1, 1, 1];
    final List<int> dc = [-1, 0, 1, -1, 1, -1, 0, 1];

    for (int i = 0; i < 8; i++) {
      int newRow = row + dr[i];
      int newCol = col + dc[i];

      if (newRow >= 0 &&
          newRow < _board.length &&
          newCol >= 0 &&
          newCol < _board[0].length) {
        if (_board[newRow][newCol] == 'X') {
          count++;
        }
      }
    }

    return count;
  }

  String getCellStatus(int row, col) {
    if (_gameLost && _board[row][col] == 'X') {
      return 'X';
    } else {
      return _board[row][col];
    }
  }

  Difficulty getDifficulty() {
    return _currentDifficulty;
  }

  String getCellValue(int i, j) {
    if (i < 0 || i >= _board.length || j < 0 || j >= _board[0].length) {
      return '';
    }

    return _board[i][j];
  }
}
