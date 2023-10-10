import 'package:campo_minado/campo_minado.dart';
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

    test('Jogo não encerrado no início - Fácil', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.easy);

      List<List<String>> board = g.getBoard();

      // Verifica se nenhum campo é uma mina ('X') e nenhum campo está revelado ('O')
      expect(
          board.every((row) => row.every((cell) => cell != 'X' && cell != 'O')),
          isTrue);
    });

    test('Jogo não encerrado no início - Médio', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.medium);

      List<List<String>> board = g.getBoard();

      // Verifica se nenhum campo é uma mina ('X') e nenhum campo está revelado ('O')
      expect(
          board.every((row) => row.every((cell) => cell != 'X' && cell != 'O')),
          isTrue);
    });

    test('Jogo não encerrado no início - Difícil', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.hard);

      List<List<String>> board = g.getBoard();

      // Verifica se nenhum campo é uma mina ('X') e nenhum campo está revelado ('O')
      expect(
          board.every((row) => row.every((cell) => cell != 'X' && cell != 'O')),
          isTrue);
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
  });
}
