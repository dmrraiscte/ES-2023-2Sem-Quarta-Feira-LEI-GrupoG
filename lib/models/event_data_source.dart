import 'package:calendar_manager/models/event_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source;
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

  /*@override
  Color getColor(int index) {
    return appointments![index].background;
  }
*/
}
