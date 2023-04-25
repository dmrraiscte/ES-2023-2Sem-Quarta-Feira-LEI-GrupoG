import 'package:calendar_manager/models/event_data_source.dart';
import 'package:calendar_manager/utils/file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  EventDataSource? eventDataSource;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () async {
                var lst = await File.getEventsFromFile();
                setState(() {
                  eventDataSource = EventDataSource(lst);
                });
              },
              child: const Icon(CupertinoIcons.add))
        ],
      ),
      body: SfCalendar(
        dataSource: eventDataSource,
        view: CalendarView.week,
      ),
    );
  }
}
