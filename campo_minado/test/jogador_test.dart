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

    test('Limite de Bandeiras', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que o limite de bandeiras seja definido para um cenário específico.
      int limiteDeBandeiras = 10;

      // Marcar o limite de bandeiras permitido
      for (int i = 0; i < limiteDeBandeiras; i++) {
        jogador.marcarComBandeira(i, i);
      }

      // Tente marcar uma bandeira adicional além do limite
      int linhaExcedente = limiteDeBandeiras + 1;
      int colunaExcedente = limiteDeBandeiras + 1;
      jogador.marcarComBandeira(linhaExcedente, colunaExcedente);

      // Verificar se a zona excedente não está marcada com uma bandeira
      expect(jogador.temBandeira(linhaExcedente, colunaExcedente), isFalse);
    });
    test('Marcação de Zona Incorreta', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que o tamanho do tabuleiro seja 8x8
      int tamanhoDoTabuleiro = 8;

      // Tente marcar uma zona fora dos limites do tabuleiro
      int linhaForaDosLimites = tamanhoDoTabuleiro + 1;
      int colunaForaDosLimites = tamanhoDoTabuleiro + 1;
      jogador.marcarComBandeira(linhaForaDosLimites, colunaForaDosLimites);

      // Verificar se a zona fora dos limites não está marcada com uma bandeira
      expect(jogador.temBandeira(linhaForaDosLimites, colunaForaDosLimites),
          isFalse);
    });

    test('Verificação de Vitória com Bandeiras', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // ignore: unused_local_variable
      int bombasNoTabuleiro = 0;
      for (int linha = 0; linha < jogador.getBoard().length; linha++) {
        for (int coluna = 0; coluna < jogador.getBoard()[0].length; coluna++) {
          if (jogador.getBoard()[linha][coluna] == 'X') {
            bombasNoTabuleiro++;
          }
        }
      }

      for (int linha = 0; linha < jogador.getBoard().length; linha++) {
        for (int coluna = 0; coluna < jogador.getBoard()[0].length; coluna++) {
          jogador.marcarComBandeira(linha, coluna);
        }
      }

      expect(jogador.isGameWon(), isTrue);
    });
    test('Ação Dupla com Clique Direito', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isTrue);

      // Tentar alternar a marcação com um clique direito
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a bandeira foi removida
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });
  });
}
