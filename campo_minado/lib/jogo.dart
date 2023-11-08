import 'dart:io';
import 'dart:math';
import 'package:campo_minado/excepition/jogo_exception.dart';

// Enumeração para representar o estado de uma célula no tabuleiro.
enum CellStatus { unrevealed, revealed, flagged }

class Game {
  late List<List<CellStatus>>
      _board; // Matriz para armazenar o estado de cada célula
  late List<List<bool>> _bombs; // Matriz para indicar a presença de bombas
  int _rows = 0; // Número de linhas no tabuleiro
  int _cols = 0; // Número de colunas no tabuleiro
  int _numBombs = 0; // Número total de bombas no tabuleiro
  bool _gameOver = false; // Indica se o jogo acabou
  bool _gameLost = false; // Indica se o jogador perdeu

  // Inicializa o jogo com o número de linhas, colunas e bombas especificados.
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

  // Coloca as bombas aleatoriamente no tabuleiro.
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

  // Revela uma célula no tabuleiro.
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

  // Revela todas as bombas no tabuleiro.
  void _revealAllBombs() {
    for (int row = 0; row < _rows; row++) {
      for (int col = 0; col < _cols; col++) {
        if (_bombs[row][col]) {
          _board[row][col] = CellStatus.revealed;
        }
      }
    }
  }

  // Conta o número de bombas adjacentes a uma célula.
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

  // Alterna o estado de uma célula entre revelada e marcada com bandeira.
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

  // Verifica se o jogo acabou.
  bool isGameOver() {
    return _gameOver;
  }

  // Verifica se o jogador perdeu o jogo.
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

  // Imprime o tabuleiro no console.
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
