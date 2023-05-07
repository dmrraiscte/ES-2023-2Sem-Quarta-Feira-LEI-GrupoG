import 'package:calendar_manager/models/event_data_source.dart';
import 'package:calendar_manager/models/event_model.dart';
import 'package:calendar_manager/models/events_file_model.dart';
import 'package:calendar_manager/utils/file.dart';
import 'package:calendar_manager/widgets.dart/filters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CalendarController _calendarController = CalendarController();
  var eventsFile = EventsFile("", [], -1);

  @override
  initState() {
    _calendarController.displayDate = DateTime(2022, 02, 05);
    super.initState();
  }

  EventDataSource? eventDataSource;
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
      body: Center(
        child: Column(
          children: [
            Filters(
              eventsLst: eventsFile.lstEvents,
              onFilterChangedList: (events) {
                setState(() {
                  populateCalendar(events);
                });
              },
            ),
            eventDataSource?.overlapped != null
                ? Text(eventDataSource!.overlapped!.length.toString())
                : const Text("nada"),
/*                ToggleButtons(
              children: <Widget>[
                Icon(Icons.format_bold),
                Icon(Icons.format_italic),
                Icon(Icons.format_underlined),
              ],
              isSelected:_selections,
              onPressed:(int index){
                setState(() {
                  _selections[index]=!_selections[index];
                })}),
*/
            Expanded(
              child: eventDataSource == null
                  ? const Text(
                      "Sem dados a apresentar.\nPara importar um calendário, clica no + no canto inferior direito.",
                      textAlign: TextAlign.center,
                    )
                  : SfCalendar(
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
                      //viewNavigationMode: ViewNavigationMode.none,

                      dataSource: eventDataSource,

                      timeSlotViewSettings:
                          const TimeSlotViewSettings(startHour: 6),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: PopupMenuButton(
        tooltip: "",
        icon: const Icon(CupertinoIcons.plus),
        itemBuilder: (BuildContext context) {
          //TODO: Adicionar os outros métodos de import e chamar
          return [
            PopupMenuItem(
              child: const Text("Importar por ficheiro local"),
              onTap: () async {
                var data = await File.getEventsFromFile();

                if (data.lstEvents.isNotEmpty) {
                  startFilters(data);
                }
              },
            ),
          ];
        },
      ),
    );
  }

  void startFilters(EventsFile data) {
    setState(() {
      eventsFile = data;
    });
  }

  void populateCalendar(List<Event> data) {
    setState(() {
      eventDataSource = EventDataSource(data);
    });
  }

  void clearCalendar() {
    setState(() {
      eventsFile = EventsFile("", [], -1);
      eventDataSource = null;
    });
  }
}
