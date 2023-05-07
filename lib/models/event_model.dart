import 'package:intl/intl.dart';

/// __Class with atribbutes regarding a schedule event.__

class Event {
  String curso;
  String unidadeCurricular;
  String turno;
  String turma;
  String inscritosNoTurno;
  String diaDaSemana;
  String horaInicioAula;
  String horaFimAula;
  String dataAula;
  String salaAtribuidaAAula;
  String lotacaoSala;

  /// Static to be used in csv formatted strings generation
  static String csvHeader =
      "Curso,Unidade Curricular,Turno,Turma,Inscritos no turno,Dia da semana,Hora início da aula,Hora fim da aula,Data da aula,Sala atribuída à aula,Lotação da sala\n";

  Event(
    this.curso,
    this.unidadeCurricular,
    this.turno,
    this.turma,
    this.inscritosNoTurno,
    this.diaDaSemana,
    this.horaInicioAula,
    this.horaFimAula,
    this.dataAula,
    this.salaAtribuidaAAula,
    this.lotacaoSala,
  );
/*
  //TODO: Este assert tem de ser revisto. No webcal existem imensos dados em falta.
  : assert(curso.isNotEmpty &&
            unidadeCurricular.isNotEmpty &&
            turno.isNotEmpty &&
            turma.isNotEmpty &&
            horaInicioAula.isNotEmpty &&
            horaFimAula.isNotEmpty &&
            dataAula.isNotEmpty &&
            salaAtribuidaAAula.isNotEmpty);
*/
  ///__Creates an Event from the Map<String, dynamic> [json]__
  ///
  /// * The Map's key is a String that represents the JSON key and the Map's value is dynamic, representing the JSON value for said key

  factory Event.fromJson(Map<String, dynamic> json) {
    var event = Event(
        json['Curso'],
        json['Unidade Curricular'],
        json['Turno'],
        json['Turma'],
        json['Inscritos no turno'],
        json['Dia da semana'],
        json['Hora início da aula'],
        json['Hora fim da aula'],
        json['Data da aula'],
        json['Sala atribuída à aula'],
        json['Lotação da sala']);
    return event;
  }

  /// __Creates an Event from a string [csv] with csv format__
  ///
  /// * Alternative constructor
  /// * Split by comma outside of quotation marks

  factory Event.fromCSV(String csv) {
    var event = csv.split(RegExp(',(?=([^"]*"[^"]*")*[^"]*\$)'));

    return Event(
        event[0].replaceAll('"', ""),
        event[1].replaceAll('"', ""),
        event[2].replaceAll('"', ""),
        event[3].replaceAll('"', ""),
        event[4].replaceAll('"', ""),
        event[5].replaceAll('"', ""),
        event[6].replaceAll('"', ""),
        event[7].replaceAll('"', ""),
        event[8].replaceAll('"', ""),
        event[9].replaceAll('"', ""),
        event[10].replaceAll('"', "").trim());
  }

  /// __Returns a string representing of an Event an its variables in a string with json format__
  String toJson() {
    return '{ "Curso": "$curso", "Unidade Curricular": "$unidadeCurricular", "Turno": "$turno", "Turma": "$turma", "Inscritos no turno": "$inscritosNoTurno", "Dia da semana": "$diaDaSemana", "Hora início da aula": "$horaInicioAula", "Hora fim da aula": "$horaFimAula", "Data da aula": "$dataAula", "Sala atribuída à aula": "$salaAtribuidaAAula", "Lotação da sala": "$lotacaoSala" }';
  }

  /// __Returns a string representing an Event an its variables in a string with CSV format__
  String toCSV() {
    return "${addQuotes(curso)},${addQuotes(unidadeCurricular)},${addQuotes(turno)},${addQuotes(turma)},$inscritosNoTurno,${addQuotes(diaDaSemana)},${addQuotes(horaInicioAula)},${addQuotes(horaFimAula)},${addQuotes(dataAula)},${addQuotes(salaAtribuidaAAula)},$lotacaoSala";
  }

  /// __Returns a string with the correct csv value syntax from [value]__
  ///
  /// * If the [value] contains commas, the result returned will consist of said [value] surrounded by quotation marks
  ///
  /// ```dart
  /// addQuotes("LETI") == LETI
  /// addQuotes("LETI, LEI") == "LETI, LEI"
  /// ```

  String addQuotes(String value) {
    return value.contains(",") ? "\"$value\"" : value;
  }

  DateFormat getDateFormat() {
    if (dataAula.contains("-")) return DateFormat("yyyy-MM-dd HH:mm");
    return DateFormat("dd/MM/yyyy HH:mm:ss");
  }

  DateTime? getEventStart() {
    return getDateFormat().parse("$dataAula $horaInicioAula");
  }

  DateTime? getEventEnd() {
    return getDateFormat().parse("$dataAula $horaFimAula");
  }

  String getDescription() {
    return "$unidadeCurricular\n$salaAtribuidaAAula";
  }

  bool isTestOrExam() {
    return turno.toLowerCase().contains("teste") ||
        turno.toLowerCase().contains("exame") ||
        turno.toLowerCase().contains("avaliação") ||
        turno.toLowerCase().contains("intercalar");
  }

  @override
  String toString() {
    return 'EVENT[curso: $curso, dataAula: $dataAula, diaDaSemana: $diaDaSemana, horaFimAula: $horaFimAula, horaInicioAula: $horaInicioAula, inscritosNoTurno: $inscritosNoTurno, lotacaoSala: $lotacaoSala, salaAtribuidaAAula: $salaAtribuidaAAula, turma: $turma, turno: $turno, unidadeCurricular: $unidadeCurricular]';
  }
}
