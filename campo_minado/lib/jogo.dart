import 'dart:io';
import 'dart:math';

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
    if (_gameOver) return;
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
    if (_gameOver) return;
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

void main() {
  print("|-----------------------------------------------------------|");
  print('|Bem-vindo ao Campo Minado! Escolha um nível de dificuldade:|');
  print("|-----------------------------------------------------------|");

  print('\n1 - Fácil (8x8, 10 bombas)');
  print('2 - Médio (10x16, 30 bombas)');
  print('3 - Difícil (24x24, 100 bombas)');
  print('4 - Personalizado');
  print('5 - Ver Tempos de Jogo');
  print('6 - Sair\n');

  int choice;
  while (true) {
    stdout.write("Escolha uma opção: ");
    choice = int.tryParse(stdin.readLineSync() ?? '')!;
    // ignore: unnecessary_null_comparison
    if (choice != null && choice >= 1 && choice <= 6) {
      break; // A escolha é válida, saia do loop
    }
    print("Escolha uma opção válida (1 a 6)!");
  }

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
    stdout.write("Escolha uma opção: ");
    numBombs = int.parse(stdin.readLineSync()!);
  } else if (choice == 5) {
    // Opção para visualizar tempos de jogo
    print('Tempos de Jogo Registrados:');
    _viewGameTimes();
    return;
  } else if (choice == 6) {
    print('Você saiu do jogo.');
    return;
  }

  final game = Game();
  game.init(rows, cols, numBombs);

  // Declare e inicie o cronômetro
  final stopwatch = Stopwatch()..start();

  while (!game.isGameOver()) {
    print('Tabuleiro:');
    game.printBoard();
    print('\nEscolha uma ação:');
    print('1 - Revelar célula');
    print('2 - Marcar/Desmarcar célula');
    print('3 - Sair\n');
    stdout.write("Escolha uma opção: ");
    int action = int.parse(stdin.readLineSync()!);

    if (action == 3) {
      print('Você saiu do jogo.');
      break;
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

  // Pare o cronômetro quando o jogo terminar (ou quando desejar medir o tempo)
  stopwatch.stop();

  // Obtenha o tempo decorrido em milissegundos
  int tempoEmMilissegundos = stopwatch.elapsedMilliseconds;

  // Converta o tempo para segundos
  double tempoEmSegundos = tempoEmMilissegundos / 1000;

  // Salve o tempo de jogo
  _saveGameTime(tempoEmSegundos);

  // ignore: unnecessary_brace_in_string_interps
  print('Tempo de jogo: ${tempoEmSegundos} segundos');

  print('Jogo terminado!');
  if (game.isGameOver() && !game.isGameLost()) {
    print('Você venceu!');
  } else {
    print('Você perdeu!');
  }
}

// Função para salvar o tempo de jogo em um arquivo
void _saveGameTime(double gameTime) {
  final file = File('game_times.txt');
  if (!file.existsSync()) {
    file.createSync();
  }

  final timeString = '${DateTime.now()}: $gameTime segundos\n';

  file.writeAsStringSync(timeString, mode: FileMode.append);
}

// Função para visualizar tempos de jogo salvos
void _viewGameTimes() {
  final file = File('game_times.txt');
  if (file.existsSync()) {
    final content = file.readAsStringSync();
    print('Tempos de Jogo Registrados:');
    print(content);
  } else {
    print('Nenhum tempo de jogo registrado ainda.');
  }
}
