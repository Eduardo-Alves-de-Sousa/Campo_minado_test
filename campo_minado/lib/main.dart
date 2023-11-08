import 'dart:io';
import 'package:campo_minado/excepition/jogo_exception.dart';
import 'package:campo_minado/jogo.dart';

void main() {
  while (true) {
    print("*|-----------------------------------------------------------|*");
    print('*|Bem-vindo ao Campo Minado! Escolha um nível de dificuldade:|*');
    print("*|-----------------------------------------------------------|*");

    print('\n1 - Fácil (8x8, 10 bombas)');
    print('2 - Médio (10x16, 30 bombas)');
    print('3 - Difícil (24x24, 100 bombas)');
    print('4 - Personalizado');
    print('5 - Ver Tempos de Jogo');
    print('6 - Deletar Tempos de Jogo');
    print('7 - Sair\n');

    int choice;
    while (true) {
      stdout.write("Escolha uma opção: ");
      choice = int.tryParse(stdin.readLineSync() ?? '')!;
      if (choice >= 1 && choice <= 7) {
        break; // A escolha é válida, saia do loop
      }
      print("Escolha uma opção válida (1 a 7)!");
    }

    if (choice == 7) {
      print('Você saiu do jogo.');
      break; // Sair do jogo
    }

    int rows = 0;
    int cols = 0;
    int numBombs = 0;

    if (choice == 1) {
      rows = 8;
      cols = 8;
      numBombs = 10;
    } else if (choice == 2) {
      rows = 10;
      cols = 16;
      numBombs = 30;
    } else if (choice == 3) {
      rows = 24;
      cols = 24;
      numBombs = 100;
    } else if (choice == 4) {
      print('Digite o número de linhas: ');
      rows = int.parse(stdin.readLineSync()!);
      print('Digite o número de colunas: ');
      cols = int.parse(stdin.readLineSync()!);
      print('Digite o número de bombas: ');
      numBombs = int.parse(stdin.readLineSync()!);
    } else if (choice == 5) {
      // Opção para visualizar tempos de jogo
      _viewGameTimes();
      continue; // Volte ao menu principal
    } else if (choice == 6) {
      // Opção para deletar tempos de jogo
      _deleteGameTime();
      continue; // Volte ao menu principal
    }

    final game = Game();
    try {
      game.init(rows, cols, numBombs);

      // Declare e inicie o cronômetro
      final stopwatch = Stopwatch()..start();

      while (!game.isGameOver()) {
        print('Tabuleiro:');
        game.printBoard();
        print('\nEscolha uma ação:');
        print('1 - Revelar célula');
        print('2 - Marcar/Desmarcar célula');
        print('3 - Sair\n');
        stdout.write("Escolha uma opção: ");
        int action = int.parse(stdin.readLineSync()!);

        if (action == 3) {
          print('Você saiu do jogo.');
          break; // Sair do jogo
        } else if (action == 1) {
          print('Digite a linha (0 a ${rows - 1}): ');
          int row = int.parse(stdin.readLineSync()!);
          print('Digite a coluna (0 a ${cols - 1}): ');
          int col = int.parse(stdin.readLineSync()!);

          game.revealCell(row, col);
        } else if (action == 2) {
          print('Digite a linha (0 a ${rows - 1}): ');
          int row = int.parse(stdin.readLineSync()!);
          print('Digite a coluna (0 a ${cols - 1}): ');
          int col = int.parse(stdin.readLineSync()!);

          game.toggleFlag(row, col);
        } else {
          throw InvalidInputException('Escolha uma ação válida (1, 2 ou 3)!');
        }
      }

      // Pare o cronômetro quando o jogo terminar (ou quando desejar medir o tempo)
      stopwatch.stop();

      // Obtenha o tempo decorrido em milissegundos
      int tempoEmMilissegundos = stopwatch.elapsedMilliseconds;

      // Converta o tempo para segundos
      double tempoEmSegundos = tempoEmMilissegundos / 1000;

      // ignore: unnecessary_brace_in_string_interps
      print('Tempo de jogo: ${tempoEmSegundos} segundos');

      print('Jogo terminado!');
      bool isWinner = game.isGameOver() && !game.isGameLost();
      if (isWinner) {
        print('Você venceu!');
      } else {
        print('Você perdeu!');
      }

      _saveGameTime(tempoEmSegundos, isWinner);
    } catch (e) {
      print('Ocorreu um erro: $e');
    }
  }
}

// Função para salvar o tempo de jogo em um arquivo
void _saveGameTime(double gameTime, bool isWinner) {
  final file = File('game_times.txt');
  if (!file.existsSync()) {
    file.createSync();
  }

  final result = isWinner ? 'Vitória' : 'Derrota';
  final timeString = '${DateTime.now()}: $gameTime segundos - $result\n';

  file.writeAsStringSync(timeString, mode: FileMode.append);
}

// Função para visualizar tempos de jogo salvos
void _viewGameTimes() {
  final file = File('game_times.txt');
  if (file.existsSync()) {
    final content = file.readAsStringSync();
    print('Tempos de Jogo Registrados:');
    print(content);
  } else {
    print('Nenhum tempo de jogo registrado ainda.');
  }
}

// Função para deletar um tempo de jogo específico
void _deleteGameTime() {
  final file = File('game_times.txt');
  if (file.existsSync()) {
    final content = file.readAsStringSync();
    final lines = content.split('\n');

    if (lines.isNotEmpty) {
      print('Selecione o tempo de jogo que deseja deletar:');
      for (int i = 0; i < lines.length - 1; i++) {
        print('$i - ${lines[i]}');
      }

      stdout.write("Escolha o número do tempo a ser deletado: ");
      int? choice = int.tryParse(stdin.readLineSync() ?? '');

      if (choice! >= 0 && choice < lines.length - 1) {
        lines.removeAt(choice);
        final updatedContent = lines.join('\n');
        file.writeAsStringSync(updatedContent, mode: FileMode.write);
        print('Tempo de jogo deletado com sucesso.');
      } else {
        print('Escolha um número válido.');
      }
    } else {
      print('Nenhum tempo de jogo registrado ainda.');
    }
  } else {
    print('Nenhum tempo de jogo registrado ainda.');
  }
}
