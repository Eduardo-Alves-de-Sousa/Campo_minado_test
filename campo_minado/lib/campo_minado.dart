import 'dart:math';

import 'package:campo_minado/dificuldade.dart';

class Game {
  // Propriedade privada para armazenar o tabuleiro do jogo.
  List<List<String>> _board = [];

  // Propriedade privada para armazenar a dificuldade atual do jogo.
  Difficulty _currentDifficulty = Difficulty.easy;

  // Propriedades privadas para o tamanho personalizado do tabuleiro (inicializadas como 0).
  int _customBoardRows = 0;
  int _customBoardCols = 0;

  // Propriedades booleanas para controlar o estado do jogo.
  bool _gameOver = false;
  bool _gameLost = false;

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

  // Função para jogar uma célula
  void play(int row, int col) {
    if (_gameOver) {
      return; // Não é possível jogar depois de um jogo terminado
    }

    if (_board[row][col] == 'X') {
      // Se a célula contém uma bomba, o jogo é perdido
      _gameOver = true;
      _gameLost = true;
    } else {
      // Implemente a lógica para revelar células adjacentes ou marcar a célula jogada
    }
  }

  // Verifica se o jogo está encerrado (ou seja, vitorioso ou derrotado)
  bool isGameOver() {
    return _gameOver;
  }

  // Verifica se o jogo foi perdido
  bool isGameLost() {
    return _gameLost;
  }

  int getBombsAdjacent(int row, int col) {
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

  String getCellStatus(int row, int col) {
    if (_gameLost && _board[row][col] == 'X') {
      return 'X'; // Célula com bomba após a derrota
    } else {
      return _board[row][col]; // Status normal da célula
    }
  }

  Difficulty getDifficulty() {
    return _currentDifficulty;
  }

  String getCellValue(int i, int j) {
    // Verifique se as coordenadas estão dentro dos limites do tabuleiro
    if (i < 0 || i >= _board.length || j < 0 || j >= _board[0].length) {
      return ''; // Fora dos limites do tabuleiro, retornar uma string vazia ou outro valor apropriado
    }

    return _board[i][j];
  }
}
