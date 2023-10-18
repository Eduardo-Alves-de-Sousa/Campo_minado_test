import 'package:campo_minado/dificuldade.dart';
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
    test('Descobrir Zona sem Bandeira', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Garanta que a zona não esteja marcada com bandeira
      jogador.removerBandeira(linha, coluna);

      // Descobrir a zona
      jogador.descobrirZona(linha, coluna);

      // Verificar se a zona está descoberta
      expect(jogador.estaDescoberta(linha, coluna), isTrue);

      // Verificar se o jogo ainda está em andamento (não foi perdido)
      expect(jogador.isGameLost(), isFalse);

      // Verificar se o tabuleiro foi atualizado corretamente (ou seja, sem bombas adjacentes)
      expect(jogador.getBoard()[linha][coluna], isNot(' '));
    });
    test('Não é possível cobrir zona depois de descobri-la', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Descobrir a zona
      jogador.descobrirZona(linha, coluna);

      // Tente marcar a zona com uma bandeira depois de descobri-la
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });

    test('Marcação de Bombas Corretamente - Fácil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.easy);

      int bombasEsperadas = 10; // Número correto de bombas para o nível "Fácil"

      expect(jogador.getBombCount(), equals(bombasEsperadas));
    });

    test('Marcação de Bombas Corretamente - Médio', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.medium);

      int bombasEsperadas = 30; // Número correto de bombas para o nível "Médio"

      expect(jogador.getBombCount(), equals(bombasEsperadas));
    });

    test('Marcação de Bombas Corretamente - Difícil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.hard);

      int bombasEsperadas =
          100; // Número correto de bombas para o nível "Difícil"

      expect(jogador.getBombCount(), equals(bombasEsperadas));
    });

    test('Limite de Bandeiras - Fácil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.easy);

      int limiteDeBandeirasEsperado =
          10; // Limite correto de bandeiras para o nível "Fácil"

      // Marcar o limite de bandeiras permitido
      for (int i = 0; i < limiteDeBandeirasEsperado; i++) {
        jogador.marcarComBandeira(i, i);
      }

      // Tente marcar uma bandeira adicional além do limite
      int linhaExcedente = limiteDeBandeirasEsperado + 1;
      int colunaExcedente = limiteDeBandeirasEsperado + 1;
      jogador.marcarComBandeira(linhaExcedente, colunaExcedente);

      // Verificar se a zona excedente não está marcada com uma bandeira
      expect(jogador.temBandeira(linhaExcedente, colunaExcedente), isFalse);
    });

    test('Limite de Bandeiras - Médio', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.medium);

      int limiteDeBandeirasEsperado =
          30; // Limite correto de bandeiras para o nível "Médio"

      // Marcar o limite de bandeiras permitido
      for (int i = 0; i < limiteDeBandeirasEsperado; i++) {
        jogador.marcarComBandeira(i, i);
      }

      // Tente marcar uma bandeira adicional além do limite
      int linhaExcedente = limiteDeBandeirasEsperado + 1;
      int colunaExcedente = limiteDeBandeirasEsperado + 1;
      jogador.marcarComBandeira(linhaExcedente, colunaExcedente);

      // Verificar se a zona excedente não está marcada com uma bandeira
      expect(jogador.temBandeira(linhaExcedente, colunaExcedente), isFalse);
    });

    test('Limite de Bandeiras - Difícil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.hard);

      int limiteDeBandeirasEsperado =
          100; // Limite correto de bandeiras para o nível "Difícil"

      // Marcar o limite de bandeiras permitido
      for (int i = 0; i < limiteDeBandeirasEsperado; i++) {
        jogador.marcarComBandeira(i, i);
      }

      // Tente marcar uma bandeira adicional além do limite
      int linhaExcedente = limiteDeBandeirasEsperado + 1;
      int colunaExcedente = limiteDeBandeirasEsperado + 1;
      jogador.marcarComBandeira(linhaExcedente, colunaExcedente);

      // Verificar se a zona excedente não está marcada com uma bandeira
      expect(jogador.temBandeira(linhaExcedente, colunaExcedente), isFalse);
    });

    test('Exceder Limite de Bandeiras - Fácil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.easy);

      int limiteDeBandeiras =
          10; // Limite correto de bandeiras para o nível "Fácil"

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

    test('Exceder Limite de Bandeiras - Médio', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.medium);

      int limiteDeBandeiras =
          30; // Limite correto de bandeiras para o nível "Médio"

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

    test('Exceder Limite de Bandeiras - Difícil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.hard);

      int limiteDeBandeiras =
          100; // Limite correto de bandeiras para o nível "Difícil"

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

    test('Verificação de Perda ao Marcar Bomba com Bandeira - Fácil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.easy);

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Se a zona for uma bomba, o jogador perde o jogo
      if (jogador.getBoard()[linha][coluna] == 'X') {
        expect(jogador.isGameLost(), isTrue);
      } else {
        expect(jogador.isGameLost(), isFalse);
      }
    });

    test('Verificação de Perda ao Marcar Bomba com Bandeira - Médio', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.medium);

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Se a zona for uma bomba, o jogador perde o jogo
      if (jogador.getBoard()[linha][coluna] == 'X') {
        expect(jogador.isGameLost(), isTrue);
      } else {
        expect(jogador.isGameLost(), isFalse);
      }
    });

    test('Verificação de Perda ao Marcar Bomba com Bandeira - Difícil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.hard);

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Se a zona for uma bomba, o jogador perde o jogo
      if (jogador.getBoard()[linha][coluna] == 'X') {
        expect(jogador.isGameLost(), isTrue);
      } else {
        expect(jogador.isGameLost(), isFalse);
      }
    });

    test('Verificação de Vitória - Fácil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.easy);

      // Marque todas as bombas com bandeiras
      for (int linha = 0; linha < jogador.getBoard().length; linha++) {
        for (int coluna = 0; coluna < jogador.getBoard()[0].length; coluna++) {
          if (jogador.getBoard()[linha][coluna] == 'X') {
            jogador.marcarComBandeira(linha, coluna);
          }
        }
      }

      // Se todas as bombas estiverem marcadas com bandeiras, o jogador venceu o jogo
      expect(jogador.isGameWon(), isTrue);
    });

    test('Verificação de Vitória - Médio', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.medium);

      // Marque todas as bombas com bandeiras
      for (int linha = 0; linha < jogador.getBoard().length; linha++) {
        for (int coluna = 0; coluna < jogador.getBoard()[0].length; coluna++) {
          if (jogador.getBoard()[linha][coluna] == 'X') {
            jogador.marcarComBandeira(linha, coluna);
          }
        }
      }

      // Se todas as bombas estiverem marcadas com bandeiras, o jogador venceu o jogo
      expect(jogador.isGameWon(), isTrue);
    });

    test('Verificação de Vitória - Difícil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.hard);

      // Marque todas as bombas com bandeiras
      for (int linha = 0; linha < jogador.getBoard().length; linha++) {
        for (int coluna = 0; coluna < jogador.getBoard()[0].length; coluna++) {
          if (jogador.getBoard()[linha][coluna] == 'X') {
            jogador.marcarComBandeira(linha, coluna);
          }
        }
      }

      // Se todas as bombas estiverem marcadas com bandeiras, o jogador venceu o jogo
      expect(jogador.isGameWon(), isTrue);
    });

    test('Não é possível Marcar Bandeira em Zona Descoberta', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Descobrir a zona
      jogador.descobrirZona(linha, coluna);

      // Tente marcar a zona com uma bandeira após a descoberta
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });

    test('Descobrir Zona com Bandeira - Deve ser Ignorado', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Tentar descobrir a zona que foi marcada com uma bandeira
      jogador.descobrirZona(linha, coluna);

      // Verificar se a zona não está marcada como descoberta
      expect(jogador.estaDescoberta(linha, coluna), isFalse);

      // Verificar se o jogo ainda está em andamento (não foi perdido)
      expect(jogador.isGameLost(), isFalse);
    });

    test('Descobrir Zona sem Bandeira - Deve ser Revelado', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Garanta que a zona não esteja marcada com bandeira
      jogador.removerBandeira(linha, coluna);

      // Descobrir a zona
      jogador.descobrirZona(linha, coluna);

      // Verificar se a zona está descoberta
      expect(jogador.estaDescoberta(linha, coluna), isTrue);

      // Verificar se o jogo ainda está em andamento (não foi perdido)
      expect(jogador.isGameLost(), isFalse);

      // Verificar se o tabuleiro foi atualizado corretamente (ou seja, sem bombas adjacentes)
      expect(jogador.getBoard()[linha][coluna], isNot(' '));
    });

    test('Descobrir Zona em Zona Já Descoberta - Deve ser Ignorado', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Garanta que a zona não esteja marcada com bandeira
      jogador.removerBandeira(linha, coluna);

      // Descobrir a zona pela primeira vez
      jogador.descobrirZona(linha, coluna);

      // Tente descobrir a mesma zona novamente
      jogador.descobrirZona(linha, coluna);

      // Verificar se a zona permanece marcada como descoberta
      expect(jogador.estaDescoberta(linha, coluna), isTrue);

      // Verificar se o jogo ainda está em andamento (não foi perdido)
      expect(jogador.isGameLost(), isFalse);
    });
    test('Marcação de Bombas Corretamente - Fácil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.easy);

      int bombasEsperadas = 10; // Número correto de bombas para o nível "Fácil"

      expect(jogador.getBombCount(), equals(bombasEsperadas));
    });

    test('Marcação de Bombas Corretamente - Médio', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.medium);

      int bombasEsperadas = 30; // Número correto de bombas para o nível "Médio"

      expect(jogador.getBombCount(), equals(bombasEsperadas));
    });

    test('Marcação de Bombas Corretamente - Difícil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.hard);

      int bombasEsperadas =
          100; // Número correto de bombas para o nível "Difícil"

      expect(jogador.getBombCount(), equals(bombasEsperadas));
    });

    test('Marcar todas as Zonas Corretamente - Vitória', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Marque todas as zonas com bandeiras corretamente.
      for (int linha = 0; linha < jogador.getBoard().length; linha++) {
        for (int coluna = 0; coluna < jogador.getBoard()[0].length; coluna++) {
          jogador.marcarComBandeira(linha, coluna);
        }
      }

      // Se todas as zonas estiverem marcadas com bandeiras corretamente, o jogador venceu o jogo.
      expect(jogador.isGameWon(), isTrue);
    });
    test('Verificar Marcação de Bandeiras no Modo Fácil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.easy);

      int limiteDeBandeirasEsperado =
          10; // Limite correto de bandeiras para o nível "Fácil"

      // Marque o limite de bandeiras permitido
      for (int i = 0; i < limiteDeBandeirasEsperado; i++) {
        jogador.marcarComBandeira(i, i);
      }

      // Tente marcar uma bandeira adicional além do limite
      int linhaExcedente = limiteDeBandeirasEsperado + 1;
      int colunaExcedente = limiteDeBandeirasEsperado + 1;
      jogador.marcarComBandeira(linhaExcedente, colunaExcedente);

      // Verificar se a zona excedente não está marcada com uma bandeira
      expect(jogador.temBandeira(linhaExcedente, colunaExcedente), isFalse);
    });
    test('Verificar Marcação de Bandeiras no Modo Médio', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.medium);

      int limiteDeBandeirasEsperado =
          30; // Limite correto de bandeiras para o nível "Médio"

      // Marque o limite de bandeiras permitido
      for (int i = 0; i < limiteDeBandeirasEsperado; i++) {
        jogador.marcarComBandeira(i, i);
      }

      // Tente marcar uma bandeira adicional além do limite
      int linhaExcedente = limiteDeBandeirasEsperado + 1;
      int colunaExcedente = limiteDeBandeirasEsperado + 1;
      jogador.marcarComBandeira(linhaExcedente, colunaExcedente);

      // Verificar se a zona excedente não está marcada com uma bandeira
      expect(jogador.temBandeira(linhaExcedente, colunaExcedente), isFalse);
    });

    test('Verificar Marcação de Bandeiras no Modo Difícil', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();
      jogador.setDifficulty(Difficulty.hard);

      int limiteDeBandeirasEsperado =
          100; // Limite correto de bandeiras para o nível "Difícil"

      // Marque o limite de bandeiras permitido
      for (int i = 0; i < limiteDeBandeirasEsperado; i++) {
        jogador.marcarComBandeira(i, i);
      }

      // Tente marcar uma bandeira adicional além do limite
      int linhaExcedente = limiteDeBandeirasEsperado + 1;
      int colunaExcedente = limiteDeBandeirasEsperado + 1;
      jogador.marcarComBandeira(linhaExcedente, colunaExcedente);

      // Verificar se a zona excedente não está marcada com uma bandeira
      expect(jogador.temBandeira(linhaExcedente, colunaExcedente), isFalse);
    });
    test('Teste de Clique em Zona sem Bomba - Continuar o Jogo', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro que não contém uma bomba.
      int linha = 0;
      int coluna = 0;

      // Certifique-se de que a zona não contenha uma bomba
      jogador.removerBandeira(linha, coluna);

      // Clique na zona
      jogador.descobrirZona(linha, coluna);

      // Verifique se a zona está descoberta
      expect(jogador.estaDescoberta(linha, coluna), isTrue);

      // Verifique se o jogo ainda está em andamento (não foi perdido)
      expect(jogador.isGameLost(), isFalse);

      // Verifique se o tabuleiro foi atualizado corretamente (ou seja, sem bombas adjacentes)
      expect(jogador.getBoard()[linha][coluna], isNot(' '));
    });
    test(
        'Teste de Clique em Zona sem Bombas Adjacentes - Descoberta Automática',
        () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Certifique-se de que a zona não contenha bombas
      jogador.getBoard()[linha][coluna] = ' ';

      // Clique na zona sem bombas adjacentes
      jogador.descobrirZona(linha, coluna);

      // Verifique se a zona clicada e as zonas adjacentes sem bombas também estão descobertas
      expect(jogador.estaDescoberta(linha, coluna), isTrue);

      // Verifique se o jogo ainda está em andamento (não foi perdido)
      expect(jogador.isGameLost(), isFalse);
    });
    test('Teste de Marcação de Bandeira em Zona sem Bomba - Não Afetar o Jogo',
        () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro.
      int linha = 0;
      int coluna = 0;

      // Certifique-se de que a zona não contenha bombas
      jogador.getBoard()[linha][coluna] = ' ';

      // Marque a zona sem bombas com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verifique se a zona está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isTrue);

      // Verifique se o jogo ainda está em andamento (não foi perdido)
      expect(jogador.isGameLost(), isFalse);

      // Tente descobrir a zona com bandeira
      jogador.descobrirZona(linha, coluna);

      // Verifique se a zona ainda está marcada como não descoberta
      expect(jogador.estaDescoberta(linha, coluna), isFalse);

      // Verifique se o jogo ainda está em andamento (não foi perdido)
      expect(jogador.isGameLost(), isFalse);
    });
    test('Teste de Marcação de Bandeira em Zona com Bomba - Vitória', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) seja uma coordenada válida no tabuleiro que contenha uma bomba.
      int linha = 0;
      int coluna = 0;

      // Certifique-se de que a zona contenha uma bomba
      jogador.getBoard()[linha][coluna] = 'X';

      // Marque a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verifique se a zona está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isTrue);

      // Verifique se o jogo ainda está em andamento (não foi perdido)
      expect(jogador.isGameLost(), isFalse);

      // Marque todas as bombas com bandeiras corretamente.
      for (int i = 0; i < jogador.getBoard().length; i++) {
        for (int j = 0; j < jogador.getBoard()[0].length; j++) {
          if (jogador.getBoard()[i][j] == 'X') {
            jogador.marcarComBandeira(i, j);
          }
        }
      }

      // Se todas as bombas estiverem marcadas com bandeiras corretamente, o jogador venceu o jogo.
      expect(jogador.isGameWon(), isTrue);
    });
    test('Remover Bandeira antes de Revelar', () {
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

      // Revelar a zona após a remoção da bandeira
      jogador.descobrirZona(linha, coluna);

      // Verificar se a zona está descoberta
      expect(jogador.estaDescoberta(linha, coluna), isTrue);
    });
    test('Teste de Histórico de Ações', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Suponhamos que (linha, coluna) sejam coordenadas válidas no tabuleiro.
      int linha1 = 0;
      int coluna1 = 0;
      int linha2 = 1;
      int coluna2 = 1;

      // Marque a zona com uma bandeira e adicione a ação ao histórico
      jogador.marcarComBandeira(linha1, coluna1);
      jogador
          .adicionarAcaoAoHistorico('Marcar com bandeira: ($linha1, $coluna1)');

      // Remova a bandeira da zona e adicione a ação ao histórico
      jogador.removerBandeira(linha1, coluna1);
      jogador.adicionarAcaoAoHistorico('Remover bandeira: ($linha1, $coluna1)');

      // Descubra a zona e adicione a ação ao histórico
      jogador.descobrirZona(linha2, coluna2);
      jogador.adicionarAcaoAoHistorico('Descobrir zona: ($linha2, $coluna2)');

      // Verifique o histórico de ações
      expect(jogador.obterHistoricoDeAcoes(), [
        'Marcar com bandeira: (0, 0)',
        'Remover bandeira: (0, 0)',
        'Descobrir zona: (1, 1)',
      ]);
    });

    test('Teste de Tempo de Jogo', () {
      // Inicie o cronômetro quando o jogo começar
      Stopwatch stopwatch = Stopwatch()..start();

      // Crie um jogador e inicie o jogo
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Simule a jogada do jogador (substitua isso com as ações reais do jogador)
      // Suponha que o jogador clique em algumas zonas e marque algumas bandeiras
      jogador.descobrirZona(0, 0);
      jogador.marcarComBandeira(1, 1);
      jogador.descobrirZona(2, 2);

      // Pare o cronômetro quando o jogo terminar (ou quando você desejar medir o tempo)
      stopwatch.stop();

      // Obtenha o tempo decorrido em milissegundos
      int tempoEmMilissegundos = stopwatch.elapsedMilliseconds;

      // Converta o tempo para segundos
      double tempoEmSegundos = tempoEmMilissegundos / 1000;

      // Exemplo: verificar se o jogador levou menos de 60 segundos para jogar
      expect(tempoEmSegundos, lessThan(60));
    });
  });
}
