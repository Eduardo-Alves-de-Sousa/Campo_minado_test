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

    test('O jogo não é encerrado no inicio', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.easy);

      List<List<String>> board = g.getBoard();

      // Verifica se nenhum campo é uma mina e nenhum campo está revelado.
      expect(
          board.every((row) => row.every((cell) => cell != 'X' && cell != 'O')),
          isTrue);
    });
  });
}
