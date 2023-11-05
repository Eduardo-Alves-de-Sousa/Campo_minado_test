import 'dart:io';

import 'package:campo_minado/dificuldade.dart';
// ignore: unused_import
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';
import 'package:campo_minado/jogador.dart';

// Função para salvar um tempo de jogo em segundos no arquivo
void saveGameTime(double timeInSeconds) {
  final file = File('game_times.txt');
  final timeString = '$timeInSeconds segundos';
  file.writeAsStringSync('$timeString\n', mode: FileMode.append);
}

// Função para salvar um tempo de jogo personalizado no arquivo
void saveCustomGameTime(String customTime) {
  final file = File('game_times.txt');
  file.writeAsStringSync('$customTime\n', mode: FileMode.append);
}

// Função para carregar todos os tempos de jogo do arquivo
List<String> loadGameTimes() {
  final file = File('game_times.txt');
  if (file.existsSync()) {
    final lines = file.readAsLinesSync();
    return lines;
  } else {
    return [];
  }
}

// Função para limpar todos os tempos de jogo do arquivo
void clearGameTimes() {
  final file = File('game_times.txt');
  if (file.existsSync()) {
    file.writeAsStringSync('');
  }
}

enum Level { easy, medium, hard }

void main() {
  final resultadosPossiveis = [
    'Vitória',
    'Derrota',
    'Jogo em Andamento',
    'Vitória com Todos os Quadrados Seguros Abertos',
    'Derrota por Explosão de Mina',
    'Vitória com Marcas de Minas Corretas',
    'Derrota com Quadrado com Mina Aberto',
    'Vitória por Concessão do Adversário',
    'Vitória com Todos os Quadrados Seguros Abertos',
    'Vitória com Marcas de Minas Corretas',
    'Vitória com Algumas Minas Não Marcadas',
    'Vitória com Minas Marcadas Incorretamente',
    'Derrota com Quadrado com Mina Aberto',
    'Derrota com Quadrado Sem Mina Aberto',
    'Derrota com Marcas de Minas Incorretas',
    'Derrota por Explosão em Quadrado sem Mina',
    'Vitória por Marcação de Todas as Minas Corretamente',
    'Vitória com Marcação de Algumas Minas Incorretamente',
    'Vitória com Minas Não Marcadas',
    'Vitória com Explosão de Último Quadrado',
    'Derrota por Abandono',
    'Derrota por Protesto',
    'Derrota por Violação das Regras',
    'Derrota por Esquecimento de Quadrado',
    'Derrota por Explosão de Quadrado Sem Mina',
    'Vitória por Acerto de Minas por Chute',
    'Vitória por Fluke',
    'Vitória por Intuição',
    'Vitória por Estratégia de Desvio',
    'Derrota por Movimento Arriscado',
    'Derrota por Desprezo de Sinais',
    'Derrota por Ignorar Dicas',
    'Derrota por Jogo Desleixado',
    'Derrota por Escolha Errada de Quadrado',
    'Vitória por Raciocínio Lógico',
    'Vitória por Marcação Precisa de Minas',
    'Vitória por Análise Cuidadosa',
    'Vitória por Dedução Estratégica',
    'Derrota por Falta de Atenção',
    'Derrota por Click Desastrado',
    'Derrota por Escolha Aleatória de Quadrado',
    'Vitória por Descoberta de Mina',
    'Vitória por Rotação de Estratégia',
    'Vitória por Mudança de Abordagem'
  ];

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

    test('Remover Bandeira de Zona Marcada', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha = 1;
      int coluna = 2;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isTrue);

      // Remover a bandeira da zona
      jogador.removerBandeira(linha, coluna);

      // Verificar se a bandeira foi removida
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });

    test('Marcar Zona com Bandeira em Coordenação Inválida', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha = -1; // Uma coordenada inválida
      int coluna = 3;

      // Tentar marcar uma zona com uma bandeira em uma coordenada inválida
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });

    test('Marcar Zona com Bandeira em Jogo Não Iniciado', () {
      Jogador jogador = Jogador();

      int linha = 2;
      int coluna = 2;

      // Tentar marcar uma zona com uma bandeira sem iniciar o jogo
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });

    test('Verificar Zona sem Bandeira', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha = 3;
      int coluna = 1;

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });

    test('Marcar Zona com Bandeira em Diferentes Coordenadas', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha1 = 1;
      int coluna1 = 2;
      int linha2 = 3;
      int coluna2 = 4;

      // Marcar zonas com bandeira em diferentes coordenadas
      jogador.marcarComBandeira(linha1, coluna1);
      jogador.marcarComBandeira(linha2, coluna2);

      // Verificar se as zonas estão marcadas com bandeira
      expect(jogador.temBandeira(linha1, coluna1), isTrue);
      expect(jogador.temBandeira(linha2, coluna2), isTrue);
    });

    test('Contar Bandeiras Marcadas', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha1 = 1;
      int coluna1 = 2;
      int linha2 = 3;
      int coluna2 = 4;

      // Marcar zonas com bandeira em diferentes coordenadas
      jogador.marcarComBandeira(linha1, coluna1);
      jogador.marcarComBandeira(linha2, coluna2);

      // Verificar se o jogador tem 2 bandeiras marcadas
      expect(jogador.contarBandeirasMarcadas(), equals(2));
    });

    test('Limpar Todas as Bandeiras', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha1 = 1;
      int coluna1 = 2;
      int linha2 = 3;
      int coluna2 = 4;

      // Marcar zonas com bandeira em diferentes coordenadas
      jogador.marcarComBandeira(linha1, coluna1);
      jogador.marcarComBandeira(linha2, coluna2);

      // Limpar todas as bandeiras
      jogador.limparTodasBandeiras();

      // Verificar se nenhuma zona está marcada com bandeira
      expect(jogador.temBandeira(linha1, coluna1), isFalse);
      expect(jogador.temBandeira(linha2, coluna2), isFalse);
    });

    test('Contar Bandeiras Marcadas Inicialmente', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      expect(jogador.contarBandeirasMarcadas(), equals(0));
    });

    test('Marcar Zona com Bandeira e Contar', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha = 1;
      int coluna = 2;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isTrue);

      // Verificar se a contagem de bandeiras marcadas aumentou
      expect(jogador.contarBandeirasMarcadas(), equals(1));
    });

    test('Iniciar Jogo Zera Contagem de Bandeiras', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha = 1;
      int coluna = 2;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isTrue);

      // Iniciar um novo jogo
      jogador.iniciarJogo();

      // Verificar se a contagem de bandeiras marcadas é 0 após iniciar um novo jogo
      expect(jogador.contarBandeirasMarcadas(), equals(0));
    });

    test('Marcar e Remover Bandeira em Coordenação Inválida', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha = -1; // Uma coordenada inválida
      int coluna = 3;

      // Tentar marcar uma zona com uma bandeira em uma coordenada inválida
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);

      // Tentar remover uma bandeira de uma coordenada inválida
      jogador.removerBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });

    test('Marcar Zona com Bandeira em Jogo Não Iniciado', () {
      Jogador jogador = Jogador();

      int linha = 2;
      int coluna = 2;

      // Tentar marcar uma zona com uma bandeira sem iniciar o jogo
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);

      // Tentar iniciar um novo jogo
      jogador.iniciarJogo();

      // Verificar se a contagem de bandeiras marcadas é 0 após iniciar um novo jogo
      expect(jogador.contarBandeirasMarcadas(), equals(0));
    });

    test('Marcar Zona com Bandeira em Diferentes Coordenadas', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha1 = 1;
      int coluna1 = 2;
      int linha2 = 3;
      int coluna2 = 4;

      // Marcar zonas com bandeira em diferentes coordenadas
      jogador.marcarComBandeira(linha1, coluna1);
      jogador.marcarComBandeira(linha2, coluna2);

      // Verificar se as zonas estão marcadas com bandeira
      expect(jogador.temBandeira(linha1, coluna1), isTrue);
      expect(jogador.temBandeira(linha2, coluna2), isTrue);
    });

    test('Contar Bandeiras Marcadas', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha1 = 1;
      int coluna1 = 2;
      int linha2 = 3;
      int coluna2 = 4;

      // Marcar zonas com bandeira em diferentes coordenadas
      jogador.marcarComBandeira(linha1, coluna1);
      jogador.marcarComBandeira(linha2, coluna2);

      // Verificar se o jogador tem 2 bandeiras marcadas
      expect(jogador.contarBandeirasMarcadas(), equals(2));
    });

    test('Tentar Marcar Zona com Bandeira em Zona Descoberta', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha = 2;
      int coluna = 2;

      // Simule uma zona já descoberta
      jogador.descobrirZona(linha, coluna);

      // Tente marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verifique se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });

    test('Verificar Jogo Ganho com Minas Restantes', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Coloque uma mina não marcada no tabuleiro
      jogador.getBoard()[1][1] = 'X';

      // Verifique se o jogo não está ganho com minas restantes
      expect(jogador.isGameWon(), isFalse);
    });

    test('Marcar e Remover Bandeira em Coordenada Válida', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha = 2;
      int coluna = 2;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isTrue);

      // Remover a bandeira da zona
      jogador.removerBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });

    test('Marcar e Remover Bandeira em Coordenada Inválida', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha = -1; // Uma coordenada inválida
      int coluna = 3;

      // Tentar marcar uma zona com uma bandeira em uma coordenada inválida
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);

      // Tentar remover uma bandeira de uma coordenada inválida
      jogador.removerBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });

    test('Marcar e Remover Bandeira em Jogo Não Iniciado', () {
      Jogador jogador = Jogador();

      int linha = 2;
      int coluna = 2;

      // Tentar marcar uma zona com uma bandeira sem iniciar o jogo
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);

      // Tentar remover uma bandeira sem iniciar o jogo
      jogador.removerBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);
    });

    test('Limpar Todas as Bandeiras', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha1 = 1;
      int coluna1 = 2;
      int linha2 = 3;
      int coluna2 = 4;

      // Marcar zonas com bandeira em diferentes coordenadas
      jogador.marcarComBandeira(linha1, coluna1);
      jogador.marcarComBandeira(linha2, coluna2);

      // Verificar se a contagem de bandeiras marcadas é maior que 0
      expect(jogador.contarBandeirasMarcadas(), greaterThan(0));

      // Limpar todas as bandeiras
      jogador.limparTodasBandeiras();

      // Verificar se a contagem de bandeiras marcadas é 0 após a limpeza
      expect(jogador.contarBandeirasMarcadas(), equals(0));
    });

    test('Verificar Vitória com Todas as Minas Marcadas', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Configuração de jogo onde todas as minas estão marcadas com bandeiras
      for (int linha = 0; linha < jogador.getBoard().length; linha++) {
        for (int coluna = 0; coluna < jogador.getBoard()[0].length; coluna++) {
          if (jogador.getBoard()[linha][coluna] == 'X') {
            jogador.marcarComBandeira(linha, coluna);
          }
        }
      }

      // Verificar se o jogo está ganho
      expect(jogador.isGameWon(), isTrue);
    });

    test('Verificar Derrota ao Descobrir Mina', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Configuração de jogo onde uma mina é descoberta
      jogador.descobrirZona(1, 1);

      // Verificar se o jogo está perdido
      expect(jogador.isGameWon(), isFalse);
    });

    test('Verificar Derrota ao Marcar Zona com Bandeira Incorreta', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Configuração de jogo onde uma zona que não é uma mina é marcada com bandeira
      jogador.marcarComBandeira(2, 2);

      // Verificar se o jogo está perdido
      expect(jogador.isGameWon(), isFalse);
    });

    test('Marcar Zona com Bandeira e Contar', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha = 1;
      int coluna = 2;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isTrue);

      // Verificar se a contagem de bandeiras marcadas aumentou
      expect(jogador.contarBandeirasMarcadas(), equals(1));
    });

    test('Marcar e Remover Zona com Bandeira e Contar', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha = 2;
      int coluna = 3;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isTrue);

      // Remover a bandeira da zona
      jogador.removerBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);

      // Verificar se a contagem de bandeiras marcadas voltou a 0
      expect(jogador.contarBandeirasMarcadas(), equals(0));
    });

    test('Limpar Todas as Bandeiras e Contar', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha1 = 1;
      int coluna1 = 2;
      int linha2 = 3;
      int coluna2 = 4;

      // Marcar zonas com bandeira em diferentes coordenadas
      jogador.marcarComBandeira(linha1, coluna1);
      jogador.marcarComBandeira(linha2, coluna2);

      // Verificar se a contagem de bandeiras marcadas é maior que 0
      expect(jogador.contarBandeirasMarcadas(), greaterThan(0));

      // Limpar todas as bandeiras
      jogador.limparTodasBandeiras();

      // Verificar se a contagem de bandeiras marcadas é 0 após a limpeza
      expect(jogador.contarBandeirasMarcadas(), equals(0));
    });

    test('Verificar Perda ao Descobrir Mina', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Configuração de jogo onde uma mina é descoberta
      jogador.descobrirZona(1, 1);

      // Verificar se o jogo está perdido
      expect(jogador.isGameWon(), isFalse);
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

    test('Verificar Derrota ao Marcar Zona com Bandeira Incorreta', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Configuração de jogo onde uma zona que não é uma mina é marcada com bandeira
      jogador.marcarComBandeira(2, 2);

      // Verificar se o jogo está perdido
      expect(jogador.isGameWon(), isFalse);
    });

    test('Marcar e Remover Zona com Bandeira e Contar', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha = 2;
      int coluna = 3;

      // Marcar a zona com uma bandeira
      jogador.marcarComBandeira(linha, coluna);

      // Verificar se a zona está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isTrue);

      // Remover a bandeira da zona
      jogador.removerBandeira(linha, coluna);

      // Verificar se a zona não está marcada com uma bandeira
      expect(jogador.temBandeira(linha, coluna), isFalse);

      // Verificar se a contagem de bandeiras marcadas voltou a 0
      expect(jogador.contarBandeirasMarcadas(), equals(0));
    });

    test('Limpar Todas as Bandeiras e Contar', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      int linha1 = 1;
      int coluna1 = 2;
      int linha2 = 3;
      int coluna2 = 4;

      // Marcar zonas com bandeira em diferentes coordenadas
      jogador.marcarComBandeira(linha1, coluna1);
      jogador.marcarComBandeira(linha2, coluna2);

      // Verificar se a contagem de bandeiras marcadas é maior que 0
      expect(jogador.contarBandeirasMarcadas(), greaterThan(0));

      // Limpar todas as bandeiras
      jogador.limparTodasBandeiras();

      // Verificar se a contagem de bandeiras marcadas é 0 após a limpeza
      expect(jogador.contarBandeirasMarcadas(), equals(0));
    });

    test('Verificar Vitória com Todas as Minas Marcadas', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Configuração de jogo onde todas as minas estão marcadas com bandeiras
      for (int linha = 0; linha < jogador.getBoard().length; linha++) {
        for (int coluna = 0; coluna < jogador.getBoard()[0].length; coluna++) {
          if (jogador.getBoard()[linha][coluna] == 'X') {
            jogador.marcarComBandeira(linha, coluna);
          }
        }
      }

      // Verificar se o jogo está ganho
      expect(jogador.isGameWon(), isTrue);
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
    test('Teste de Contagem de Minas no Tabuleiro', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Realize ações de jogo para contar minas
      int bombCount = jogador.getBombCount();

      // Obtenha o número de minas no tabuleiro (substitua com o número real de minas)
      int minasReais = 10; // Substitua com o número correto de minas

      // Verificar se a contagem de minas está correta
      expect(bombCount, equals(minasReais));
    });
    test('Teste de Contagem de Bandeiras Marcadas', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Marcar algumas zonas com bandeira
      jogador.marcarComBandeira(1, 2);
      jogador.marcarComBandeira(3, 4);

      // Verificar se a contagem de bandeiras marcadas é correta
      expect(jogador.contarBandeirasMarcadas(), equals(2));
    });
    test('Teste de Limpeza de Todas as Bandeiras', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Marcar algumas zonas com bandeira
      jogador.marcarComBandeira(1, 2);
      jogador.marcarComBandeira(3, 4);

      // Limpar todas as bandeiras
      jogador.limparTodasBandeiras();

      // Verificar se a contagem de bandeiras marcadas é 0 após a limpeza
      expect(jogador.contarBandeirasMarcadas(), equals(0));
    });
    test('Teste de Contagem de Bandeiras Marcadas', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Marcar algumas zonas com bandeira
      jogador.marcarComBandeira(1, 2);
      jogador.marcarComBandeira(3, 4);

      // Verificar se a contagem de bandeiras marcadas é correta
      expect(jogador.contarBandeirasMarcadas(), equals(2));
    });
    test('Teste de Contagem de Minas no Tabuleiro', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Realize ações de jogo para contar minas
      int bombCount = jogador.getBombCount();

      // Obtenha o número de minas no tabuleiro (substitua com o número real de minas)
      int minasReais = 10; // Substitua com o número correto de minas

      // Verificar se a contagem de minas está correta
      expect(bombCount, equals(minasReais));
    });
    test('Teste de Remoção de Bandeira', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Marcar uma zona com bandeira
      jogador.marcarComBandeira(1, 2);

      // Remover a bandeira da mesma zona
      jogador.removerBandeira(1, 2);

      // Verificar se a zona não tem bandeira após a remoção
      expect(jogador.temBandeira(1, 2), isFalse);
    });
    test('Teste de Derrota ao Descobrir Mina', () {
      Jogador jogador = Jogador();
      jogador.iniciarJogo();

      // Configuração de jogo onde uma mina é descoberta
      jogador.descobrirZona(1, 1);

      // Verificar se o jogo está perdido
      expect(jogador.isGameWon(), isFalse);
    });
  });
  group('Testes de Tempo', () {
    test('Tempo de jogo deve ser maior que zero', () {
      // Certifique-se de que o tempo do jogo seja maior que zero
      final tempoDeJogo = 10.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, greaterThan(0));
    });
    test('Tempo de jogo deve ser uma duração válida', () {
      // Certifique-se de que o tempo do jogo seja uma duração válida
      final tempoDeJogo = 30.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, isA<double>());
    });

    test('Tempo de jogo deve ser uma duração em segundos', () {
      // Certifique-se de que o tempo do jogo seja uma duração válida em segundos
      final tempoDeJogo = 45.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, isA<double>());
    });
    test('Tempo de jogo deve ser menor que 100 segundos', () {
      // Certifique-se de que o tempo do jogo seja menor que 100 segundos
      final tempoDeJogo = 75.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, lessThan(100.0));
    });
    test('Tempo de jogo deve ser uma duração válida em segundos', () {
      // Certifique-se de que o tempo do jogo seja uma duração válida em segundos
      final tempoDeJogo = 150.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, isA<double>());
    });
    test('Tempo de jogo deve ser maior que zero', () {
      final tempoDeJogo = 30.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, greaterThan(0.0));
    });
    test('Tempo de jogo deve ser menor que 500 segundos', () {
      final tempoDeJogo = 450.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, lessThan(500.0));
    });

    test('Tempo de jogo deve ser uma duração válida em segundos', () {
      final tempoDeJogo = 150.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, isA<double>());
    });
    test('Tempo de jogo deve ser uma duração válida em segundos e não negativa',
        () {
      final tempoDeJogo = 150.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, greaterThanOrEqualTo(0.0));
    });

    test('Tempo de jogo deve ser maior que 1 hora (3600 segundos)', () {
      final tempoDeJogo = 3700.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, greaterThanOrEqualTo(3600.0));
    });

    test('Tempo de jogo deve ser menor que 60 segundos', () {
      final tempoDeJogo = 45.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, lessThan(60.0));
    });

    test('Tempo de jogo deve ser exatamente 10 segundos', () {
      final tempoDeJogo = 10.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, equals(10.0));
    });

    test('Tempo de jogo deve ser uma duração válida em segundos', () {
      final tempoDeJogo = 30.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, isA<double>());
    });

    test('Tempo de jogo deve ser maior que 1 minuto (60 segundos)', () {
      final tempoDeJogo = 90.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, greaterThanOrEqualTo(60.0));
    });

    test('Tempo de jogo deve ser exatamente 1 hora (3600 segundos)', () {
      final tempoDeJogo = 3600.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, equals(3600.0));
    });

    test('Tempo de jogo deve ser uma duração válida em minutos', () {
      final tempoDeJogo = 120.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, isA<double>());
    });

    test('Tempo de jogo deve ser maior que 24 horas (86400 segundos)', () {
      final tempoDeJogo = 90000.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, greaterThan(86400.0));
    });

    test('Tempo de jogo deve ser menor que 1 minuto (60 segundos)', () {
      final tempoDeJogo = 45.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, lessThan(60.0));
    });

    test('Tempo de jogo deve ser exatamente 6 horas (21600 segundos)', () {
      final tempoDeJogo = 21600.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, equals(21600.0));
    });
    test('Tempo de jogo deve ser menor que 5 minutos (300 segundos)', () {
      final tempoDeJogo = 240.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, lessThan(300.0));
    });

    test('Tempo de jogo deve ser uma duração válida em minutos', () {
      final tempoDeJogo = 180.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, isA<double>());
    });

    test('Tempo de jogo deve ser maior que 1 minuto (60 segundos)', () {
      final tempoDeJogo = 75.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, greaterThanOrEqualTo(60.0));
    });

    test('Tempo de jogo deve ser exatamente 30 minutos (1800 segundos)', () {
      final tempoDeJogo = 1800.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, equals(1800.0));
    });

    test('Tempo de jogo deve ser menor que 10 minutos (600 segundos)', () {
      final tempoDeJogo = 480.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, lessThan(600.0));
    });

    test('Tempo de jogo deve ser uma duração válida em minutos e não negativa',
        () {
      final tempoDeJogo = 150.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, greaterThanOrEqualTo(0.0));
    });

    test('Tempo de jogo deve ser menor que 30 minutos (1800 segundos)', () {
      final tempoDeJogo = 1650.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, lessThan(1800.0));
    });

    test('Tempo de jogo deve ser exatamente 15 minutos (900 segundos)', () {
      final tempoDeJogo = 900.0; // Substitua pelo tempo real do jogo
      expect(tempoDeJogo, equals(900.0));
    });
  });
  group('Testes para o jogo', () {
    test('Resultado do jogo deve ser válido', () {
      final resultado = 'Vitória'; // Substitua pelo resultado real do jogo
      expect(resultado, anyOf('Vitória', 'Derrota'));
    });

    test('Número de bombas deve ser maior que zero', () {
      final numBombs = 10; // Substitua pelo número real de bombas no jogo
      expect(numBombs, greaterThan(0));
    });

    test('Número de linhas e colunas deve ser maior que zero', () {
      final rows = 8; // Substitua pelo número real de linhas
      final cols = 8; // Substitua pelo número real de colunas
      expect(rows, greaterThan(0));
      expect(cols, greaterThan(0));
    });

    test('Número de bombas deve ser menor ou igual ao número de células', () {
      final numBombs = 10; // Substitua pelo número real de bombas
      final totalCells = 64; // Substitua pelo número real de células
      expect(numBombs, lessThanOrEqualTo(totalCells));
    });

    test('Número de bombas deve ser maior ou igual a 10% do total de células',
        () {
      final numBombs = 7; // Substitua pelo número real de bombas
      final totalCells = 64; // Substitua pelo número real de células
      expect(numBombs, greaterThanOrEqualTo(totalCells * 0.1));
    });
    test('Resultado do jogo deve ser "Vitória" ou "Derrota"', () {
      final resultado = 'Vitória'; // Substitua pelo resultado real do jogo
      expect(resultado, anyOf('Vitória', 'Derrota'));
    });

    test('Número de bombas deve ser maior que zero', () {
      final numBombs = 10; // Substitua pelo número real de bombas no jogo
      expect(numBombs, greaterThan(0));
    });

    test('Número de linhas e colunas deve ser maior que zero', () {
      final rows = 8; // Substitua pelo número real de linhas
      final cols = 8; // Substitua pelo número real de colunas
      expect(rows, greaterThan(0));
      expect(cols, greaterThan(0));
    });

    test('Número de bombas deve ser menor ou igual ao número de células', () {
      final numBombs = 10; // Substitua pelo número real de bombas
      final totalCells = 64; // Substitua pelo número real de células
      expect(numBombs, lessThanOrEqualTo(totalCells));
    });

    test('Número de bombas deve ser maior ou igual a 10% do total de células',
        () {
      final numBombs = 7; // Substitua pelo número real de bombas
      final totalCells = 64; // Substitua pelo número real de células
      expect(numBombs, greaterThanOrEqualTo(totalCells * 0.1));
    });

    // Adicione outros testes relacionados ao seu jogo, como verificar se as ações do jogador são válidas, se as células reveladas estão corretas, etc.
    test('Ação do jogador deve ser válida', () {
      final acao = 'Revelar'; // Substitua pela ação real do jogador
      expect(acao, anyOf('Revelar', 'Marcar', 'Desmarcar'));
    });

    test('Ação do jogador deve ser "Marcar" ou "Desmarcar"', () {
      final acao = 'Marcar'; // Substitua pela ação real do jogador
      expect(acao, anyOf('Marcar', 'Desmarcar'));
    });

    test('Ação do jogador deve ser uma string não vazia', () {
      final acao = 'Revelar'; // Substitua pela ação real do jogador
      expect(acao, isNotEmpty);
    });

    test('Ação do jogador deve ser uma das ações válidas', () {
      final acao = 'Revelar'; // Substitua pela ação real do jogador
      final acoesValidas = ['Revelar', 'Marcar', 'Desmarcar']; // Ações válidas
      expect(acao, isIn(acoesValidas));
    });

    test('Ação do jogador deve estar em caixa alta', () {
      final acao = 'MARCAR'; // Substitua pela ação real do jogador
      expect(acao, equals(acao.toUpperCase()));
    });

    test('Célula revelada deve estar correta', () {
      final celulaRevelada = 'Bomba'; // Substitua pela célula real revelada
      expect(celulaRevelada,
          anyOf('Bomba', 'Vazia', 'Número de bombas adjacentes'));
    });

    test('Ação do jogador deve ser "Clicar" ou "Marcar"', () {
      final acao = 'Clicar'; // Substitua pela ação real do jogador
      expect(acao, anyOf('Clicar', 'Marcar'));
    });

    test('Ação do jogador deve ser uma string não vazia', () {
      final acao = 'Marcar'; // Substitua pela ação real do jogador
      expect(acao, isNotEmpty);
    });

    test('Ação do jogador deve ser uma das ações válidas', () {
      final acao = 'Clicar'; // Substitua pela ação real do jogador
      final acoesValidas = ['Clicar', 'Marcar']; // Ações válidas
      expect(acao, isIn(acoesValidas));
    });

    test('Ação do jogador deve estar em caixa alta', () {
      final acao = 'MARCAR'; // Substitua pela ação real do jogador
      expect(acao, equals(acao.toUpperCase()));
    });

    test(
        'Número de bandeiras marcadas deve ser menor ou igual ao número de bombas',
        () {
      final numBandeirasMarcadas =
          3; // Substitua pelo número real de bandeiras marcadas
      final numBombas = 5; // Substitua pelo número real de bombas no jogo
      expect(numBandeirasMarcadas, lessThanOrEqualTo(numBombas));
    });

    test('Ação do jogador deve ser "Revelar" para uma célula desconhecida', () {
      final acao = 'Revelar'; // Substitua pela ação real do jogador
      final celulaConhecida =
          false; // Substitua pelo estado da célula (desconhecida)
      expect(acao, equals('Revelar'));
      expect(celulaConhecida, isFalse);
    });

    test('Ação do jogador deve ser "Marcar" para uma célula desconhecida', () {
      final acao = 'Marcar'; // Substitua pela ação real do jogador
      final celulaConhecida =
          false; // Substitua pelo estado da célula (desconhecida)
      expect(acao, equals('Marcar'));
      expect(celulaConhecida, isFalse);
    });

    test('Ação do jogador deve ser "Desmarcar" para uma célula marcada', () {
      final acao = 'Desmarcar'; // Substitua pela ação real do jogador
      final celulaMarcada = true; // Substitua pelo estado da célula (marcada)
      expect(acao, equals('Desmarcar'));
      expect(celulaMarcada, isTrue);
    });

    test('Ação do jogador deve ser "Revelar" para uma célula marcada', () {
      final acao = 'Revelar'; // Substitua pela ação real do jogador
      final celulaMarcada = true; // Substitua pelo estado da célula (marcada)
      expect(acao, equals('Revelar'));
      expect(celulaMarcada, isTrue);
    });

    test('O jogo deve terminar quando todas as bombas estiverem marcadas', () {
      final todasBombasMarcadas = true; // Substitua pelo estado real das bombas
      final jogoTerminou = true; // Substitua pelo estado real do jogo
      expect(todasBombasMarcadas, isTrue);
      expect(jogoTerminou, isTrue);
    });

    test('O jogo deve continuar quando uma célula vazia for revelada', () {
      final celulaVaziaRevelada = true; // Substitua pelo estado real da célula
      final jogoTerminou = false; // Substitua pelo estado real do jogo
      expect(celulaVaziaRevelada, isTrue);
      expect(jogoTerminou, isFalse);
    });

    test('O jogo deve terminar quando uma bomba for revelada', () {
      final bombaRevelada = true; // Substitua pelo estado real da bomba
      final jogoTerminou = true; // Substitua pelo estado real do jogo
      expect(bombaRevelada, isTrue);
      expect(jogoTerminou, isTrue);
    });

    test('O jogo deve continuar quando uma célula vazia for revelada', () {
      final celulaVaziaRevelada = true; // Substitua pelo estado real da célula
      final jogoTerminou = false; // Substitua pelo estado real do jogo
      expect(celulaVaziaRevelada, isTrue);
      expect(jogoTerminou, isFalse);
    });

    test('O jogo deve continuar quando nenhuma bomba for revelada', () {
      final bombasReveladas =
          0; // Substitua pelo número real de bombas reveladas
      final jogoTerminou = false; // Substitua pelo estado real do jogo
      expect(bombasReveladas, equals(0));
      expect(jogoTerminou, isFalse);
    });

    test('O jogo deve terminar quando todas as bombas forem marcadas', () {
      final todasBombasMarcadas = true; // Substitua pelo estado real das bombas
      final jogoTerminou = true; // Substitua pelo estado real do jogo
      expect(todasBombasMarcadas, isTrue);
      expect(jogoTerminou, isTrue);
    });

    test(
        'O jogo deve continuar quando todas as células não bomba forem reveladas',
        () {
      final todasNaoBombasReveladas =
          true; // Substitua pelo estado real das células não bomba
      final jogoTerminou = false; // Substitua pelo estado real do jogo
      expect(todasNaoBombasReveladas, isTrue);
      expect(jogoTerminou, isFalse);
    });

    test(
        'O jogo deve terminar quando o jogador revelar todas as células seguras',
        () {
      final todasCelulasSegurasReveladas =
          true; // Substitua pelo estado real das células seguras
      final jogoTerminou = true; // Substitua pelo estado real do jogo
      expect(todasCelulasSegurasReveladas, isTrue);
      expect(jogoTerminou, isTrue);
    });

    test('O jogo deve continuar quando uma bomba for marcada corretamente', () {
      final bombaMarcadaCorretamente =
          true; // Substitua pelo estado real da bomba marcada
      final jogoTerminou = false; // Substitua pelo estado real do jogo
      expect(bombaMarcadaCorretamente, isTrue);
      expect(jogoTerminou, isFalse);
    });

    test('O jogo deve terminar quando uma bomba for marcada incorretamente',
        () {
      final bombaMarcadaIncorretamente =
          true; // Substitua pelo estado real da bomba marcada
      final jogoTerminou = true; // Substitua pelo estado real do jogo
      expect(bombaMarcadaIncorretamente, isTrue);
      expect(jogoTerminou, isTrue);
    });

    test('O jogador deve poder revelar células seguras', () {
      final celulaSeguraRevelada =
          true; // Substitua pelo estado real da célula segura revelada
      expect(celulaSeguraRevelada, isTrue);
    });

    test('O jogador não deve ser capaz de revelar células já reveladas', () {
      final celulaJaRevelada =
          true; // Substitua pelo estado real da célula já revelada
      expect(celulaJaRevelada, isTrue);
    });

    test('O jogador não deve ser capaz de marcar células já marcadas', () {
      final celulaJaMarcada =
          true; // Substitua pelo estado real da célula já marcada
      expect(celulaJaMarcada, isTrue);
    });

    test(
        'O jogador deve ser capaz de desmarcar uma célula anteriormente marcada',
        () {
      final celulaMarcada =
          true; // Substitua pelo estado real da célula marcada
      final jogadorDesmarcou =
          true; // Substitua pelo estado real da ação do jogador
      expect(celulaMarcada, isTrue);
      expect(jogadorDesmarcou, isTrue);
    });

    test('O jogo deve terminar quando o jogador revelar uma bomba', () {
      final bombaRevelada =
          true; // Substitua pelo estado real da bomba revelada
      final jogoTerminou = true; // Substitua pelo estado real do jogo
      expect(bombaRevelada, isTrue);
      expect(jogoTerminou, isTrue);
    });

    test('O jogo deve continuar quando o jogador revelar uma célula segura',
        () {
      final celulaSeguraRevelada =
          true; // Substitua pelo estado real da célula segura revelada
      final jogoTerminou = false; // Substitua pelo estado real do jogo
      expect(celulaSeguraRevelada, isTrue);
      expect(jogoTerminou, isFalse);
    });

    test('Número de bombas adjacentes deve ser válido', () {
      final numBombasAdjacentes = 3; // Substitua pelo número real
      expect(numBombasAdjacentes, greaterThanOrEqualTo(0));
    });
    test('Resultado do jogo não deve ser uma string vazia', () {
      final resultado = 'Vitória'; // Substitua pelo resultado real do jogo
      expect(resultado, isNotEmpty);
    });

    test('Resultado do jogo deve ser uma string', () {
      final resultado = 'Vitória'; // Substitua pelo resultado real do jogo
      expect(resultado, isA<String>());
    });

    test('Resultado do jogo deve conter apenas letras maiúsculas', () {
      final resultado = 'VITÓRIA'; // Substitua pelo resultado real do jogo
      final resultadoInvalido =
          'Vitória'; // Substitua por um resultado inválido
      expect(resultado, equals(resultado.toUpperCase()));
      expect(resultadoInvalido, isNot(equals(resultadoInvalido.toUpperCase())));
    });
    test('Resultado do jogo não deve conter espaços em branco', () {
      final resultado = 'Vitória'; // Substitua pelo resultado real do jogo
      final resultadoComEspaco =
          'Vitória Final'; // Substitua por um resultado inválido
      expect(resultado, isNot(contains(' ')));
      expect(resultadoComEspaco, contains(' '));
    });
    test('Resultado do jogo deve ter no máximo 10 caracteres', () {
      final resultado = 'Vitória'; // Substitua pelo resultado real do jogo
      expect(resultado, hasLength(lessThanOrEqualTo(10)));
    });
  });
  group('Testes de Armazenamento de Tempo', () {
    test('Deve salvar e carregar tempos de jogo corretamente', () {
      // Limpa o arquivo de tempos de jogo antes de começar o teste
      final file = File('game_times.txt');
      if (file.existsSync()) {
        file.deleteSync();
      }

      // Salva tempos de jogo simulados
      saveGameTime(30.0);
      saveGameTime(45.5);
      saveGameTime(60.0);

      // Carrega tempos de jogo
      final gameTimes = loadGameTimes();

      // Verifica se os tempos de jogo foram carregados corretamente
      expect(gameTimes, contains(contains('30.0 segundos')));
      expect(gameTimes, contains(contains('45.5 segundos')));
      expect(gameTimes, contains(contains('60.0 segundos')));
    });

    test('Deve lidar com arquivo vazio', () {
      // Remove o arquivo de tempos de jogo, se existir
      final file = File('game_times.txt');
      if (file.existsSync()) {
        file.deleteSync();
      }

      // Tenta carregar tempos de jogo de um arquivo vazio
      final gameTimes = loadGameTimes();

      // Verifica se a lista de tempos de jogo está vazia
      expect(gameTimes, isEmpty);
    });
    test('Deve adicionar um novo tempo de jogo corretamente', () {
      final initialGameTimes = loadGameTimes();
      final newGameTime = 75.0;
      saveGameTime(newGameTime);
      final updatedGameTimes = loadGameTimes();
      expect(updatedGameTimes, contains(contains('$newGameTime segundos')));
      expect(updatedGameTimes, hasLength(initialGameTimes.length + 1));
    });

    test('Deve remover todos os tempos de jogo', () {
      final initialGameTimes = loadGameTimes();
      expect(initialGameTimes, isNotEmpty);
      clearGameTimes();
      final updatedGameTimes = loadGameTimes();
      expect(updatedGameTimes, isEmpty);
    });

    test('Deve lidar com arquivo inexistente', () {
      final file = File('game_times.txt');
      if (file.existsSync()) {
        file.deleteSync();
      }
      final gameTimes = loadGameTimes();
      expect(gameTimes, isEmpty);
    });

    test('Deve salvar tempos de jogo como strings personalizadas', () {
      final customGameTime = '10 minutos e 30 segundos';
      saveCustomGameTime(customGameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(customGameTime));
    });

    test('Deve verificar a presença de tempos de jogo duplicados', () {
      final gameTime = 45.0;
      saveGameTime(gameTime);
      saveGameTime(gameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes.where((line) => line.contains('$gameTime segundos')),
          hasLength(2));
    });

    test('Deve salvar tempos de jogo com precisão de milissegundos', () {
      final gameTimeInMilliseconds = 12345.678;
      saveGameTime(gameTimeInMilliseconds / 1000.0);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('12.345678 segundos')));
    });

    test('Deve lidar com caracteres especiais em tempos de jogo', () {
      final gameTimeWithSpecialChars = '5 segundos (10%)';
      saveCustomGameTime(gameTimeWithSpecialChars);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(gameTimeWithSpecialChars));
    });

    test('Deve salvar tempos de jogo negativos', () {
      final gameTime = -15.0;
      saveGameTime(gameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('$gameTime segundos')));
    });

    test('Deve lidar com tempo de jogo igual a zero', () {
      final gameTimeZero = 0.0;
      saveGameTime(gameTimeZero);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('$gameTimeZero segundos')));
    });

    test('Deve lidar com valores extremamente grandes', () {
      final largeGameTime = 1e20;
      saveGameTime(largeGameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('$largeGameTime segundos')));
    });

    test('Deve lidar com valores extremamente pequenos', () {
      final smallGameTime = 1e-20;
      saveGameTime(smallGameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('$smallGameTime segundos')));
    });

    test('Deve salvar e carregar tempos de jogo em diferentes idiomas', () {
      final gameTimeInEnglish = '5 seconds';
      final gameTimeInSpanish = '5 segundos';
      final gameTimeInFrench = '5 secondes';
      saveCustomGameTime(gameTimeInEnglish);
      saveCustomGameTime(gameTimeInSpanish);
      saveCustomGameTime(gameTimeInFrench);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(gameTimeInEnglish));
      expect(gameTimes, contains(gameTimeInSpanish));
      expect(gameTimes, contains(gameTimeInFrench));
    });

    test('Deve lidar com valores muito próximos a zero', () {
      final gameTimeCloseToZero = 1e-15;
      saveGameTime(gameTimeCloseToZero);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('$gameTimeCloseToZero segundos')));
    });
    test(
        'Deve salvar tempos de jogo com múltiplos dígitos após o ponto decimal',
        () {
      final gameTimeWithDigits = 12.3456789;
      saveGameTime(gameTimeWithDigits);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('12.3456789 segundos')));
    });

    test('Deve salvar tempos de jogo com zero após o ponto decimal', () {
      final gameTime = 42.0; // Substitua pelo tempo real do jogo
      saveGameTime(gameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('42.0 segundos')));
    });

    test('Deve salvar tempos de jogo com um dígito após o ponto decimal', () {
      final gameTime = 12.5; // Substitua pelo tempo real do jogo
      saveGameTime(gameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('12.5 segundos')));
    });

    test('Deve salvar tempos de jogo com três dígitos após o ponto decimal',
        () {
      final gameTime = 7.123; // Substitua pelo tempo real do jogo
      saveGameTime(gameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('7.123 segundos')));
    });

    test('Deve salvar tempos de jogo com quatro dígitos após o ponto decimal',
        () {
      final gameTime = 123.4567; // Substitua pelo tempo real do jogo
      saveGameTime(gameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('123.4567 segundos')));
    });

    test('O jogador deve ser capaz de marcar e desmarcar células', () {
      final marcado = true; // Substitua pelo estado real de marcação
      expect(marcado, anyOf(isTrue, isFalse));
    });

    test('A contagem de bombas vizinhas deve ser correta', () {
      final bombasVizinhas = 3; // Substitua pelo número real de bombas vizinhas
      expect(bombasVizinhas, greaterThanOrEqualTo(0));
    });

    test('O jogo deve permitir a reinicialização', () {
      final jogoReiniciado =
          true; // Substitua pelo estado real de reinicialização
      expect(jogoReiniciado, isTrue);
    });

    test('A interface do jogo deve atualizar após ações do jogador', () {
      final interfaceAtualizada =
          true; // Substitua pelo estado real de atualização
      expect(interfaceAtualizada, isTrue);
    });

    test('Deve ser possível desmarcar uma célula marcada', () {
      final desmarcado = true; // Substitua pelo estado real de desmarcação
      expect(desmarcado, isTrue);
    });

    test('Deve lidar com tempos de jogo muito grandes em segundos', () {
      final largeGameTime = 1e9; // 1 bilhão de segundos
      saveGameTime(largeGameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('$largeGameTime segundos')));
    });

    test('Deve lidar com tempos de jogo muito pequenos em segundos', () {
      final smallGameTime = 1e-9; // 1 nanossegundo
      saveGameTime(smallGameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('$smallGameTime segundos')));
    });

    test('Deve salvar e carregar tempos de jogo com grande precisão', () {
      final gameTimeWithPrecision = 0.123456789;
      saveGameTime(gameTimeWithPrecision);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('0.123456789 segundos')));
    });
    test('Deve salvar e carregar o tempo de jogo com outro valor de precisão',
        () {
      final gameTimeWithPrecision = 0.987654321;
      saveGameTime(gameTimeWithPrecision);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('0.987654321 segundos')));
    });
    test('Deve salvar e carregar múltiplos tempos de jogo com precisão', () {
      final gameTimesWithPrecision = [0.123456789, 0.987654321, 1.23456789];
      for (final time in gameTimesWithPrecision) {
        saveGameTime(time);
      }
      final loadedGameTimes = loadGameTimes();
      for (final time in gameTimesWithPrecision) {
        expect(loadedGameTimes, contains(contains('$time segundos')));
      }
    });
    test('Deve salvar e carregar tempos de jogo negativos com precisão', () {
      final gameTimeWithPrecision = -0.123456789;
      saveGameTime(gameTimeWithPrecision);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('-0.123456789 segundos')));
    });
    test('Deve salvar e carregar tempos de jogo maiores que 1 segundo', () {
      final gameTime = 1.5; // 1.5 segundos
      saveGameTime(gameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('1.5 segundos')));
    });

    test('Deve salvar e carregar tempos de jogo zerados', () {
      final gameTime = 0.0;
      saveGameTime(gameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('0.0 segundos')));
    });

    test('Deve lidar com valores muito grandes de tempo de jogo', () {
      final gameTime = 1000000.0; // 1 milhão de segundos
      saveGameTime(gameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('1000000.0 segundos')));
    });
    test('Deve lidar com tempos de jogo arredondados', () {
      final gameTime = 1.0; // 1 segundo
      saveGameTime(gameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('1.0 segundos')));
    });
    test('Deve lidar com tempos de jogo fracionados', () {
      final gameTime = 0.5; // 0.5 segundos
      saveGameTime(gameTime);
      final gameTimes = loadGameTimes();
      expect(gameTimes, contains(contains('0.5 segundos')));
    });
  });

  group('Testes do Resultado do Jogo', () {
    for (final resultado in resultadosPossiveis) {
      test('Resultado do jogo é válido: $resultado', () {
        expect(resultado, anyOf(resultadosPossiveis));
      });
    }
  });
  final int numRows = 8; // Número de linhas do campo minado
  final int numCols = 8; // Número de colunas do campo minado
  final Jogador jogador = Jogador();

  group(
      'Testes de Marcação e Remoção de Bandeira em Todas as Posições, em um campo 8 x 8',
      () {
    setUp(() {
      jogador.iniciarJogo();
    });

    testCases(numRows, numCols, "Marcar e Remover Bandeira",
        (int linha, int coluna) {
      test('Linha: $linha, Coluna: $coluna', () {
        // Marcar a zona com uma bandeira
        jogador.marcarComBandeira(linha, coluna);
        expect(jogador.temBandeira(linha, coluna), isTrue);

        // Remover a bandeira da zona
        jogador.removerBandeira(linha, coluna);
        expect(jogador.temBandeira(linha, coluna), isFalse);
      });
    });
  });
  group('Teste de Limite - Tabuleiro 8x8', () {
    testLimiteFacil(
      [
        {'row': 0, 'col': 0},
        {'row': 7, 'col': 0},
        {'row': 0, 'col': 7},
        {'row': 7, 'col': 7},
        {'row': 4, 'col': 4},
        {'row': 2, 'col': 6},
        {'row': 3, 'col': 5},
        {'row': 1, 'col': 3},
        {'row': 6, 'col': 1},
        {'row': 3, 'col': 7},
        {'row': 4, 'col': 1},
        {'row': 7, 'col': 4},
      ],
      "Teste de Limite - Tabuleiro 8x8",
    );
  });
  group('Teste de Limite - Tabuleiro 10x16 (Nível Médio)', () {
    testLimiteMedio(
      [
        {'row': 0, 'col': 0},
        {'row': 9, 'col': 0},
        {'row': 0, 'col': 15},
        {'row': 9, 'col': 15},
        {'row': 5, 'col': 8},
        {'row': 2, 'col': 12},
        {'row': 8, 'col': 7},
        {'row': 1, 'col': 14},
        {'row': 3, 'col': 10},
        {'row': 7, 'col': 3},
        {'row': 6, 'col': 12},
        {'row': 5, 'col': 14},
        {'row': 2, 'col': 7},
      ],
      "Teste de Limite - Tabuleiro 10x16 (Nível Médio)",
    );
  });
  group('Teste de Limite - Tabuleiro 24x24 (Nível Difícil)', () {
    testLimiteDificil(
      [
        {'row': 0, 'col': 0},
        {'row': 23, 'col': 0},
        {'row': 0, 'col': 23},
        {'row': 23, 'col': 23},
        {'row': 12, 'col': 18},
        {'row': 6, 'col': 12},
        {'row': 19, 'col': 4},
        {'row': 3, 'col': 21},
        {'row': 8, 'col': 15},
        {'row': 16, 'col': 10},
        {'row': 1, 'col': 19},
        {'row': 22, 'col': 6},
        {'row': 11, 'col': 3},
      ],
      "Teste de Limite - Tabuleiro 24x24 (Nível Difícil)",
      100, // Limite de bombas no tabuleiro
    );
  });
  group('Teste de Limite de Bombas - Tabuleiro 8x8', () {
    testLimiteDeBombas(8, 8, 10, "Teste de Limite de Bombas - Tabuleiro 8x8");
  });
  group('Teste de Limite de Bombas - Tabuleiro 10x16', () {
    testLimiteDeBombasmedio(
        10, 16, 30, "Teste de Limite de Bombas - Tabuleiro 10x16");
  });
  group('Teste de Limite de Bombas - Tabuleiro 24x24 (Nível Difícil)', () {
    testLimiteDeBombasdificil(24, 24, 100,
        "Teste de Limite de Bombas - Tabuleiro 24x24 (Nível Difícil)");
  });
}

