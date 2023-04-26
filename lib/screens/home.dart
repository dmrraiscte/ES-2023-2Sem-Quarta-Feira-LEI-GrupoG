import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CalendarController _calendarController = CalendarController();

  @override
  initState() {
    _calendarController.displayDate = DateTime(2022, 02, 05);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Demo'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _calendarController.backward!();
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              _calendarController.forward!();
            },
          ),
        ],
      ),
      body: SfCalendar(
        view: CalendarView.month,
        allowedViews: const <CalendarView>[
          CalendarView.day,
          CalendarView.week,
          CalendarView.month,
          CalendarView.schedule
        ],
        minDate: DateTime(2021, 03, 05, 10, 0, 0),
        maxDate: DateTime(2023, 08, 25, 10, 0, 0),

        controller: _calendarController,

        showDatePickerButton: true,
        allowViewNavigation: true,
        //viewNavigationMode: ViewNavigationMode.snap,
      ),
    );
  }
}
