import "dart:io";
//import 'dart:html';

import "package:calendar_manager/models/EventModel.dart";

class Util {
  static void fromCSVToJSON() {
    //var request = await HttpRequest.request("../files/horario-exemplo.csv");
    //var response = request.response;
    //String data = File("../files/horario-exemplo.csv").readAsStringSync();
    Stopwatch stopwatch = Stopwatch()..start();
    String data = File(
            "C:/Users/lcvia/OneDrive/Documentos/GitHub/ES-2023-2Sem-Quarta-Feira-LEI-GrupoG/assets/files/horario-exemplo.csv")
        .readAsStringSync();
    List<Event> events = csvToEventsList(data);

    String jsonString = "";

    jsonString = events.map((e) => e.toJson()).join(",\n");
    jsonString = '{ "events": [$jsonString] }';

    File jsonFile = File(
        "C:/Users/lcvia/OneDrive/Documentos/GitHub/ES-2023-2Sem-Quarta-Feira-LEI-GrupoG/assets/files/events.json");

    jsonFile.writeAsStringSync(jsonString);
    stopwatch.stop();
    print('Time elapsed: ${stopwatch.elapsedMilliseconds} milliseconds');
  }

  static List<Event> csvToEventsList(String data) {
    List<Event> events = [];
    List<String> eventsStrings = data.split("\n");
    for (int i = 1; i < eventsStrings.length; i++) {
      events.add(Event.fromCSV(eventsStrings[i]));
    }
    return events;
  }
}