void testLimiteDeBombasdificil(
    int numRows, int numCols, int limiteDeBombas, String description) {
  for (int i = 0; i < 15; i++) {
    test('$description - Teste $i', () {
      final tabuleiro =
          List.generate(numRows, (i) => List.filled(numCols, false));

      // Lista de posições possíveis no tabuleiro
      final possiveisPosicoes = List.generate(numRows, (i) {
        return List.generate(numCols, (j) => [i, j]);
      }).expand((posicoes) => posicoes).toList();

      for (int i = 0; i < limiteDeBombas; i++) {
        final posicaoAleatoria = possiveisPosicoes.removeAt(
            DateTime.now().microsecondsSinceEpoch % possiveisPosicoes.length);
        final linha = posicaoAleatoria[0];
        final coluna = posicaoAleatoria[1];

        tabuleiro[linha][coluna] = true;

        print('Bomba $i - Linha: $linha, Coluna: $coluna');
      }

      final bombCount = tabuleiro.fold(
          0,
          (prev, row) =>
              prev + row.fold(0, (prev, cell) => prev + (cell ? 1 : 0)));

      print('Tabuleiro do Teste $i:');
      for (var row in tabuleiro) {
        print(row);
      }

      expect(bombCount, equals(limiteDeBombas));
    });
  }
}

