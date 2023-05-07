import 'package:calendar_manager/models/event_model.dart';
import 'package:calendar_manager/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tuple/tuple.dart';

class EventDataSource extends CalendarDataSource {
  List<Tuple2<Event, Event>> overlapped = [];

  EventDataSource(List<Event> source) {
    appointments = source;
    appointments?.asMap().forEach((index, element) {
      getColor(index);
    });
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].getEventStart();
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].getEventEnd();
  }

  @override
  String getSubject(int index) {
    return appointments![index].getDescription();
  }

  @override
  Color getColor(int index) {
    if (appointments!.any((e) {
      var aux = (e != appointments![index] &&
          ((appointments![index].getEventStart() as DateTime).isInBetween(
                  (e.getEventStart() as DateTime), //not inclusive
                  (e.getEventEnd() as DateTime)) ||
              (appointments![index].getEventEnd() as DateTime).isInBetween(
                  (e.getEventStart() as DateTime), //not inclusive
                  (e.getEventEnd() as DateTime)) ||
              appointments![index].getEventEnd() == e.getEventEnd() ||
              appointments![index].getEventStart() == e.getEventStart()));
      if (aux == true) addToList(appointments![index], e);
      return aux;
    })) {
      return Colors.red;
    }
    return Colors.green;
  }

  ///__Adds a Tuple2 containing input events [e1], [e2] to the List\<Tuple2\<Event, Event\>\> overlapped containing overlapping events__
  ///
  ///Conditions to the addition:
  /// * The list doesn't contain the Tuple2\<[e1] ,[e2]\>;
  /// * The list doesn't contain the Tuple2\<[e2] ,[e1]\>;
  ///
  void addToList(Event e1, Event e2) {
    if (!overlapped.contains(Tuple2(e2, e1)) &&
        !overlapped.contains(Tuple2(e1, e2))) {
      overlapped.add(Tuple2(e1, e2));
    }
  }
}
