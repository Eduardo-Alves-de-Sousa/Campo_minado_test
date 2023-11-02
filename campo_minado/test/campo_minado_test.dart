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

    test('Verificar que o nível padrão é Fácil', () {
      Game g = Game();
      g.init();

      // Verifica se o nível padrão é "Fácil"
      expect(g.getDifficulty(), equals(Difficulty.easy));
    });

    test('Verificar que o nível não é Fácil quando definido como Médio', () {
      Game g = Game();
      g.init();

      // Define o nível do jogo como "Médio"
      g.setDifficulty(Difficulty.medium);

      // Verifica se o nível não é "Fácil"
      expect(g.getDifficulty(), isNot(equals(Difficulty.easy)));
    });

    test('Verificar que o nível não é Fácil quando definido como Difícil', () {
      Game g = Game();
      g.init();

      // Define o nível do jogo como "Difícil"
      g.setDifficulty(Difficulty.hard);

      // Verifica se o nível não é "Fácil"
      expect(g.getDifficulty(), isNot(equals(Difficulty.easy)));
    });

    test('Verificar que o nível é Difícil quando definido como Difícil', () {
      Game g = Game();
      g.init();

      // Define o nível do jogo como "Difícil"
      g.setDifficulty(Difficulty.hard);

      // Verifica se o nível é "Difícil"
      expect(g.getDifficulty(), equals(Difficulty.hard));
    });

    test('Verificar que o nível é Médio quando definido como Médio', () {
      Game g = Game();
      g.init();

      // Define o nível do jogo como "Médio"
      g.setDifficulty(Difficulty.medium);

      // Verifica se o nível é "Médio"
      expect(g.getDifficulty(), equals(Difficulty.medium));
    });

    test('Verificar que o nível não é Médio quando definido como Fácil', () {
      Game g = Game();
      g.init();

      // Define o nível do jogo como "Fácil"
      g.setDifficulty(Difficulty.easy);

      // Verifica se o nível não é "Médio"
      expect(g.getDifficulty(), isNot(equals(Difficulty.medium)));
    });

    test('Verificar que o nível não é Médio quando definido como Difícil', () {
      Game g = Game();
      g.init();

      // Define o nível do jogo como "Difícil"
      g.setDifficulty(Difficulty.hard);

      // Verifica se o nível não é "Médio"
      expect(g.getDifficulty(), isNot(equals(Difficulty.medium)));
    });

    test('Verificar que o nível é Difícil quando definido como Difícil', () {
      Game g = Game();
      g.init();

      // Define o nível do jogo como "Difícil"
      g.setDifficulty(Difficulty.hard);

      // Verifica se o nível é "Difícil"
      expect(g.getDifficulty(), equals(Difficulty.hard));
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

    test('Teste de Limites - Revelar Célula Fora dos Limites (Médio)', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.medium);

      List<List<String>> board = g.getBoard();
      int numRows = board.length;
      int numCols = board[0].length;

      // Tente revelar uma célula fora dos limites do tabuleiro
      int row = numRows;
      int col = numCols + 1;
      expect(() => g.play(row, col), throwsA(isA<RangeError>()));
    });

    test('Teste de Limites - Revelar Célula Fora dos Limites (Difícil)', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.hard);

      List<List<String>> board = g.getBoard();
      int numRows = board.length;
      int numCols = board[0].length;

      // Tente revelar uma célula fora dos limites do tabuleiro
      int row = numRows;
      int col = numCols + 1;
      expect(() => g.play(row, col), throwsA(isA<RangeError>()));
    });

    test('Adicionar Bombas Aleatoriamente - Fácil', () {
      Game g = Game();
      g.setDifficulty(Difficulty.easy);

      g.init();

      List<List<String>> board = g.getBoard();
      int bombCount = 0;

      for (int row = 0; row < board.length; row++) {
        for (int col = 0; col < board[0].length; col++) {
          if (board[row][col] == 'X') {
            bombCount++;
          }
        }
      }

      int expectedBombCount = 10; // Número esperado de bombas no nível fácil

      expect(bombCount, equals(expectedBombCount));
    });
    test('Adicionar Bombas Aleatoriamente - Médio', () {
      Game g = Game();
      g.setDifficulty(Difficulty.medium);

      g.init();

      List<List<String>> board = g.getBoard();
      int bombCount = 0;

      for (int row = 0; row < board.length; row++) {
        for (int col = 0; col < board[0].length; col++) {
          if (board[row][col] == 'X') {
            bombCount++;
          }
        }
      }

      int expectedBombCount = 30; // Número esperado de bombas no nível médio

      expect(bombCount, equals(expectedBombCount));
    });

    test('Adicionar Bombas Aleatoriamente - Difícil', () {
      Game g = Game();
      g.setDifficulty(Difficulty.hard);

      g.init();

      List<List<String>> board = g.getBoard();
      int bombCount = 0;

      for (int row = 0; row < board.length; row++) {
        for (int col = 0; col < board[0].length; col++) {
          if (board[row][col] == 'X') {
            bombCount++;
          }
        }
      }

      int expectedBombCount = 100; // Número esperado de bombas no nível difícil

      expect(bombCount, equals(expectedBombCount));
    });
    test('Teste de Exibição de Bombas Após a Derrota', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.easy);

      List<List<String>> board = g.getBoard();

      // Encontra uma posição com uma bomba e faça uma jogada que revele a bomba
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

      // Simula uma jogada que revela a bomba e perde o jogo.
      g.play(rowWithBomb, colWithBomb);

      // Verifica se o jogo é marcado como perdido
      expect(g.isGameLost(), isTrue);

      // Verifica se as bombas são exibidas corretamente após a derrota
      for (int row = 0; row < board.length; row++) {
        for (int col = 0; col < board[0].length; col++) {
          if (board[row][col] == 'X') {
            // Verifica se as bombas são exibidas após a derrota
            expect(g.getCellStatus(row, col), equals('X'));
          }
        }
      }
    });

    group('Testes para o nível Fácil', () {
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
            .where((cell) =>
                cell != 'O') // Conta as células que não estão reveladas
            .length;

        expect(unrevealedCount, equals(expectedUnrevealedCount));
      });

      test('Células com bomba - Nível Fácil', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.easy);

        List<List<String>> board = g.getBoard();

        // Verifica se o número de células com bombas corresponde à dificuldade
        int bombsCount = board
            .expand((row) => row)
            .where((cell) => cell == 'X') // Conta as células com bombas
            .length;

        expect(bombsCount, equals(10)); // Dificuldade Fácil tem 10 bombas
      });

      test('Coordenadas válidas - Nível Fácil', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.easy);

        int numRows = g.getBoard().length;
        int numCols = g.getBoard()[0].length;

        // Testa se as coordenadas estão dentro dos limites do tabuleiro
        expect(g.getCellValue(-1, 0), equals(''));
        expect(g.getCellValue(numRows, 0), equals(''));
        expect(g.getCellValue(0, -1), equals(''));
        expect(g.getCellValue(0, numCols), equals(''));
        expect(g.getCellValue(numRows - 1, numCols - 1), isNot(equals('')));
      });

      test('Jogar todas as células sem bombas no nível fácil', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.easy);
        List<List<String>> board = g.getBoard();

        for (int row = 0; row < 8; row++) {
          for (int col = 0; col < 8; col++) {
            if (board[row][col] != 'X') {
              g.play(row, col); // Revela a célula
              expect(
                  g.getCellStatus(row, col), equals(g.getCellValue(row, col)));
            }
          }
        }

        expect(g.isGameOver(), isFalse);
        expect(g.isGameLost(), isFalse);
      });
      test('Revelar todas as bombas - Nível Fácil', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.easy);
        List<List<String>> board = g.getBoard();

        // Revelar todas as bombas
        for (int row = 0; row < 8; row++) {
          for (int col = 0; col < 8; col++) {
            if (board[row][col] == 'X') {
              g.play(row, col); // Revela a bomba
            }
          }
        }

        expect(g.isGameOver(), isTrue);
        expect(g.isGameLost(), isTrue);
      });

      test('Jogar todas as células com bombas no nível fácil', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.easy);
        List<List<String>> board = g.getBoard();

        for (int row = 0; row < 8; row++) {
          for (int col = 0; col < 8; col++) {
            if (board[row][col] == 'X') {
              g.play(row, col); // Revela a célula com bomba
            }
          }
        }

        expect(g.isGameOver(), isTrue);
        expect(g.isGameLost(), isTrue);
      });

      test('Verificar que o jogo não inicia com a derrota no nível fácil', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.easy);

        expect(g.isGameLost(), isFalse);
      });
    });
    group('Testes para o nível Médio', () {
      test('Células com bomba - Nível Médio', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.medium);

        List<List<String>> board = g.getBoard();

        // Verifica se o número de células com bombas corresponde à dificuldade
        int bombsCount = board
            .expand((row) => row)
            .where((cell) => cell == 'X') // Conta as células com bombas
            .length;

        expect(bombsCount, equals(30)); // Dificuldade Médio tem 30 bombas
      });

      test('Coordenadas válidas - Nível Médio', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.medium);

        int numRows = g.getBoard().length;
        int numCols = g.getBoard()[0].length;

        // Testa se as coordenadas estão dentro dos limites do tabuleiro
        expect(g.getCellValue(-1, 0), equals(''));
        expect(g.getCellValue(numRows, 0), equals(''));
        expect(g.getCellValue(0, -1), equals(''));
        expect(g.getCellValue(0, numCols), equals(''));
        expect(g.getCellValue(numRows - 1, numCols - 1), isNot(equals('')));
      });
      test('Jogar todas as células sem bombas no nível médio', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.medium);
        List<List<String>> board = g.getBoard();

        for (int row = 0; row < board.length; row++) {
          for (int col = 0; col < board[0].length; col++) {
            if (board[row][col] != 'X') {
              g.play(row, col); // Revela a célula
              expect(
                  g.getCellStatus(row, col), equals(g.getCellValue(row, col)));
            }
          }
        }

        expect(g.isGameOver(), isFalse);
        expect(g.isGameLost(), isFalse);
      });
      test('Verificar que o jogo não inicia com a derrota no nível médio', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.medium);

        expect(g.isGameLost(), isFalse);
      });
      test('Teste de Exibição de Bombas Após a Derrota - Nível Médio', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.medium);

        List<List<String>> board = g.getBoard();

        // Encontra uma posição com uma bomba e faça uma jogada que revele a bomba
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

        // Simula uma jogada que revela a bomba e perde o jogo.
        g.play(rowWithBomb, colWithBomb);

        // Verifica se o jogo é marcado como perdido
        expect(g.isGameLost(), isTrue);

        // Verifica se as bombas são exibidas corretamente após a derrota
        for (int row = 0; row < board.length; row++) {
          for (int col = 0; col < board[0].length; col++) {
            if (board[row][col] == 'X') {
              // Verifica se as bombas são exibidas após a derrota
              expect(g.getCellStatus(row, col), equals('X'));
            }
          }
        }
      });
    });

    group('Testes para o nível Difícil', () {
      test('Células com bomba - Nível Difícil', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.hard);

        List<List<String>> board = g.getBoard();

        // Verifica se o número de células com bombas corresponde à dificuldade
        int bombsCount = board
            .expand((row) => row)
            .where((cell) => cell == 'X') // Conta as células com bombas
            .length;

        expect(bombsCount, equals(100)); // Dificuldade Difícil tem 100 bombas
      });

      test('Coordenadas válidas - Nível Difícil', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.hard);

        int numRows = g.getBoard().length;
        int numCols = g.getBoard()[0].length;

        // Testa se as coordenadas estão dentro dos limites do tabuleiro
        expect(g.getCellValue(-1, 0), equals(''));
        expect(g.getCellValue(numRows, 0), equals(''));
        expect(g.getCellValue(0, -1), equals(''));
        expect(g.getCellValue(0, numCols), equals(''));
        expect(g.getCellValue(numRows - 1, numCols - 1), isNot(equals('')));
      });
      test('Jogar todas as células sem bombas no nível difícil', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.hard);
        List<List<String>> board = g.getBoard();

        for (int row = 0; row < board.length; row++) {
          for (int col = 0; col < board[0].length; col++) {
            if (board[row][col] != 'X') {
              g.play(row, col); // Revela a célula
              expect(
                  g.getCellStatus(row, col), equals(g.getCellValue(row, col)));
            }
          }
        }

        expect(g.isGameOver(), isFalse);
        expect(g.isGameLost(), isFalse);
      });
      test('Verificar que o jogo não inicia com a derrota no nível fácil', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.hard);

        expect(g.isGameLost(), isFalse);
      });
      test('Teste de Exibição de Bombas Após a Derrota - Nível Difícil', () {
        Game g = Game();
        g.init();
        g.setDifficulty(Difficulty.hard);

        List<List<String>> board = g.getBoard();

        // Encontra uma posição com uma bomba e faça uma jogada que revele a bomba
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

        // Simula uma jogada que revela a bomba e perde o jogo.
        g.play(rowWithBomb, colWithBomb);

        // Verifica se o jogo é marcado como perdido
        expect(g.isGameLost(), isTrue);

        // Verifica se as bombas são exibidas corretamente após a derrota
        for (int row = 0; row < board.length; row++) {
          for (int col = 0; col < board[0].length; col++) {
            if (board[row][col] == 'X') {
              // Verifica se as bombas são exibidas após a derrota
              expect(g.getCellStatus(row, col), equals('X'));
            }
          }
        }
      });
    });
    group('Teste de Desempenho - Geração do Tabuleiro', () {
      test('Geração do Tabuleiro - Fácil', () {
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

      test('Geração do Tabuleiro - Médio', () {
        Game g = Game();

        // Execute a geração do tabuleiro e meça o tempo
        Stopwatch stopwatch = Stopwatch()..start();
        g.init();
        stopwatch.stop();

        // Defina um limite de tempo aceitável para a geração do tabuleiro (em milissegundos)
        int limiteTempo = 200;

        // Verifique se o tempo de geração do tabuleiro está dentro do limite
        expect(stopwatch.elapsedMilliseconds, lessThan(limiteTempo));
      });

      test('Geração do Tabuleiro - Difícil', () {
        Game g = Game();

        // Execute a geração do tabuleiro e meça o tempo
        Stopwatch stopwatch = Stopwatch()..start();
        g.init();
        stopwatch.stop();

        // Defina um limite de tempo aceitável para a geração do tabuleiro (em milissegundos)
        int limiteTempo = 300;

        // Verifique se o tempo de geração do tabuleiro está dentro do limite
        expect(stopwatch.elapsedMilliseconds, lessThan(limiteTempo));
      });
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
