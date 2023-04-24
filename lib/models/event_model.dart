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

  ///__Creates an Event from the Map<String, dynamic> [json]__
  ///
  /// * The Map's key is a String that represents the JSON key and the Map's value is dynamic, representing the JSON value for said key

  Event.fromJson(Map<String, dynamic> json)
      : curso = json['Curso'],
        unidadeCurricular = json['Unidade Curricular'],
        turno = json['Turno'],
        turma = json['Turma'],
        inscritosNoTurno = json['Inscritos no turno'],
        diaDaSemana = json['Dia da semana'],
        horaInicioAula = json['Hora início da aula'],
        horaFimAula = json['Hora fim da aula'],
        dataAula = json['Data da aula'],
        salaAtribuidaAAula = json['Sala atribuída à aula'],
        lotacaoSala = json['Lotação da sala'];

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

  @override
  String toString() {
    return 'EVENT[curso: $curso, dataAula: $dataAula, diaDaSemana: $diaDaSemana, horaFimAula: $horaFimAula, horaInicioAula: $horaInicioAula, inscritosNoTurno: $inscritosNoTurno, lotacaoSala: $lotacaoSala, salaAtribuidaAAula: $salaAtribuidaAAula, turma: $turma, turno: $turno, unidadeCurricular: $unidadeCurricular]';
  }
}
