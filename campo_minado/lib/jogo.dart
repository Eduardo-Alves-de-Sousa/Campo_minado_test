import 'dart:io';
import 'dart:math';

// Enum que representa os diferentes estados de cada célula no tabuleiro
enum CellStatus { unrevealed, revealed, flagged }

class Game {
  late List<List<CellStatus>> _board; // Matriz de estados das células
  late List<List<bool>> _bombs; // Matriz para rastrear a localização das bombas
  int _rows = 0; // Número de linhas no tabuleiro
  int _cols = 0; // Número de colunas no tabuleiro
  int _numBombs = 0; // Número total de bombas no tabuleiro
  bool _gameOver = false; // Flag para rastrear o estado do jogo

  // Inicializa o jogo com o número de linhas, colunas e bombas especificado
  void init(int rows, int cols, int numBombs) {
    _rows = rows;
    _cols = cols;
    _numBombs = numBombs;
    _board =
        List.generate(rows, (_) => List.filled(cols, CellStatus.unrevealed));
    _bombs = List.generate(rows, (_) => List.filled(cols, false));
    _placeBombs(); // Coloca as bombas aleatoriamente no tabuleiro
  }

  // Coloca bombas aleatoriamente no tabuleiro
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

  // Revela uma célula no tabuleiro
  void revealCell(int row, int col) {
    if (_gameOver) return;

    if (_board[row][col] == CellStatus.flagged) return;

    if (_bombs[row][col]) {
      _gameOver = true;
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

  // Conta o número de bombas adjacentes a uma célula
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

  // Marca ou desmarca uma célula no tabuleiro
  void toggleFlag(int row, int col) {
    if (_gameOver) return;

    if (_board[row][col] == CellStatus.unrevealed) {
      _board[row][col] = CellStatus.flagged;
    } else if (_board[row][col] == CellStatus.flagged) {
      _board[row][col] = CellStatus.unrevealed;
    }
  }

  // Verifica se o jogo terminou (vitória ou derrota)
  bool isGameOver() {
    return _gameOver;
  }

  // Imprime o tabuleiro no terminal
  void printBoard() {
    for (int row = 0; row < _rows; row++) {
      for (int col = 0; col < _cols; col++) {
        switch (_board[row][col]) {
          case CellStatus.unrevealed:
            stdout.write(' '); // Célula não revelada
            break;
          case CellStatus.flagged:
            stdout.write('F'); // Célula marcada com bandeira
            break;
          case CellStatus.revealed:
            int bombsAdjacent = _countBombsAdjacent(row, col);
            if (bombsAdjacent == 0) {
              stdout.write(' '); // Célula revelada sem bombas adjacentes
            } else {
              stdout.write(
                  bombsAdjacent.toString()); // Número de bombas adjacentes
            }
            break;
        }
        stdout.write(' | ');
      }
      stdout.writeln();
    }
  }

  // Verifica se o jogo foi perdido
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
}

void main() {
  print('Bem-vindo ao Campo Minado! Escolha um nível de dificuldade:');
  print('1 - Fácil (8x8, 10 bombas)');
  print('2 - Médio (10x16, 30 bombas)');
  print('3 - Difícil (24x24, 100 bombas)');
  print('4 - Personalizado');
  print('5 - Sair'); // Adicionamos a opção de sair

  int choice = int.parse(stdin.readLineSync()!);
  int rows = 0;
  int cols = 0;
  int numBombs = 0;

  if (choice == 1) {
    rows = 8;
    cols = 8;
    numBombs = 10;
  } else if (choice == 2) {
    rows = 10;
    cols = 16;
    numBombs = 30;
  } else if (choice == 3) {
    rows = 24;
    cols = 24;
    numBombs = 100;
  } else if (choice == 4) {
    print('Digite o número de linhas: ');
    rows = int.parse(stdin.readLineSync()!);
    print('Digite o número de colunas: ');
    cols = int.parse(stdin.readLineSync()!);
    print('Digite o número de bombas: ');
    numBombs = int.parse(stdin.readLineSync()!);
  } else if (choice == 5) {
    print('Você saiu do jogo.');
    return; // Se a opção for sair, encerra o programa
  }

  final game = Game();
  game.init(rows, cols, numBombs);

  while (!game.isGameOver()) {
    print('Tabuleiro:');
    game.printBoard();
    print('Escolha uma ação:');
    print('1 - Revelar célula');
    print('2 - Marcar/Desmarcar célula');
    print('3 - Sair'); // Adicionamos a opção de sair
    int action = int.parse(stdin.readLineSync()!);

    if (action == 3) {
      print('Você saiu do jogo.');
      break; // Se a opção for sair, encerra o loop
    }

    print('Digite a linha (0 a ${rows - 1}): ');
    int row = int.parse(stdin.readLineSync()!);
    print('Digite a coluna (0 a ${cols - 1}): ');
    int col = int.parse(stdin.readLineSync()!);

    if (action == 1) {
      game.revealCell(row, col);
    } else if (action == 2) {
      game.toggleFlag(row, col);
    }
  }

  print('Jogo terminado!');
  if (game.isGameOver() && !game.isGameLost()) {
    print('Você venceu!');
  } else {
    print('Você perdeu!');
  }
}
