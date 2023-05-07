import 'package:calendar_manager/models/event_model.dart';
import 'package:calendar_manager/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  List<Event>? overlapped;

  EventDataSource(List<Event> source) {
    appointments = source;
    overlapped = [];
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
      return e != appointments![index] &&
          ((appointments![index].getEventStart() as DateTime).isInBetween(
                  (e.getEventStart() as DateTime), //not inclusive
                  (e.getEventEnd() as DateTime)) ||
              (appointments![index].getEventEnd() as DateTime).isInBetween(
                  (e.getEventStart() as DateTime), //not inclusive
                  (e.getEventEnd() as DateTime)) ||
              appointments![index].getEventEnd() == e.getEventEnd() ||
              appointments![index].getEventStart() == e.getEventStart());
    })) {
      print(overlapped?.length);
      overlapped?.add(appointments![index]);
      print(overlapped?.length);
      return Colors.red;
    }
    return Colors.green;
  }
}
