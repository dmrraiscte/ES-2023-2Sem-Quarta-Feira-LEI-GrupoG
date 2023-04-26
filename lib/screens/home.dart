import 'package:calendar_manager/models/event_data_source.dart';
import 'package:calendar_manager/utils/file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/event_model.dart';

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
      appBar: AppBar(),
      body: Center(
        child: eventDataSource == null
            ? const Text(
                "Sem dados a apresentar.\nPara importar um calendário, clica no + no canto inferior direito.",
                textAlign: TextAlign.center,
              )
            : SfCalendar(
                dataSource: eventDataSource,
                view: CalendarView.week,
                timeSlotViewSettings: const TimeSlotViewSettings(startHour: 6),
              ),
      ),
      floatingActionButton: PopupMenuButton(
        tooltip: "",
        icon: const Icon(CupertinoIcons.plus),
        itemBuilder: (BuildContext context) {
          //TODO: Adicionar os outros métodos de import e chamar o populateCalendar com a listagem desejada
          return [
            PopupMenuItem(
              child: const Text("Importar por ficheiro local"),
              onTap: () async {
                var data = await File.getEventsFromFile();
                if (data.lstEvents.isNotEmpty) {
                  populateCalendar(data.lstEvents);
                }
              },
            ),
          ];
        },
      ),
    );
  }

  void populateCalendar(List<Event> list) {
    setState(() {
      eventDataSource = EventDataSource(list);
    });
  }

  void clearCalendar() {
    setState(() {
      eventDataSource = null;
    });
  }
}
