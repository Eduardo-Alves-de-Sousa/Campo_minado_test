import 'package:campo_minado/campo_minado.dart';
import 'package:test/test.dart';
// ignore: unused_import
import './campo_minado_test.dart'; // Importa a classe Game do arquivo game.dart

void main() {
  group('Tabuleiro', () {
    // Teste para iniciar o jogo no nível "Fácil"
    test('Iniciar Jogo - Fácil', () {
      // Cria uma instância do jogo
      Game g = Game();

      // Inicializa o jogo
      g.init();
      // Define a dificuldade como fácil
      g.setDifficulty(Difficulty.easy);

      // Obtém o número de linhas e colunas no tabuleiro atual
      int rows = g.getBoard().length;
      int cols = g.getBoard()[0].length;

      // Verifica se o número de linhas e colunas é igual ao esperado para o nível fácil
      expect(rows, equals(8));
      expect(cols, equals(8));
    });

    // Teste para iniciar o jogo no nível "Médio"
    test('Iniciar Jogo - Médio', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.medium); // Define a dificuldade como médio

      // Obtém o número de linhas e colunas no tabuleiro atual
      int rows = g.getBoard().length;
      int cols = g.getBoard()[0].length;

      // Verifica se o número de linhas e colunas é igual ao esperado para o nível médio
      expect(rows, equals(10));
      expect(cols, equals(16));
    });

    // Teste para iniciar o jogo no nível "Difícil"
    test('Iniciar Jogo - Difícil', () {
      Game g = Game();
      g.init();
      g.setDifficulty(Difficulty.hard); // Define a dificuldade como difícil

      int rows = g.getBoard().length;
      int cols = g.getBoard()[0].length;

      // Verifica se o número de linhas e colunas é igual ao esperado para o nível dífício
      expect(rows, equals(24));
      expect(cols, equals(24));
    });

    // Teste para selecionar a dificuldade do jogo
    test('Selecionar Dificuldade do Jogo', () {
      Game g = Game();
      g.init();

      // Define a dificuldade como fácil
      g.setDifficulty(Difficulty.easy);
      expect(g.getBoard().length, equals(8));
      expect(g.getBoard()[0].length, equals(8));

      // Define a dificuldade como Médio
      g.setDifficulty(Difficulty.medium);
      expect(g.getBoard().length, equals(10));
      expect(g.getBoard()[0].length, equals(16));

      // Define a dificuldade como Difício
      g.setDifficulty(Difficulty.hard);
      expect(g.getBoard().length, equals(24));
      expect(g.getBoard()[0].length, equals(24));
    });
  });
}
