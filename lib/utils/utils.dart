import 'dart:convert';
import 'package:calendar_manager/models/event_model.dart';
import 'package:tuple/tuple.dart';

class Util {
  static Tuple2<String, List<Event>> fromJsonToCSV(String jsonString) {
    final aux = json.decode(jsonString);
    List<Event> events = [];
    String csvData = Event.csvHeader;

    for (int i = 0; i < aux["events"].length; i++) {
      var evento = Event.fromJson(aux["events"][i]);
      events.add(evento);
      i == aux["events"].length-1 ? csvData += evento.toCSV() : csvData += "${evento.toCSV()}\n";
    }

    return Tuple2(csvData, events);
  }
}
