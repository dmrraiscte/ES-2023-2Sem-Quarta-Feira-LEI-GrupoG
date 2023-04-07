import 'dart:convert';
import 'package:calendar_manager/models/event_model.dart';
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;

class Util {
  //Receives a string [data] with csv format and returns a tuple with the list of events listed in data
  // and a string with json format
  static Tuple2<String, List<Event>> fromCSVToJSON(String data) {
    List<Event> events = csvToEventsList(data);

    String jsonString = "";

    jsonString = events.map((e) => e.toJson()).join(",\n");
    jsonString = '{ "events": [$jsonString] }';

    return Tuple2(jsonString, events);
  }

//Receives a string [data] with information of events in csv pattern and returns a list of events
  static List<Event> csvToEventsList(String data) {
    List<Event> events = [];
    List<String> eventsStrings = data.split("\n");
    for (int i = 1; i < eventsStrings.length; i++) {
      events.add(Event.fromCSV(eventsStrings[i]));
    }
    return events;
  }

  static Tuple2<String, List<Event>> fromJsonToCSV(String jsonString) {

  static Tuple2<String, List<Event>> fromJsonToCSV(String jsonString) {
    final aux = json.decode(jsonString);
    List<Event> events = [];
    String csvData = Event.csvHeader;

    for (int i = 0; i < aux["events"].length; i++) {
      var evento = Event.fromJson(aux["events"][i]);
      events.add(evento);
      i == aux["events"].length - 1
          ? csvData += evento.toCSV()
          : csvData += "${evento.toCSV()}\n";
      i == aux["events"].length - 1
          ? csvData += evento.toCSV()
          : csvData += "${evento.toCSV()}\n";
    }

    return Tuple2(csvData, events);
  }

  static Future<List<Event>> getEventsFromUrl(String url) async {
    var header = {'Access-Control-Allow-Origin': '*'};
    var response = await http.get(Uri.parse(url), headers: header);
    List<Event> lista = [];
    if (response.statusCode == 200) {
      switch (url.split('.').last) {
        case 'json':
          lista = fromJsonToCSV(response.body).item2;
          break;
        case 'csv':
          lista = csvToEventsList(response.body);
          break;
        default:
          return lista;
      }
    }
    return lista;
  }
}
