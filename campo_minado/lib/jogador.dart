import 'package:campo_minado/campo_minado.dart';

class Jogador extends Game {
  Jogador() : super();

  void iniciarJogo() {
    super.init();
  }

  void marcarComBandeira(int linha, int coluna) {
    if (linha >= 0 &&
        linha < getBoard().length &&
        coluna >= 0 &&
        coluna < getBoard()[0].length) {
      // Marca a zona com uma bandeira na posição (linha, coluna)
      if (getBoard()[linha][coluna] != 'F') {
        getBoard()[linha][coluna] =
            'F'; // Supondo que 'F' representa uma bandeira
      } else {
        getBoard()[linha][coluna] =
            'O'; // Remove a bandeira se já estiver marcada
      }
    }
  }

  bool temBandeira(int linha, int coluna) {
    if (linha >= 0 &&
        linha < getBoard().length &&
        coluna >= 0 &&
        coluna < getBoard()[0].length) {
      // Verifica se há uma bandeira na posição (linha, coluna)
      return getBoard()[linha][coluna] ==
          'F'; // Supondo que 'F' representa uma bandeira
    }
    return false;
  }

  void removerBandeira(int linha, int coluna) {
    if (linha >= 0 &&
        linha < getBoard().length &&
        coluna >= 0 &&
        coluna < getBoard()[0].length) {
      // Remove a bandeira da zona na posição (linha, coluna)
      getBoard()[linha][coluna] =
          'O'; // Supondo que 'O' representa uma célula não revelada
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
}
