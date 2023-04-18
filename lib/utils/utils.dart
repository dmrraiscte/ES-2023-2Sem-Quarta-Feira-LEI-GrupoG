import 'dart:convert';
import 'dart:typed_data';
import 'package:calendar_manager/models/event_model.dart';
import 'package:file_picker/file_picker.dart';
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
    }

    if (numEvent > 0) {
      var evento = Event.fromJson(aux["events"][numEvent - 1]);
      csvData += evento.toCSV();
      events.add(evento);
    }
    return Tuple2(csvData, events);
  }

  /// __Returns a List\<Event\> from file ['csv', 'json'].__
  ///
  /// * Open default system dialog to pick a file with the allowed extensions ['csv', 'json'].
  /// * Converts it to List<Event>
  /// * If the chosen file doesn't contain a valid extension, an empty list is returned.
  ///
  /// ```dart
  /// ElevatedButton.icon(
  ///    onPressed: () async {
  ///       await Util.getEventsFromFile();
  ///    },
  ///  icon: const Icon(CupertinoIcons.tray_arrow_down_fill),
  ///  label: const Text("Escolher ficheiro")),
  /// ```
  static Future<List<Event>> getEventsFromFile() async {
    var allowedExtensions = ['csv', 'json'];
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: allowedExtensions);

    if (result != null) {
      PlatformFile file = result.files.first;
      if (allowedExtensions.contains(file.extension)) {
        var data = utf8.decode(file.bytes!);
        switch (file.extension) {
          case 'csv':
            return Util.fromCSVToJSON(data).item2;
          case 'json':
            return Util.fromJsonToCSV(data).item2;
        }
      }
    }
    return <Event>[];
  }

  /// __Returns a List\<Event\> from [url] file.__
  ///
  /// * Makes an HTTP GET request at given [url], downloads the file and converts it to List<Event>.
  /// * If HTTP request fails, it returns an empty List\<Event\>.
  ///
  /// ```dart
  /// ElevatedButton(
  ///   onPressed: () {
  ///     Util.getEventsFromUrl(urlString);
  ///   },
  ///   child: const Text('Submit'),
  /// )
  /// ```
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

  ///
  ///__Save a file in a default path with a specified formate from a String__
  ///
  ///``` dart
  /// onPressed: () {
  ///           var txt = Util.eventsToJson(List<Events>);
  ///           Util.saveFile(txt, (Formato.json or Formato.csv) );
  /// }
  ///```
  static Future<void> saveFile(String fileText, Formato formato) async {
    await FileSaver.instance.saveFile(
        name: 'calendar.${formato.name}',
        ext: formato.name,
        bytes: Uint8List.fromList(utf8.encode(fileText)));
  }

  ///
  ///__Returns a String in a JSON Formate from a List<Event>.__
  ///
  ///  * First part of the String will be the JSON Header, followed by all events in JSON formate
  ///
  static String eventsToJson(List<Event> events) {
    String json = '{ "events": [';
    json += '${events.map((e) => e.toJson()).join(",\n")}]}';
    return json;
  }

  ///
  ///__Returns a String in a CSV Formate from a List<Event>.__
  ///
  ///  * First line of the String will be the CSV Header, followed by all events in CSV formate
  ///
  static String eventsToCsv(List<Event> events) {
    String csv = Event.csvHeader;
    csv += events.map((e) => e.toCSV()).join("\n");
    return csv;
  }
}
