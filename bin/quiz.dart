import 'dart:convert';
import 'dart:io';

void main() async {
  List<String> notes = <String>[];

  void menu() {
    showHeader();

    String command = getCommand();

    switch (command) {
      case "1":
      notes = addNote(notes);
      menu();

      case "2":
      showNotes(notes);
      menu();

      case "3":
      break;
    }
  }
  notes = await readFile();

  menu();

  await writeFile(notes);
  print("Volte sempre!!");

}

String getCommand() {
  List<String> commands = <String>["1", "2", "3"];

  print("Digite um comando: 1 - Adicionar nota, 2 - Listar notas, 3 - Sair");
  String? command = stdin.readLineSync();

  if (!commands.contains(command)) {
    print("Comando não encontrado");
    getCommand();
  }

  if (command != null) {
    return command;
  }

  return "2";
}

void showNotes(List<String> notes) {
  for (var i = 0; i < notes.length; i++) {
    print(notes[i]);
  }
}

Future<void> writeFile(List<String> notes) async {
  final filename = "notes.txt";
  String line = "";
  for (var element in notes) {
    line = "$line$element\n";
  }
  await File(filename).writeAsString(line);
}

Future<List<String>> readFile() async {
  final filename = "notes.txt";
  List<String> notes = <String>[];
  Stream<String> content = File(filename).openRead().transform(utf8.decoder).transform(LineSplitter());
  try {
    await for (String line in content) {
      notes.add(line);
    }
  } catch (e) {
    print("Error: $e");
  }
  return notes;
}

void showHeader() {
  // https://patorjk.com/software/taag/#p=display&c=echo&f=Bloody&t=Notes

  print("");
  print("");
  print(" ███▄    █  ▒█████  ▄▄▄█████▓▓█████   ██████ ");
  print(" ██ ▀█   █ ▒██▒  ██▒▓  ██▒ ▓▒▓█   ▀ ▒██    ▒ ");
  print("▓██  ▀█ ██▒▒██░  ██▒▒ ▓██░ ▒░▒███   ░ ▓██▄   ");
  print("▓██▒  ▐▌██▒▒██   ██░░ ▓██▓ ░ ▒▓█  ▄   ▒   ██▒");
  print("▒██░   ▓██░░ ████▓▒░  ▒██▒ ░ ░▒████▒▒██████▒▒");
  print("░ ▒░   ▒ ▒ ░ ▒░▒░▒░   ▒ ░░   ░░ ▒░ ░▒ ▒▓▒ ▒ ░");
  print("░ ░░   ░ ▒░  ░ ▒ ▒░     ░     ░ ░  ░░ ░▒  ░ ░");
  print("   ░   ░ ░ ░ ░ ░ ▒    ░         ░   ░  ░  ░  ");
  print("         ░     ░ ░              ░  ░      ░  ");
  print("");
  print("");
}

List<String> addNote(List<String> notes) {
  List<String> commands = <String>["y", "n"];

  print("Escreva sua nota");
  print("");
  String? note = stdin.readLineSync();
  print("");
  if (note == null || note.isEmpty) {
    print("Não é possível adicionar uma nota vazia");
  }

  notes.add(note!);

  print("Deseja adicionar outra nota?");
  print("");
  print("y - Sim, n - Não");
  print("");
  String? command = stdin.readLineSync();

  if (commands.contains(command)) {
    switch (command) {
      case "y":
      addNote(notes);

      case "n":
      break;
    }
  }

  return notes;
}
