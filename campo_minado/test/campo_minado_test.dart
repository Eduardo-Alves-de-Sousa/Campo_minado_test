import 'package:campo_minado/campo_minado.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(calculate(), 42);
  });
}
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

      // // Obtém o número esperado de linhas e colunas com base na dificuldade fácil
      // int expectedRows = Difficulty.easy.boardRows;
      // int expectedCols = Difficulty.easy.boardCols;

      // // Verifica se o número de linhas é igual ao esperado
      // expect(rows, equals(expectedRows));
      // // Verifica se o número de colunas é igual ao esperado
      // expect(cols, equals(expectedCols));
    });