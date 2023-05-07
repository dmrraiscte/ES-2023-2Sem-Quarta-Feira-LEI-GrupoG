import 'package:calendar_manager/models/event_data_source.dart';
import 'package:calendar_manager/models/event_model.dart';
import 'package:calendar_manager/models/events_file_model.dart';
import 'package:calendar_manager/utils/conversion.dart';
import 'package:calendar_manager/utils/file.dart';
import 'package:calendar_manager/widgets.dart/filters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final CalendarController _calendarController = CalendarController();
  var eventsFile = EventsFile("", [], -1);
  List<Event> selectedEventsFinalList = <Event>[];

  @override
  initState() {
    super.initState();

    _calendarController.displayDate = DateTime(2022, 02, 05);
  }

  EventDataSource? eventDataSource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Construtor de Calendario')),
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
                  selectedEventsFinalList = lst;
                  populateCalendar(lst);
                });
              },
            ),
            getPresentingWidget(),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (selectedEventsFinalList.isNotEmpty) downloadCalendarButtons(),
          uploadCalendarButtons(),
        ],
      ),
    );
  }

  PopupMenuButton<dynamic> downloadCalendarButtons() {
    return PopupMenuButton(
        icon: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).primaryColor)),
          child: const Icon(CupertinoIcons.floppy_disk),
        ),
        iconSize: 40,
        tooltip: "",
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: const Text("Gravar em CSV"),
              onTap: () async {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  var name =
                      await popUpMenu(context, "Nome do ficheiro a guardar");
                  name != null
                      ? await File.saveFile(
                          Conversion.eventsToCsv(selectedEventsFinalList),
                          Formato.csv,
                          name)
                      : await File.saveFile(
                          Conversion.eventsToCsv(selectedEventsFinalList),
                          Formato.csv);
                });
              },
            ),
            PopupMenuItem(
              child: const Text("Gravar em JSON"),
              onTap: () async {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  var name =
                      await popUpMenu(context, "Nome do ficheiro a guardar");
                  name != null
                      ? await File.saveFile(
                          Conversion.eventsToJson(selectedEventsFinalList),
                          Formato.json,
                          name)
                      : await File.saveFile(
                          Conversion.eventsToJson(selectedEventsFinalList),
                          Formato.json);
                });
              },
            )
          ];
        });
  }

  PopupMenuButton<dynamic> uploadCalendarButtons() {
    return PopupMenuButton(
      tooltip: "",
      icon: eventsFile.lstEvents.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  shape: BoxShape.circle),
              child: const Center(
                  child: Icon(
                CupertinoIcons.plus,
              )),
            )
          : Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  shape: BoxShape.circle),
              child: const Center(
                  child: Icon(
                CupertinoIcons.plus,
              )),
            )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                  begin: const Offset(1.4, 1.4),
                  end: const Offset(2, 2),
                  duration: const Duration(milliseconds: 1500)),
      itemBuilder: (BuildContext context) {
        //TODO: Adicionar os outros métodos de import e chamar
        return [
          PopupMenuItem(
            child: const Text("Importar ficheiro de url"),
            onTap: () async {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                var url = await popUpMenu(context, "URL do ficheiro");
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
    );
  }

  Expanded getPresentingWidget() {
    Widget presentor;
    if (eventsFile.lstEvents.isEmpty) {
      presentor = noSourceInfo("selectfile");
    } else if (eventDataSource == null) {
      presentor = noSourceInfo("selectsubjects");
    } else {
      presentor = Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
        child: SfCalendar(
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
        ),
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

  Future<dynamic> popUpMenu(BuildContext context, String showingText) {
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
            title: Text(showingText),
            content: TextField(
              controller: urlController,
            ),
          );
        });
  }

  void startFilters(EventsFile data) {
    clearCalendar();
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
