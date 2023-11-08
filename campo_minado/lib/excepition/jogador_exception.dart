class PosicaoForaDosLimitesException implements Exception {
  @override
  String toString() {
    return 'A posição está fora dos limites do tabuleiro.';
  }
}

class ZonaDescobertaComBandeiraException implements Exception {
  @override
  String toString() {
    return 'Não é possível marcar uma zona descoberta com bandeira.';
  }
}

class BandeiraJaMarcadaException implements Exception {
  @override
  String toString() {
    return 'A bandeira já está marcada na zona.';
  }
}
