import 'package:calendar_manager/models/event_model.dart';
import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  final List<Event> eventsLst;
  const Filters({super.key, required this.eventsLst});

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (tempLst != widget.eventsLst) updateMapValue();
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
                    });
                  }
                }),
        selectedUc.isEmpty
            ? Container()
            : DropdownButton(
                value: selectedTurno.isEmpty
                    ? mapEvents[selectedUc]!.keys.first
                    : selectedTurno,
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
                  }
                }),
      ],
    );
  }

  Future<void> updateMapValue() async {
    if (widget.eventsLst.isNotEmpty) {
      selectedUc = widget.eventsLst.first.unidadeCurricular;
      selectedTurno = "";
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
}
