import 'package:calendar_manager/models/event_model.dart';
import 'package:calendar_manager/utils/file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getEventsFromURL() - test with non CSV/JSON file', () async {
    List<Event> list = await File.getEventsFromUrl(
        'https://filesamples.com/samples/document/txt/sample3.txt');
    expect(list.length, 0);
  });

  test('getEventsFromURL() - test with CSV file', () async {
    List<Event> list = await File.getEventsFromUrl(
        'https://raw.githubusercontent.com/dmrraiscte/ES-2023-2Sem-Quarta-Feira-LEI-GrupoG/main/assets/files/horario-exemplo.csv');
    expect(list.length, 26019);
  });

  test('getEventsFromURL() - test with JSON file', () async {
    List<Event> list = await File.getEventsFromUrl(
        'https://raw.githubusercontent.com/dmrraiscte/ES-2023-2Sem-Quarta-Feira-LEI-GrupoG/main/assets/files/events.json');
    expect(list.length, 26019);
  });

  test('getEventsFromURL() - test with bad webpage', () async {
    List<Event> list = await File.getEventsFromUrl(
        'https://github.com/dmrraiscte/ES-2023-2Sem-Quarta-Feira-LEI-GrupoG/testeBadPageErrorCode');
    expect(list.length, 0);
  });
}