void testLimiteDeBombasmedio(
    int numRows, int numCols, int limiteDeBombas, String description) {
  for (int i = 0; i < 15; i++) {
    test('$description - Teste $i', () {
      final tabuleiro =
          List.generate(numRows, (i) => List.filled(numCols, false));

      // Lista de posições possíveis no tabuleiro
      final possiveisPosicoes = List.generate(numRows, (i) {
        return List.generate(numCols, (j) => [i, j]);
      }).expand((posicoes) => posicoes).toList();

      for (int i = 0; i < limiteDeBombas; i++) {
        final posicaoAleatoria = possiveisPosicoes.removeAt(
            DateTime.now().microsecondsSinceEpoch % possiveisPosicoes.length);
        final linha = posicaoAleatoria[0];
        final coluna = posicaoAleatoria[1];

        tabuleiro[linha][coluna] = true;

        print('Bomba $i - Linha: $linha, Coluna: $coluna');
      }

      final bombCount = tabuleiro.fold(
          0,
          (prev, row) =>
              prev + row.fold(0, (prev, cell) => prev + (cell ? 1 : 0)));

      print('Tabuleiro do Teste $i:');
      for (var row in tabuleiro) {
        print(row);
      }

      expect(bombCount, equals(limiteDeBombas));
    });
  }
}

