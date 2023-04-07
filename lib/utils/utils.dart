import 'package:calendar_manager/models/event_model.dart';
import "package:tuple/tuple.dart";

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
}
