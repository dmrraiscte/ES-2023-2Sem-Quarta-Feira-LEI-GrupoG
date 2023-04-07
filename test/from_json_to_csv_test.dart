import 'package:calendar_manager/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      """Conversão sem caracteres especiais nos valores recebidos (sem , ou "" )""",
      () {
    var value = Util.fromJsonToCSV(""" {
    "events": [
        { "Curso": "ME", "Unidade Curricular": "Teoria dos Jogos e dos Contratos", "Turno": "01789TP01", "Turma": "MEA1", "Inscritos no turno": "30", "Dia da semana": "Qua", "Hora início da aula": "13:00:00", "Hora fim da aula": "14:30:00", "Data da aula": "23/11/2022", "Sala atribuída à aula": "AA2.25", "Lotação da sala": "34" },
        { "Curso": "DF", "Unidade Curricular": "Investimentos II", "Turno": "01074TP01", "Turma": "DFB1", "Inscritos no turno": "3", "Dia da semana": "Seg", "Hora início da aula": "17:30:00", "Hora fim da aula": "19:00:00", "Data da aula": "21/11/2022", "Sala atribuída à aula": "D1.07", "Lotação da sala": "27" }
        ]} """);

    expect(value.item1,
        """Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora início da aula,Hora fim da aula,Data da aula,Sala atribuída à aula,Lotação da sala
ME,Teoria dos Jogos e dos Contratos,01789TP01,MEA1,30,Qua,13:00:00,14:30:00,23/11/2022,AA2.25,34
DF,Investimentos II,01074TP01,DFB1,3,Seg,17:30:00,19:00:00,21/11/2022,D1.07,27""");
  });

  test("Conversão com vírgulas nos valores recebidos", () {
    var value = Util.fromJsonToCSV(""" {
    "events": [
        {
            "Curso": "ME",
            "Unidade Curricular": "Teoria dos Jogos,dos Contratos",
            "Turno": "01789TP01",
            "Turma": "MEA1",
            "Inscritos no turno": "30",
            "Dia da semana": "Sex",
            "Hora início da aula": "13:00:00",
            "Hora fim da aula": "14:30:00",
            "Data da aula": "02/12/2022",
            "Sala atribuída à aula": "2,00E+08",
            "Lotação da sala": "34"
        }]} """);

    expect(value.item1,
        """Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora início da aula,Hora fim da aula,Data da aula,Sala atribuída à aula,Lotação da sala\nME,"Teoria dos Jogos,dos Contratos",01789TP01,MEA1,30,Sex,13:00:00,14:30:00,02/12/2022,"2,00E+08",34""");
  });

  test("""Conversão com "" nos valores recebidos""", () {
    var value = Util.fromJsonToCSV(""" {
    "events": [
        {
            "Curso": "",
            "Unidade Curricular": "Teoria dos Jogos,dos Contratos",
            "Turno": "01789TP01",
            "Turma": "MEA1",
            "Inscritos no turno": "30",
            "Dia da semana": "",
            "Hora início da aula": "13:00:00",
            "Hora fim da aula": "14:30:00",
            "Data da aula": "02/12/2022",
            "Sala atribuída à aula": "2,00E+08",
            "Lotação da sala": ""
        }]} """);

    expect(value.item1,
        """Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora início da aula,Hora fim da aula,Data da aula,Sala atribuída à aula,Lotação da sala
,"Teoria dos Jogos,dos Contratos",01789TP01,MEA1,30,,13:00:00,14:30:00,02/12/2022,"2,00E+08",""");
  });

  test("Conversão sem objetos no ficheiro", () {
    var value = Util.fromJsonToCSV(""" {
    "events": []} """);

    expect(value.item1,
        """Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora início da aula,Hora fim da aula,Data da aula,Sala atribuída à aula,Lotação da sala\n""");
    expect(value.item2.length, 0);
  });

  test("Verificação dos Eventos criados", () {
    var value = Util.fromJsonToCSV("""{
    "events": [{ "Curso": "MGSS", "Unidade Curricular": "GestÃ£o de OperaÃ§Ãµes e Sistema LogÃ­stico", "Turno": "03475TP01", "Turma": "MGSSA1", "Inscritos no turno": "43", "Dia da semana": "Sex", "Hora início da aula": "09:30:00", "Hora fim da aula": "11:00:00", "Data da aula": "16/09/2022", "Sala atribuída à aula": "AA3.23", "Lotação da sala":"" },
{ "Curso": "LEI, LEI-PL", "Unidade Curricular": "Agentes AutÃ³nomos", "Turno": "03727T01", "Turma": "EI-PL-C2, EI-PL-C1", "Inscritos no turno": "51", "Dia da semana": "Seg", "Hora início da aula": "21:00:00", "Hora fim da aula": "22:30:00", "Data da aula": "05/12/2022", "Sala atribuída à aula": "C5.08", "Lotação da sala": "58" } ]}""");

    expect(value.item2[0].lotacaoSala, "");
    expect(value.item2[1].curso, "LEI, LEI-PL");
    expect(value.item2[1].diaDaSemana, "Seg");
  });
}
