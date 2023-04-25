import 'package:calendar_manager/utils/conversion.dart';
import 'package:file_picker/file_picker.dart';
import 'package:calendar_manager/models/event_model.dart';
import 'package:http/http.dart';
import 'package:file_saver/file_saver.dart';
import 'dart:convert';
import 'dart:typed_data';

class File {
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
    //TODO: considerar mudar as extensões para incluir .ics
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
  /// * Uses [getFileData] funtction to make HTTP requests and converts responseto List<Event>.
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
    url = url.contains('webcal') ? url.replaceFirst('webcal', 'https') : url;
    var response = await getFileData(url);
    List<Event> lista = [];
    if (response.statusCode == 200) {
      switch (urlFileType(response.body)) {
        case 'json':
          lista = Util.fromJsonToCSV(response.body).item2;
          break;
        case 'csv':
          lista = Util.csvToEventsList(response.body);
          break;
        case 'ics':
          //TODO: codigo para conversão, é preciso implementar a conversão em conversion.dart
          break;
        default:
          return lista;
      }
    }
    return lista;
  }

  //TODO: fazer documentação e testes
  static String urlFileType(String responseBody) {
    String fileType = 'Invalid';
    if (isJsonFormat(responseBody)) {
      fileType = 'json';
    } else if (isCsvFormat(responseBody)) {
      fileType = 'csv';
    } else if (isICalendarFormat(responseBody)) {
      fileType = 'ics';
    }
    return fileType;
  }

  //TODO: fazer documentação e testes
  static bool isJsonFormat(String text) {
    try {
      jsonDecode(text);
      return true;
    } catch (e) {
      return false;
    }
  }

  //TODO: fazer documentação e testes
  static bool isCsvFormat(String text) {
    int le = Event.csvHeader.split(',').length;
    for (var e in text.split('\n')) {
      if (e.split(',').length != le) {
        return false;
      }
    }
    return true;
  }

  //TODO: fazer documentação e testes
  static bool isICalendarFormat(String text) {
    return RegExp(r'^BEGIN:VCALENDAR\r\n').hasMatch(text);
  }

  /// __Returns a Response (http object) from [url] file.__
  ///
  /// * Makes an HTTP GET request at given [url], downloads the file and returns the response
  static Future<Response> getFileData(String url) async {
    var header = {'Access-Control-Allow-Origin': '*'};
    var response = await get(Uri.parse(url), headers: header);
    return response;
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
}
