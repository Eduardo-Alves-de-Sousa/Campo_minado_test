class InvalidBoardSizeException implements Exception {
  final String message;

  InvalidBoardSizeException(this.message);

  @override
  String toString() {
    return message;
  }
}

class GameOverException implements Exception {
  final String message;

  GameOverException(this.message);

  @override
  String toString() {
    return message;
  }
}

class GameLostException implements Exception {
  final String message;

  GameLostException(this.message);

  @override
  String toString() {
    return message;
  }
}
