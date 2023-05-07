import 'dart:html';

import 'package:calendar_manager/models/event_model.dart';
import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  final List<Event> eventsLst;
  final Function(List<Event>) onFilterChangedList;
  const Filters(
      {super.key, required this.eventsLst, required this.onFilterChangedList});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var tempLst = <Event>[];
  Map<String, Map<String, List<Event>>> mapEvents = {};
  String selectedUc = "";
  String selectedTurno = "";
  @override
  
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        widget.onFilterChangedList(mapEvents[selectedUc]![selectedTurno]!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (tempLst != widget.eventsLst) {
      updateMapValue();
    }
    tempLst = widget.eventsLst;
    return Row(
      children: [
        selectedUc.isEmpty
            ? Container()
            : DropdownButton(
                value: selectedUc,
                items: mapEvents.keys
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      selectedUc = val;
                      selectedTurno = mapEvents[val]!.keys.first;
                      widget.onFilterChangedList(
                          mapEvents[selectedUc]![selectedTurno]!);
                    });
                  }
                }),
        selectedUc.isEmpty
            ? Container()
            : DropdownButton(
                value: selectedTurno,
                items: mapEvents[selectedUc]!
                    .keys
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      selectedTurno = val;
                    });
                    widget.onFilterChangedList(
                        mapEvents[selectedUc]![selectedTurno]!);
                  }
                }),
      ],
    );
  }

//TODO: Check if performance can be better (should be using isolates but no can do because its running on web)
  Future<void> updateMapValue() async {
    if (widget.eventsLst.isNotEmpty) {
      selectedUc = widget.eventsLst.first.unidadeCurricular;
      selectedTurno = widget.eventsLst.first.turno;
      mapEvents = {};

      for (var uc in widget.eventsLst
          .map((e) => e.unidadeCurricular)
          .toSet()
          .toList()) {
        Map<String, List<Event>> turnoMap = {};
        for (var turno in widget.eventsLst
            .where((e) => e.unidadeCurricular == uc)
            .map((e) => e.turno)
            .toSet()
            .toList()) {
          turnoMap.addAll({
            turno: widget.eventsLst
                .where((e) => e.unidadeCurricular == uc && e.turno == turno)
                .toSet()
                .toList()
          });
        }
        mapEvents.addAll({uc: turnoMap});
      }
    }
  }

  void callback() {
    widget.onFilterChangedList(mapEvents[selectedUc]![selectedTurno]!);
  }
}
