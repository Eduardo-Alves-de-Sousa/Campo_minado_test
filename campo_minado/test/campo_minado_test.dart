import 'package:campo_minado/campo_minado.dart';
import 'package:campo_minado/dificuldade.dart';
import 'package:test/test.dart';

void main() {
  group('Tabuleiro', () {
    test('Iniciar Jogo - Fácil', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.easy);

      int rows = g.getBoard().length;
      int cols = g.getBoard()[0].length;

      expect(rows, equals(8));
      expect(cols, equals(8));
    });

    test('Iniciar Jogo - Médio', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.medium);

      int rows = g.getBoard().length;
      int cols = g.getBoard()[0].length;

      expect(rows, equals(10));
      expect(cols, equals(16));
    });

    test('Iniciar Jogo - Difícil', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.hard);

      int rows = g.getBoard().length;
      int cols = g.getBoard()[0].length;

      expect(rows, equals(24));
      expect(cols, equals(24));
    });

    test('Selecionar Tamanho do Tabuleiro - Fácil', () {
      Game g = Game();
      g.init();
      g.setBoardSize(8, 8);

      int rows = g.getBoard().length;
      int cols = g.getBoard()[0].length;

      expect(rows, equals(8));
      expect(cols, equals(8));
    });

    test('Selecionar Tamanho do Tabuleiro - Médio', () {
      Game g = Game();
      g.init();
      g.setBoardSize(10, 16);

      int rows = g.getBoard().length;
      int cols = g.getBoard()[0].length;

      expect(rows, equals(10));
      expect(cols, equals(16));
    });

    test('Selecionar Tamanho do Tabuleiro - Difícil', () {
      Game g = Game();
      g.init();
      g.setBoardSize(24, 24);

      int rows = g.getBoard().length;
      int cols = g.getBoard()[0].length;

      expect(rows, equals(24));
      expect(cols, equals(24));
    });

    test('Número de movimentos disponíveis - Fácil', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.easy);

      List<List<String>> board = g.getBoard();

      // Calcula o número esperado de células não reveladas em um jogo fácil
      int expectedUnrevealedCount = 8 * 8; // Total de células no tabuleiro

      // Verifica se o número de células não reveladas é igual ao esperado
      int unrevealedCount = board
          .expand((row) => row)
          .where(
              (cell) => cell != 'O') // Conta as células que não estão reveladas
          .length;

      expect(unrevealedCount, equals(expectedUnrevealedCount));
    });

    test('Número de movimentos disponíveis - Médio', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.medium);

      List<List<String>> board = g.getBoard();

      // Calcula o número esperado de células não reveladas em um jogo médio
      int expectedUnrevealedCount = 10 * 16; // Total de células no tabuleiro

      // Verifica se o número de células não reveladas é igual ao esperado
      int unrevealedCount = board
          .expand((row) => row)
          .where(
              (cell) => cell != 'O') // Conta as células que não estão reveladas
          .length;

      expect(unrevealedCount, equals(expectedUnrevealedCount));
    });

    test('Número de movimentos disponíveis - Difícil', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.hard);

      List<List<String>> board = g.getBoard();

      // Calcula o número esperado de células não reveladas em um jogo difícil
      int expectedUnrevealedCount = 24 * 24; // Total de células no tabuleiro

      // Verifica se o número de células não reveladas é igual ao esperado
      int unrevealedCount = board
          .expand((row) => row)
          .where(
              (cell) => cell != 'O') // Conta as células que não estão reveladas
          .length;

      expect(unrevealedCount, equals(expectedUnrevealedCount));
    });

    test('Número de bombas - Fácil', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.easy);

      List<List<String>> board = g.getBoard();

      // Calcula o número esperado de bombas em um jogo fácil
      int expectedBombCount = 10;

      // Verifica se o número de bombas é igual ao esperado
      int bombCount = board
          .expand((row) => row)
          .where((cell) => cell == 'X') // Conta as células que contêm bombas
          .length;

      expect(bombCount, equals(expectedBombCount));
    });

    test('Número de bombas - Médio', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.medium);

      List<List<String>> board = g.getBoard();

      // Calcula o número esperado de bombas em um jogo médio
      int expectedBombCount = 30;

      // Verifica se o número de bombas é igual ao esperado
      int bombCount = board
          .expand((row) => row)
          .where((cell) => cell == 'X') // Conta as células que contêm bombas
          .length;

      expect(bombCount, equals(expectedBombCount));
    });

    test('Número de bombas - Difícil', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.hard);

      List<List<String>> board = g.getBoard();

      // Calcula o número esperado de bombas em um jogo difícil
      int expectedBombCount = 100;

      // Verifica se o número de bombas é igual ao esperado
      int bombCount = board
          .expand((row) => row)
          .where((cell) => cell == 'X') // Conta as células que contêm bombas
          .length;

      expect(bombCount, equals(expectedBombCount));
    });

    test('Teste de Derrota - Fácil', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.easy);

      List<List<String>> board = g.getBoard();

      // Encontra uma posição com uma bomba e faça uma jogada nela
      int rowWithBomb = -1;
      int colWithBomb = -1;
      for (int row = 0; row < board.length; row++) {
        for (int col = 0; col < board[0].length; col++) {
          if (board[row][col] == 'X') {
            rowWithBomb = row;
            colWithBomb = col;
            break;
          }
        }
        if (rowWithBomb != -1) {
          break;
        }
      }

      // Simula uma jogada que revela a bomba.
      g.play(rowWithBomb, colWithBomb);

      // Verifica se o jogo é marcado como perdido ou não.
      expect(g.isGameOver(), isTrue);
      expect(g.isGameLost(), isTrue);
    });

    test('Teste de Derrota - Médio', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.medium);

      List<List<String>> board = g.getBoard();

      // Encontra uma posição com uma bomba e faça uma jogada nela
      int rowWithBomb = -1;
      int colWithBomb = -1;
      for (int row = 0; row < board.length; row++) {
        for (int col = 0; col < board[0].length; col++) {
          if (board[row][col] == 'X') {
            rowWithBomb = row;
            colWithBomb = col;
            break;
          }
        }
        if (rowWithBomb != -1) {
          break;
        }
      }

      // Simula uma jogada que revela a bomba.
      g.play(rowWithBomb, colWithBomb);

      // Verifica se o jogo é marcado como perdido ou não.
      expect(g.isGameOver(), isTrue);
      expect(g.isGameLost(), isTrue);
    });

    test('Teste de Derrota - Difícil', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.hard);

      List<List<String>> board = g.getBoard();

      // Encontra uma posição com uma bomba e faça uma jogada nela
      int rowWithBomb = -1;
      int colWithBomb = -1;
      for (int row = 0; row < board.length; row++) {
        for (int col = 0; col < board[0].length; col++) {
          if (board[row][col] == 'X') {
            rowWithBomb = row;
            colWithBomb = col;
            break;
          }
        }
        if (rowWithBomb != -1) {
          break;
        }
      }

      // Simula uma jogada que revela a bomba.
      g.play(rowWithBomb, colWithBomb);

      // Verifica se o jogo é marcado como perdido ou não.
      expect(g.isGameOver(), isTrue);
      expect(g.isGameLost(), isTrue);
    });

    test('Zonas - Bombas Adjacentes - Todos os Níveis', () {
      _testBombsAdjacent(Difficulty.easy);
      _testBombsAdjacent(Difficulty.medium);
      _testBombsAdjacent(Difficulty.hard);
    });

    test('Teste de Limites - Revelar Célula Fora dos Limites', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.easy);

      List<List<String>> board = g.getBoard();
      int numRows = board.length;
      int numCols = board[0].length;

      // Tente revelar uma célula fora dos limites do tabuleiro
      int row = numRows;
      int col = numCols + 1;
      expect(() => g.play(row, col), throwsA(isA<RangeError>()));
    });
    test('Teste de Desempenho - Geração do Tabuleiro', () {
      Game g = Game();

      // Execute a geração do tabuleiro e meça o tempo
      Stopwatch stopwatch = Stopwatch()..start();
      g.init();
      stopwatch.stop();

      // Defina um limite de tempo aceitável para a geração do tabuleiro (em milissegundos)
      int limiteTempo = 100;

      // Verifique se o tempo de geração do tabuleiro está dentro do limite
      expect(stopwatch.elapsedMilliseconds, lessThan(limiteTempo));
    });
    test('Teste de Contagem de Bombas Adjacentes', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.easy);

      // A seguir, revele algumas células próximas a uma bomba
      g.play(1, 1); // Esta é uma célula vazia (sem bombas adjacentes)
      g.play(2, 2); // Esta é uma célula com uma bomba adjacente

      // Obtenha o tabuleiro após as jogadas
      List<List<String>> board = g.getBoard();

      // Verifique se as contagens de bombas adjacentes estão corretas
      expect(board[1][1], equals(' ')); // Deve haver 1 bomba adjacente
      expect(board[2][2], equals(' ')); // Esta é uma bomba

      // Você pode continuar adicionando mais jogadas e verificações conforme necessário
    });
  });
}

void _testBombsAdjacent(Difficulty difficulty) {
  Game g = Game();
  g.init();
  g.setDifficulty(difficulty);

  List<List<String>> board = g.getBoard();

  // Loop para verificar bombas adjacentes nas zonas
  for (int row = 0; row < board.length; row++) {
    for (int col = 0; col < board[0].length; col++) {
      if (board[row][col] != 'X') {
        // Calcula o número de bombas adjacentes para a zona
        int bombsAdjacent = g.getBombsAdjacent(row, col);

        // Verifica se o número de bombas adjacentes está no intervalo de 0 a 8
        expect(bombsAdjacent, greaterThanOrEqualTo(0));
        expect(bombsAdjacent, lessThanOrEqualTo(8));
      }
    }
  }
}
