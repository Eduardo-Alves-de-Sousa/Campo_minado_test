import 'package:campo_minado/campo_minado.dart';
import 'package:campo_minado/excepition/jogador_exception.dart';

class Jogador extends Game {
  List<String> historicoDeAcoes = [];

  Jogador() : super();

  void iniciarJogo() {
    super.init();
    historicoDeAcoes.clear(); // Limpa o histórico ao iniciar um novo jogo.
  }

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

  void removerBandeira(int linha, int coluna) {
    if (linha >= 0 &&
        linha < getBoard().length &&
        coluna >= 0 &&
        coluna < getBoard()[0].length) {
      // Remove a bandeira da zona na posição (linha, coluna)
      getBoard()[linha][coluna] = 'O'; // 'O' representa uma célula não revelada
    }
  }

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

  void adicionarAcaoAoHistorico(String acao) {
    historicoDeAcoes.add(acao);
  }

  List<String> obterHistoricoDeAcoes() {
    return List.from(historicoDeAcoes);
  }

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
