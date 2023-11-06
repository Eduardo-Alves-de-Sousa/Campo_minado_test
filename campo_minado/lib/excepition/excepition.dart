class InputInvalidoException implements Exception {
  final String message;

  InputInvalidoException(this.message);

  @override
  String toString() {
    return 'Erro de entrada inválida: $message';
  }
}
