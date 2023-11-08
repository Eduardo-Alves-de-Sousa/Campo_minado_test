import 'package:campo_minado/campo_minado.dart';
import 'package:campo_minado/excepition/jogador_exception.dart';

class Jogador extends Game {
  List<String> historicoDeAcoes = [];

  Jogador() : super();

  void iniciarJogo() {
    super.init();
    historicoDeAcoes.clear(); // Limpa o histórico ao iniciar um novo jogo.
  }

  // Marca a célula com uma bandeira
  // Lança exceções em caso de posições inválidas ou ações proibidas
  void marcarComBandeira(int linha, int coluna) {
    if (linha < 0 ||
        linha >= getBoard().length ||
        coluna < 0 ||
        coluna >= getBoard()[0].length) {
      throw PosicaoForaDosLimitesException();
    }

    if (getBoard()[linha][coluna] == 'D') {
      throw ZonaDescobertaComBandeiraException();
    }

    if (getBoard()[linha][coluna] == 'F') {
      throw BandeiraJaMarcadaException();
    }

    getBoard()[linha][coluna] = 'F'; // 'F' representa uma bandeira
  }

  // Verifica se o jogador ganhou o jogo, marcando todas as minas com bandeiras
  bool verificarGanharJogo() {
    int bombCount = getBombCount();
    int totalFlags = getTotalFlagCount();

    if (bombCount == totalFlags) {
      // Todas as minas foram marcadas com bandeiras
      for (int linha = 0; linha < getBoard().length; linha++) {
        for (int coluna = 0; coluna < getBoard()[0].length; coluna++) {
          if (getBoard()[linha][coluna] != 'X' &&
              !estaDescoberta(linha, coluna)) {
            // Encontrou uma célula que não é uma mina e não foi revelada
            return false;
          }
        }
      }
      return true; // Todas as outras células estão reveladas
    }
    return false; // Não há bandeiras em todas as minas
  }

  // Verifica se uma célula tem uma bandeira marcada
  bool temBandeira(int linha, int coluna) {
    if (linha >= 0 &&
        linha < getBoard().length &&
        coluna >= 0 &&
        coluna < getBoard()[0].length) {
      // Verifica se há uma bandeira na posição (linha, coluna)
      return getBoard()[linha][coluna] == 'F'; // 'F' representa uma bandeira
    }
    return false;
  }

  // Remove uma bandeira de uma célula
  void removerBandeira(int linha, int coluna) {
    if (linha >= 0 &&
        linha < getBoard().length &&
        coluna >= 0 &&
        coluna < getBoard()[0].length) {
      // Remove a bandeira da zona na posição (linha, coluna)
      getBoard()[linha][coluna] = 'O'; // 'O' representa uma célula não revelada
    }
  }

  // Verifica se o jogador ganhou o jogo, marcando todas as minas com bandeiras
  bool isGameWon() {
    for (int linha = 0; linha < getBoard().length; linha++) {
      for (int coluna = 0; coluna < getBoard()[0].length; coluna++) {
        if (getBoard()[linha][coluna] == 'X' && !temBandeira(linha, coluna)) {
          return false;
        }
      }
    }
    return true;
  }

  // Marca uma zona como descoberta
  void descobrirZona(int linha, int coluna) {
    if (linha >= 0 &&
        linha < getBoard().length &&
        coluna >= 0 &&
        coluna < getBoard()[0].length) {
      // Verifica se a zona não está marcada com bandeira
      if (getBoard()[linha][coluna] != 'F') {
        // Marca a zona como descoberta
        getBoard()[linha][coluna] = 'D'; // 'D' representa zona descoberta
      }
    }
  }

  // Verifica se uma zona está descoberta
  bool estaDescoberta(int linha, int coluna) {
    if (linha >= 0 &&
        linha < getBoard().length &&
        coluna >= 0 &&
        coluna < getBoard().length) {
      // Verifica se a zona está descoberta
      return getBoard()[linha][coluna] == 'D'; // 'D' representa zona descoberta
    }
    return false;
  }

  // Retorna o número total de minas no tabuleiro
  int getBombCount() {
    int bombCount = 0;

    for (int linha = 0; linha < getBoard().length; linha++) {
      for (int coluna = 0; coluna < getBoard()[0].length; coluna++) {
        if (getBoard()[linha][coluna] == 'X') {
          bombCount++;
        }
      }
    }

    return bombCount;
  }

  // Retorna o número total de bandeiras marcadas no tabuleiro
  int getTotalFlagCount() {
    int totalFlags = 0;

    for (int linha = 0; linha < getBoard().length; linha++) {
      for (int coluna = 0; coluna < getBoard()[0].length; coluna++) {
        if (getBoard()[linha][coluna] == 'F') {
          totalFlags++;
        }
      }
    }

    return totalFlags;
  }

  // Adiciona uma ação ao histórico de ações do jogador
  void adicionarAcaoAoHistorico(String acao) {
    historicoDeAcoes.add(acao);
  }

  // Obtém o histórico de ações do jogador
  List<String> obterHistoricoDeAcoes() {
    return List.from(historicoDeAcoes);
  }

  // Conta o número de bandeiras marcadas no tabuleiro
  int contarBandeirasMarcadas() {
    int count = 0;
    for (int linha = 0; linha < getBoard().length; linha++) {
      for (int coluna = 0; coluna < getBoard()[0].length; coluna++) {
        if (getBoard()[linha][coluna] == 'F') {
          count++;
        }
      }
    }
    return count;
  }

  // Remove todas as bandeiras marcadas no tabuleiro
  void limparTodasBandeiras() {
    for (int linha = 0; linha < getBoard().length; linha++) {
      for (int coluna = 0; coluna < getBoard()[0].length; coluna++) {
        if (getBoard()[linha][coluna] == 'F') {
          getBoard()[linha][coluna] =
              'O'; // 'O' representa uma célula não revelada
        }
      }
    }
  }

  void desmarcarBandeira(int linha, int coluna) {}
}
