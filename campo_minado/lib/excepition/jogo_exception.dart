// jogo_exception.dart

class InvalidInputException implements Exception {
  final String message;

  InvalidInputException(this.message);
}

class GameOverException implements Exception {
  final String message;

  GameOverException(this.message);
}

class InvalidMoveException implements Exception {
  final String message;

  InvalidMoveException(this.message);
}
