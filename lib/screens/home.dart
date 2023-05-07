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

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final CalendarController _calendarController = CalendarController();
  var eventsFile = EventsFile("", [], -1);
  late AnimationController _breathingController;
  var _breath = 0.0;

  @override
  initState() {
    super.initState();
    _calendarController.displayDate = DateTime(2022, 02, 05);
    _breathingController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breathingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _breathingController.forward();
      }
    });
    _breathingController.addListener(() {
      setState(() {
        _breath = _breathingController.value;
      });
    });
    _breathingController.forward();
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
              onFilterChangedList: (lst) {
                setState(() {
                  populateCalendar(lst);
                });
              },
            ),
            getPresentingWidget(),
          ],
        ),
      ),
      floatingActionButton: PopupMenuButton(
        tooltip: "",
        icon: const Material(
            color: Colors.transparent,
            shape: CircleBorder(side: BorderSide(color: Colors.black)),
            child: Icon(CupertinoIcons.plus)),
        iconSize: eventsFile.lstEvents.isEmpty ? 40 + 10 * _breath : 40,
        itemBuilder: (BuildContext context) {
          //TODO: Adicionar os outros métodos de import e chamar
          return [
            PopupMenuItem(
              child: const Text("Importar ficheiro de url"),
              onTap: () async {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  var url = await popUpMenu(context);
                  if (url != null) {
                    var data = await File.getEventsFromUrl(url.toString());
                    if (data.lstEvents.isNotEmpty) {
                      startFilters(data);
                    }
                  }
                });
              },
            ),
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

  Expanded getPresentingWidget() {
    Widget presentor;
    if (eventsFile.lstEvents.isEmpty) {
      presentor = noSourceInfo("selectfile");
    } else if (eventDataSource == null) {
      presentor = noSourceInfo("selectsubjects");
    } else {
      presentor = SfCalendar(
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

        timeSlotViewSettings: const TimeSlotViewSettings(startHour: 6),
      );
    }

    return Expanded(child: presentor);
  }

  Text noSourceInfo(String type) {
    String output = "";
    if (type == "selectsubjects") {
      output =
          "Eventos importados!\nSelecione as UC's e turnos que pretende inserir no horário.";
    }
    if (type == "selectfile") {
      output =
          "Sem dados a apresentar.\nPara importar um calendário, clicque no + no canto inferior direito.";
    }
    return Text(
      output,
      textAlign: TextAlign.center,
    );
  }

  Future<dynamic> popUpMenu(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          TextEditingController urlController = TextEditingController();
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancelar")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(urlController.text);
                  },
                  child: const Text("Submit"))
            ],
            title: const Text("Introduza o url"),
            content: TextField(
              controller: urlController,
            ),
          );
        });
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