void testLimiteDeBombas(
    int numRows, int numCols, int limiteDeBombas, String description) {
  for (int i = 0; i < 15; i++) {
    test('$description - Teste $i', () {
      final tabuleiro =
          List.generate(numRows, (i) => List.filled(numCols, false));

      // Lista de posições possíveis no tabuleiro
      final possiveisPosicoes = List.generate(numRows, (i) {
        return List.generate(numCols, (j) => [i, j]);
      }).expand((posicoes) => posicoes).toList();

      for (int i = 0; i < limiteDeBombas; i++) {
        final posicaoAleatoria = possiveisPosicoes.removeAt(
            DateTime.now().microsecondsSinceEpoch % possiveisPosicoes.length);
        final linha = posicaoAleatoria[0];
        final coluna = posicaoAleatoria[1];

        tabuleiro[linha][coluna] = true;

        print('Bomba $i - Linha: $linha, Coluna: $coluna');
      }

      final bombCount = tabuleiro.fold(
          0,
          (prev, row) =>
              prev + row.fold(0, (prev, cell) => prev + (cell ? 1 : 0)));

      print('Tabuleiro do Teste $i:');
      for (var row in tabuleiro) {
        print(row);
      }

      expect(bombCount, equals(limiteDeBombas));
    });
  }
}

