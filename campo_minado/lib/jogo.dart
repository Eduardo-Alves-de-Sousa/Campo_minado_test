import 'dart:io';
import 'dart:math';
import 'package:campo_minado/excepition/jogo_exception.dart';

enum CellStatus { unrevealed, revealed, flagged }

class Game {
  late List<List<CellStatus>> _board;
  late List<List<bool>> _bombs;
  int _rows = 0;
  int _cols = 0;
  int _numBombs = 0;
  bool _gameOver = false;
  bool _gameLost = false;

  void init(int rows, cols, numBombs) {
    if (rows <= 0 || cols <= 0 || numBombs <= 0) {
      throw InvalidInputException(
          'O número de linhas, colunas e bombas deve ser maior que zero.');
    }
    if (numBombs >= rows * cols) {
      throw InvalidInputException(
          'O número de bombas não pode ser maior ou igual ao número de células.');
    }
    _rows = rows;
    _cols = cols;
    _numBombs = numBombs;
    _board =
        List.generate(rows, (_) => List.filled(cols, CellStatus.unrevealed));
    _bombs = List.generate(rows, (_) => List.filled(cols, false));
    _placeBombs();
  }

  void _placeBombs() {
    final random = Random();
    int bombsPlaced = 0;
    while (bombsPlaced < _numBombs) {
      final row = random.nextInt(_rows);
      final col = random.nextInt(_cols);
      if (!_bombs[row][col]) {
        _bombs[row][col] = true;
        bombsPlaced++;
      }
    }
  }

  void revealCell(int row, int col) {
    if (_gameOver) {
      throw GameOverException('O jogo acabou.');
    }
    if (_board[row][col] == CellStatus.flagged) return;
    if (_bombs[row][col]) {
      _gameLost = true;
      _gameOver = true;
      _revealAllBombs();
      return;
    }
    _board[row][col] = CellStatus.revealed;
    int bombsAdjacent = _countBombsAdjacent(row, col);
    if (bombsAdjacent == 0) {
      for (int r = -1; r <= 1; r++) {
        for (int c = -1; c <= 1; c++) {
          if (row + r >= 0 &&
              row + r < _rows &&
              col + c >= 0 &&
              col + c < _cols) {
            if (_board[row + r][col + c] == CellStatus.unrevealed) {
              revealCell(row + r, col + c);
            }
          }
        }
      }
    }
  }

  void _revealAllBombs() {
    for (int row = 0; row < _rows; row++) {
      for (int col = 0; col < _cols; col++) {
        if (_bombs[row][col]) {
          _board[row][col] = CellStatus.revealed;
        }
      }
    }
  }

  int _countBombsAdjacent(int row, int col) {
    int count = 0;
    for (int r = -1; r <= 1; r++) {
      for (int c = -1; c <= 1; c++) {
        if (row + r >= 0 &&
            row + r < _rows &&
            col + c >= 0 &&
            col + c < _cols) {
          if (_bombs[row + r][col + c]) {
            count++;
          }
        }
      }
    }
    return count;
  }

  void toggleFlag(int row, int col) {
    if (_gameOver) {
      return;
    }

    if (_board[row][col] == CellStatus.unrevealed) {
      _board[row][col] = CellStatus.flagged;
    } else if (_board[row][col] == CellStatus.flagged) {
      _board[row][col] = CellStatus.unrevealed;
    }
  }

  bool isGameOver() {
    return _gameOver;
  }

  bool isGameLost() {
    if (_gameOver) {
      for (int row = 0; row < _rows; row++) {
        for (int col = 0; col < _cols; col++) {
          if (_board[row][col] == CellStatus.revealed && _bombs[row][col]) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void printBoard() {
    for (int row = 0; row < _rows; row++) {
      for (int col = 0; col < _cols; col++) {
        if (_gameLost && _bombs[row][col]) {
          stdout.write('B');
        } else {
          switch (_board[row][col]) {
            case CellStatus.unrevealed:
              stdout.write(' ');
              break;
            case CellStatus.flagged:
              stdout.write('F');
              break;
            case CellStatus.revealed:
              int bombsAdjacent = _countBombsAdjacent(row, col);
              if (bombsAdjacent == 0) {
                stdout.write(' ');
              } else {
                stdout.write(bombsAdjacent.toString());
              }
              break;
          }
        }
        stdout.write(' | ');
      }
      stdout.writeln();
    }
  }
}
