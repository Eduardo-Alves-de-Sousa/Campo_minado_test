import 'dart:math';
import 'package:campo_minado/dificuldade.dart';
import 'package:campo_minado/excepition/campo_minado_exceptions.dart';

class Game {
  // Representa o tabuleiro do jogo
  List<List<String>> _board = [];

  // Dificuldade atual do jogo
  Difficulty _currentDifficulty = Difficulty.easy;

  // Tamanho personalizado do tabuleiro (linhas e colunas)
  int _customBoardRows = 0;
  int _customBoardCols = 0;

  // Flags (bandeiras) colocadas no tabuleiro
  int _numFlags = 0;

  // Status do jogo
  bool _gameOver = false;
  // ignore: prefer_final_fields
  bool _gameLost = false;

  // Inicializa o jogo com as configurações padrão
  void init() {
    _generateBoard();
  }

  // Gera o tabuleiro com base na dificuldade atual
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

  // Calcula o número de bombas com base na dificuldade atual
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

  // Coloca bombas aleatoriamente no tabuleiro
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

  // Retorna o tabuleiro atual
  List<List<String>> getBoard() {
    return _board;
  }

  // Define a dificuldade do jogo
  void setDifficulty(Difficulty difficulty) {
    _currentDifficulty = difficulty;
    _generateBoard();
  }

  // Define o tamanho personalizado do tabuleiro
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

  // Realiza um movimento no jogo
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

  // Verifica se o jogo terminou
  bool isGameOver() {
    return _gameOver;
  }

  // Verifica se o jogo foi perdido
  bool isGameLost() {
    return _gameLost;
  }

  // Calcula o número máximo de bandeiras que podem ser colocadas
  int _calculateMaxFlags() {
    int bombCount = _calculateNumBombs();
    return bombCount;
  }

  // Coloca ou remove uma bandeira em uma célula
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

  // Calcula o número de bombas adjacentes a uma célula
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

  // Retorna o status de uma célula (X para bomba, F para bandeira, espaço vazio)
  String getCellStatus(int row, col) {
    if (_gameLost && _board[row][col] == 'X') {
      return 'X';
    } else {
      return _board[row][col];
    }
  }

  // Retorna a dificuldade atual do jogo
  Difficulty getDifficulty() {
    return _currentDifficulty;
  }

  // Retorna o valor de uma célula nas coordenadas fornecidas
  String getCellValue(int i, j) {
    if (i < 0 || i >= _board.length || j < 0 || j >= _board[0].length) {
      return '';
    }

    return _board[i][j];
  }
}
