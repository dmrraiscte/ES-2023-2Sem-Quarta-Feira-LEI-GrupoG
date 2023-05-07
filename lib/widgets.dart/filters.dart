import 'package:calendar_manager/models/event_model.dart';
import 'package:calendar_manager/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Filters extends StatefulWidget {
  final List<Event> eventsLst;
  final Function(List<Event>)? onFilterChangedList;
  const Filters({super.key, required this.eventsLst, this.onFilterChangedList});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var tempLst = <Event>[];
  Map<String, Map<String, List<Event>>> mapEvents = {};
  String selectedUc = "";
  String selectedTurno = "";

  var selectedUcs = <String>[];
  var selectedTurnos = <String, String>{};
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => callback());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (tempLst != widget.eventsLst) {
      updateMapValue();
    }
    tempLst = widget.eventsLst;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Utils.getSidePadding(context), vertical: 8),
      child: GFAccordion(
        collapsedIcon: const Icon(
          Icons.filter_alt,
        ),
        expandedIcon: const Icon(Icons.filter_alt_outlined),
        collapsedTitleBackgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
        expandedTitleBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        contentBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        contentChild: mapEvents.isEmpty
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MultiSelectDialogField<String>(
                      chipDisplay: MultiSelectChipDisplay.none(),
                      buttonText: Text(selectedUcs.isEmpty
                          ? "Selecionar Unidades Curriculares"
                          : selectedUcs.length == 1 ||
                                  selectedUcs.length == 2 ||
                                  selectedUcs.length == 3
                              ? selectedUcs.join(", ")
                              : "${selectedUcs.length} UC's selecionadas"),
                      listType: MultiSelectListType.LIST,
                      searchable: true,
                      items: [
                        ...mapEvents.keys
                            .map((e) => MultiSelectItem<String>(e, e))
                            .toList(),
                        MultiSelectItem<String>("teste", "teste")
                      ],
                      title: const Text("Unidades curriculares"),
                      onConfirm: (selectedLst) {
                        setState(() {
                          selectedUcs = selectedLst;
                        });
                        callback();
                      },
                    ),
                    for (var uc in selectedUcs)
                      Flexible(
                        fit: FlexFit.loose,
                        child: GFAccordion(
                            title: uc,
                            collapsedTitleBackgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            expandedTitleBackgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            contentBackgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            contentChild: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: mapEvents[uc]!.keys.map((turno) {
                                  var isThisSelected =
                                      selectedTurnos[uc] == turno;
                                  if (turno == "exam") return Container();
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isThisSelected) {
                                            selectedTurnos.remove(uc);
                                          } else {
                                            selectedTurnos[uc] = turno;
                                          }
                                        });

                                        callback();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            color: isThisSelected
                                                ? Theme.of(context).primaryColor
                                                : Colors.transparent,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              turno,
                                              style: TextStyle(
                                                  color: isThisSelected
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            )),
                      ),
                  ],
                ),
              ),
      ),
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
        turnoMap.addAll({
          "exam": widget.eventsLst
              .where((e) => e.unidadeCurricular == uc && e.isTestOrExam())
              .toList()
        });
        mapEvents.addAll({uc: turnoMap});
      }
    }
  }

  void callback() {
    var lst = <Event>[];
    for (var entry in selectedTurnos.entries) {
      lst.addAll(mapEvents[entry.key]![entry.value]!);
    }

    for (var uc in selectedUcs) {
      lst.addAll(mapEvents[uc]!["exam"]!);
    }

    if (widget.onFilterChangedList != null) {
      widget.onFilterChangedList!(lst);
    }
  }
}
