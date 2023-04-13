import 'dart:convert';
import 'dart:typed_data';
import 'package:calendar_manager/models/event_model.dart';
import 'package:file_saver/file_saver.dart';
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;

enum Formato { csv, json }

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
    final aux = json.decode(jsonString);
    List<Event> events = [];
    String csvData = Event.csvHeader;
    int numEvent = aux["events"].length;

    for (int i = 0; i < numEvent - 1; i++) {
      var evento = Event.fromJson(aux["events"][i]);
      events.add(evento);
      csvData += "${evento.toCSV()}\n";
      /*
      // ESTA REPETIDO, SERÁ QUE FOI ERRO NO MERGE?
      i == aux["events"].length - 1
          ? csvData += evento.toCSV()
          : csvData += "${evento.toCSV()}\n";
      i == aux["events"].length - 1
          ? csvData += evento.toCSV()
          : csvData += "${evento.toCSV()}\n";
      */
    }
    // Em vez de verificar sempre se é o final no corpo do FOR, faz apenas este IF no final.
    if (numEvent > 0) {
      var evento = Event.fromJson(aux["events"][numEvent - 1]);
      csvData += evento.toCSV();
      events.add(evento);
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

  static Future<void> saveFile(String fileText, Formato formato) async {
    await FileSaver.instance.saveFile(
        name: 'calendar.${formato.name}',
        ext: formato.name,
        bytes: Uint8List.fromList(utf8.encode(fileText)));
  }

  static String eventsToJson(List<Event> events) {
    String json = '{ "events": [';
    json += '${events.map((e) => e.toJson()).join(",\n")}]}';
    return json;
  }

  static String eventsToCsv(List<Event> events) {
    String csv = Event.csvHeader;
    csv += events.map((e) => e.toCSV()).join("\n");
    return csv;
  }
}
