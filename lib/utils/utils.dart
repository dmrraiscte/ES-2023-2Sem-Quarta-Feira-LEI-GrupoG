
import 'dart:io';
import 'dart:convert';
import 'package:calendar_manager/models/EventModel.dart';
import 'package:file_picker/file_picker.dart';
class Util {

  static void fromCSVToJSON(){
    //fdsfsdfasf
  }

  static void fromJsonToCSV(File Jsonfile, String destinationPath) {
  File CSVFile = File(destinationPath);
  final aux =json.decode(Jsonfile.readAsStringSync());
  String CSVData= "Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora início da aula,Hora fim da aula,Data da aula,Sala atribuída à aula,Lotação da sala\n";

  for(int i = 0; i < aux["events"].length; i++) {
    Event evento = Event(aux["events"][i]["Curso"],
                        aux["events"][i]["Unidade Curricular"],
                        aux["events"][i]["Turno"],
                        aux["events"][i]["Turma"],
                        int.parse(aux["events"][i]["Inscritos no turno"]),
                        aux["events"][i]["Dia da semana"],
                        aux["events"][i]["Hora início da aula"],
                        aux["events"][i]["Hora fim da aula"],
                        aux["events"][i]["Data da aula"],
                        aux["events"][i]["Sala atribuída à aula"],
                        int.parse(aux["events"][i]["Lotação da sala"]));
    CSVData += evento.toCSV() + "\n";
  }
  
  CSVFile.writeAsStringSync(CSVData, encoding: utf8);
  }

}
