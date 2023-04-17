import 'package:calendar_manager/models/event_model.dart';
import 'package:calendar_manager/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromCSVToJSON - String simple CSV conversion', () {
    var value = Util.fromCSVToJSON(
        """Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora inÃ­cio da aula,Hora fim da aula,Data da aula,Sala atribuÃ­da Ã  aula,LotaÃ§Ã£o da sala
ME,Teoria dos Jogos e dos Contratos,01789TP01,MEA1,30,Sex,13:00:00,14:30:00,02/12/2022,AA2.25,34
ME,Teoria dos Jogos e dos Contratos,01789TP01,MEA1,30,Qua,13:00:00,14:30:00,23/11/2022,AA2.25,34""");

    expect(value.item1,
        """{ "events": [{ "Curso": "ME", "Unidade Curricular": "Teoria dos Jogos e dos Contratos", "Turno": "01789TP01", "Turma": "MEA1", "Inscritos no turno": "30", "Dia da semana": "Sex", "Hora início da aula": "13:00:00", "Hora fim da aula": "14:30:00", "Data da aula": "02/12/2022", "Sala atribuída à aula": "AA2.25", "Lotação da sala": "34" },
{ "Curso": "ME", "Unidade Curricular": "Teoria dos Jogos e dos Contratos", "Turno": "01789TP01", "Turma": "MEA1", "Inscritos no turno": "30", "Dia da semana": "Qua", "Hora início da aula": "13:00:00", "Hora fim da aula": "14:30:00", "Data da aula": "23/11/2022", "Sala atribuída à aula": "AA2.25", "Lotação da sala": "34" }] }""");
  });

  test(
      'fromCSVToJSON - String, CSV with empty fields and quotations conversion',
      () {
    var value2 = Util.fromCSVToJSON(
        """Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora inÃ­cio da aula,Hora fim da aula,Data da aula,Sala atribuÃ­da Ã  aula,LotaÃ§Ã£o da sala
LP,CompetÃªncias AcadÃ©micas I,L5205PL05,PA3,23,Qua,11:00:00,12:30:00,14/12/2022,"2,00E+07",50
"LETI, LEI, LEI-PL, LIGE, LIGE-PL",Fundamentos de Arquitectura de Computadores,L0705TP23,"ET-A9, ET-A8, ET-A7, ET-A12, ET-A11, ET-A10",44,Sex,13:00:00,14:30:00,09/12/2022,C5.06,70
"LETI, LEI, LEI-PL",CÃ¡lculo I,03703TP02,"EI-A6, EI-A5, EI-A4, EI-A3, EI-A2, EI-A1",52,Qui,14:30:00,16:00:00,15/09/2022,,""");

    expect(value2.item1,
        """{ "events": [{ "Curso": "LP", "Unidade Curricular": "CompetÃªncias AcadÃ©micas I", "Turno": "L5205PL05", "Turma": "PA3", "Inscritos no turno": "23", "Dia da semana": "Qua", "Hora início da aula": "11:00:00", "Hora fim da aula": "12:30:00", "Data da aula": "14/12/2022", "Sala atribuída à aula": "2,00E+07", "Lotação da sala": "50" },
{ "Curso": "LETI, LEI, LEI-PL, LIGE, LIGE-PL", "Unidade Curricular": "Fundamentos de Arquitectura de Computadores", "Turno": "L0705TP23", "Turma": "ET-A9, ET-A8, ET-A7, ET-A12, ET-A11, ET-A10", "Inscritos no turno": "44", "Dia da semana": "Sex", "Hora início da aula": "13:00:00", "Hora fim da aula": "14:30:00", "Data da aula": "09/12/2022", "Sala atribuída à aula": "C5.06", "Lotação da sala": "70" },
{ "Curso": "LETI, LEI, LEI-PL", "Unidade Curricular": "CÃ¡lculo I", "Turno": "03703TP02", "Turma": "EI-A6, EI-A5, EI-A4, EI-A3, EI-A2, EI-A1", "Inscritos no turno": "52", "Dia da semana": "Qui", "Hora início da aula": "14:30:00", "Hora fim da aula": "16:00:00", "Data da aula": "15/09/2022", "Sala atribuída à aula": "", "Lotação da sala": "" }] }""");
  });

  test('fromCSVToJSON - List of Events ', () {
    var value = Util.fromCSVToJSON(
        """Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora inÃ­cio da aula,Hora fim da aula,Data da aula,Sala atribuÃ­da Ã  aula,LotaÃ§Ã£o da sala
ME,Teoria dos Jogos e dos Contratos,01789TP01,MEA1,30,Sex,13:00:00,14:30:00,02/12/2022,AA2.25,34
"LETI, LEI, LEI-PL",CÃ¡lculo I,03703TP02,"EI-A6, EI-A5, EI-A4, EI-A3, EI-A2, EI-A1",52,Qui,14:30:00,16:00:00,15/09/2022,,""");
    expect(value.item2.length, 2);
    expect(value.item2[0].curso, "ME");
    expect(value.item2[1].lotacaoSala, "");
    expect(value.item2[1].curso, "LETI, LEI, LEI-PL");
  });
  test('fromCSVToJSON - Empty File ', () {
    var value = Util.fromCSVToJSON(
        """Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora inÃ­cio da aula,Hora fim da aula,Data da aula,Sala atribuÃ­da Ã  aula,LotaÃ§Ã£o da sala""");
    expect(value.item1, "{ \"events\": [] }");
    expect(value.item2.length, 0);
  });

  test('getEventsFromURL() - test with non CSV/JSON file', () async {
    List<Event> list = await Util.getEventsFromUrl(
        'https://filesamples.com/samples/document/txt/sample3.txt');
    expect(list.length, 0);
  });

  test('getEventsFromURL() - test with CSV file', () async {
    List<Event> list = await Util.getEventsFromUrl(
        'https://raw.githubusercontent.com/dmrraiscte/ES-2023-2Sem-Quarta-Feira-LEI-GrupoG/main/assets/files/horario-exemplo.csv');
    expect(list.length, 26019);
  });

  test('getEventsFromURL() - test with JSON file', () async {
    List<Event> list = await Util.getEventsFromUrl(
        'https://raw.githubusercontent.com/dmrraiscte/ES-2023-2Sem-Quarta-Feira-LEI-GrupoG/main/assets/files/events.json');
    expect(list.length, 26019);
  });

  test('getEventsFromURL() - test with bad webpage', () async {
    List<Event> list = await Util.getEventsFromUrl(
        'https://github.com/dmrraiscte/ES-2023-2Sem-Quarta-Feira-LEI-GrupoG/testeBadPageErrorCode');
    expect(list.length, 0);
  });

  test('eventsToCsv() - test: simple comparece of String content', () async {
    var value2 = Util.eventsToCsv(Util.fromCSVToJSON(
            """Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora inÃ­cio da aula,Hora fim da aula,Data da aula,Sala atribuÃ­da Ã  aula,LotaÃ§Ã£o da sala
  ME,Teoria dos Jogos e dos Contratos,01789TP01,MEA1,30,Sex,13:00:00,14:30:00,02/12/2022,AA2.25,34
  ME,Teoria dos Jogos e dos Contratos,01789TP01,MEA1,30,Qua,13:00:00,14:30:00,23/11/2022,AA2.25,34""")
        .item2);

    expect(value2, """
Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora início da aula,Hora fim da aula,Data da aula,Sala atribuída à aula,Lotação da sala
  ME,Teoria dos Jogos e dos Contratos,01789TP01,MEA1,30,Sex,13:00:00,14:30:00,02/12/2022,AA2.25,34
  ME,Teoria dos Jogos e dos Contratos,01789TP01,MEA1,30,Qua,13:00:00,14:30:00,23/11/2022,AA2.25,34""");
  });

  test('eventstoCsv() - test with a empty List<Events>', () async {
    expect(Util.eventsToCsv(List.empty()), Event.csvHeader);
  });

  test('eventsToJson() - test: simple comparece of String content', () async {
    var value2 = Util.eventsToJson(Util.fromCSVToJSON(
            """Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora inÃ­cio da aula,Hora fim da aula,Data da aula,Sala atribuÃ­da Ã  aula,LotaÃ§Ã£o da sala
  ME,Teoria dos Jogos e dos Contratos,01789TP01,MEA1,30,Sex,13:00:00,14:30:00,02/12/2022,AA2.25,34
  ME,Teoria dos Jogos e dos Contratos,01789TP01,MEA1,30,Qua,13:00:00,14:30:00,23/11/2022,AA2.25,34""")
        .item2);

    expect(value2, """
{ "events": [{ "Curso": "  ME", "Unidade Curricular": "Teoria dos Jogos e dos Contratos", "Turno": "01789TP01", "Turma": "MEA1", "Inscritos no turno": "30", "Dia da semana": "Sex", "Hora início da aula": "13:00:00", "Hora fim da aula": "14:30:00", "Data da aula": "02/12/2022", "Sala atribuída à aula": "AA2.25", "Lotação da sala": "34" },
{ "Curso": "  ME", "Unidade Curricular": "Teoria dos Jogos e dos Contratos", "Turno": "01789TP01", "Turma": "MEA1", "Inscritos no turno": "30", "Dia da semana": "Qua", "Hora início da aula": "13:00:00", "Hora fim da aula": "14:30:00", "Data da aula": "23/11/2022", "Sala atribuída à aula": "AA2.25", "Lotação da sala": "34" }]}""");
  });

  test('eventstoJson() - test with a empty List<Events>', () async {
    expect(Util.eventsToJson(List.empty()), '{ "events": []}');
  });
}
