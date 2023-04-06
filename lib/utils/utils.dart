import "dart:io";
//import 'dart:html';

import "package:calendar_manager/models/EventModel.dart";

class Util {
  static void fromCSVToJSON() async {
    //var request = await HttpRequest.request("../files/horario-exemplo.csv");
    //var response = request.response;
    //String data = File("../files/horario-exemplo.csv").readAsStringSync();

    String data = File(
            "C:/Users/lcvia/OneDrive/Documentos/GitHub/ES-2023-2Sem-Quarta-Feira-LEI-GrupoG/lib/files/teste.csv")
        .readAsStringSync();
    List<Event> events = csvToEventsList(data);

    String jsonString = "";

    for (var i = 0; i < events.length; i++) {
      jsonString += (i == 0) ? "" : ",\n";
      jsonString += events[i].toJson();
    }

    jsonString = '{ "events": [$jsonString] }';

    File jsonFile = File(
        "C:/Users/lcvia/OneDrive/Documentos/GitHub/ES-2023-2Sem-Quarta-Feira-LEI-GrupoG/lib/files/events.json");

    jsonFile.writeAsStringSync(jsonString);
  }

  static List<Event> csvToEventsList(String data) {
    List<Event> events = [];

    List<String> eventsStrings = data.split("\n");
    List<String> event = [];
    int aux = 0;

    List<String> eventList = [];

    for (int i = 1; i < eventsStrings.length; i++) {
      print(eventsStrings[i]);
      List<String> eventNoQuotations = eventsStrings[i].split('"');
      if (eventNoQuotations.length > 1) {
        print(eventNoQuotations);
        for (var i = 0; i < eventNoQuotations.length; i++) {
          print(eventNoQuotations[i]);
          if (i % 2 == 0) {
            if (eventNoQuotations[i].startsWith(",") && i != 0) {
              aux++;
              eventNoQuotations[i] = eventNoQuotations[i]
                  .substring(1, eventNoQuotations[i].length);

              print("sup " + eventNoQuotations[i]);
            }
            if ((eventNoQuotations[i].endsWith(",") ||
                    eventNoQuotations[i].endsWith(", ")) &&
                i != eventNoQuotations.length - 1) {
              aux++;
              eventNoQuotations[i] = eventNoQuotations[i]
                  .substring(0, eventNoQuotations[i].length - 1);
              print("sup" + eventNoQuotations[i]);
            }
            if (eventNoQuotations[i] == "" && aux < 2) {
              continue;
            }

            eventList = eventNoQuotations[i].split(",");
            for (String s in eventList) {
              print("hey$s yes");
              event.add(s);
            }
/*          List<String> eventAux2 = eventAux[i].split(",");
          print("sup $eventAux2");
          for (String s in eventAux2) {
            print("hey$s yes");
            event.add(s);
          }*/
          } else {
            event.add(eventNoQuotations[i]);
          }
          aux = 0;
        }
      } else {
        List<String> eventList = eventNoQuotations[0].split(",");
        for (String s in eventList) {
          event.add(s);
        }
      }

/*          List<String> eventAux2 = eventAux[i].split(",");
          print("sup $eventAux2");
          for (String s in eventAux2) {
            print("hey$s yes");
            event.add(s);
          }*/

      //List<String> event = eventsString[i].split(",");

      //strings use ""
      //json int use :null
      print(event);
      if (event[10].trim() == "" ||
          event[10] == ' \n' ||
          event[10].isEmpty ||
          event[10] == null) {
        event[10] = "0";
      }
      if (event[4] == "" || event[4] == " ") {
        event[4] = "0";
      }
      events.add(Event(
          event[0],
          event[1],
          event[2],
          event[3],
          int.parse(event[4]),
          event[5],
          event[6],
          event[7],
          event[8],
          event[9].replaceAll('"', ''),
          int.parse(event[10])));
      event = [];
    }

    return events;
  }
}
