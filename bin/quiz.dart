import 'dart:io';

void main() {
  List<String> notes = <String>[];

  void menu() {
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

  menu();


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

List<String> addNote(List<String> notes) {
  List<String> commands = <String>["y", "n"];

  print("Escreva sua nota");
  String? note = stdin.readLineSync();
  if (note == null || note.isEmpty) {
    print("Não é possível adicionar uma nota vazia");
  }

  notes.add(note!);

  print("Deseja adicionar outra nota?");
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
