import 'package:test/test.dart';
import 'package:campo_minado/jogador.dart';

void main() {
  group('Jogador', () {
    test('Marcar Zona com Bandeira', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isTrue);
    });
    test('Remover Bandeira', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isTrue);

      // Remover a bandeira da zona
      jogador.removerBandeira(linha, coluna);

      // Verificar se a zona não está mais marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });
  });
}