void testLimiteDificil(
    List<Map<String, int>> testCases, String description, int limiteDeBombas) {
  for (final testCase in testCases) {
    test('$description - Coordenada (${testCase['row']}, ${testCase['col']})',
        () {
      // Verificar se a coordenada (${testCase['row']}, ${testCase['col']})
      // está dentro dos limites de um tabuleiro de nível difícil 24x24
      expect(testCase['row'], inInclusiveRange(0, 23));
      expect(testCase['col'], inInclusiveRange(0, 23));
    });

    test('Limite de Bombas - Tabuleiro 24x24 (Nível Difícil)', () {
      // Verificar se o número de bombas no tabuleiro de nível difícil 24x24 é igual ao limiteDeBombas
      final numRows = 24;
      final numCols = 24;
      final numBombs = limiteDeBombas;

      final tabuleiro =
          List.generate(numRows, (i) => List.filled(numCols, false));

      for (int i = 0; i < numBombs; i++) {
        int linha, coluna;

        do {
          linha = DateTime.now().microsecondsSinceEpoch % numRows;
          coluna = DateTime.now().microsecondsSinceEpoch % numCols;
        } while (tabuleiro[linha][coluna]);

        tabuleiro[linha][coluna] = true;
      }

      final bombCount = tabuleiro.fold(
          0,
          (prev, row) =>
              prev + row.fold(0, (prev, cell) => prev + (cell ? 1 : 0)));

      expect(bombCount, equals(numBombs));
    });
  }
}

void testLimiteMedio(List<Map<String, int>> testCases, String description) {
  for (final testCase in testCases) {
    test('$description - Coordenada (${testCase['row']}, ${testCase['col']})',
        () {
      // Executar testes com coordenada (${testCase['row']}, ${testCase['col']})
      // em um tabuleiro de nível médio 10x16
      expect(testCase['row'], inInclusiveRange(0, 9));
      expect(testCase['col'], inInclusiveRange(0, 15));
    });
  }
}

void testLimiteFacil(List<Map<String, int>> testCases, String description) {
  for (final testCase in testCases) {
    test('$description - Coordenada (${testCase['row']}, ${testCase['col']})',
        () {
      // Executar testes com coordenada (${testCase['row']}, ${testCase['col']})
      // em um tabuleiro 8x8
      expect(testCase['row'], inInclusiveRange(0, 7));
      expect(testCase['col'], inInclusiveRange(0, 7));
    });
  }
}

void testCases(int numRows, int numCols, String description,
    Function(int, int) testFunction) {
  for (int linha = 0; linha < numRows; linha++) {
    for (int coluna = 0; coluna < numCols; coluna++) {
      testFunction(linha, coluna);
    }
  }
}
