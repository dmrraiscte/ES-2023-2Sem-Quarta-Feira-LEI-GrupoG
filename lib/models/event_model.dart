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
      this.lotacaoSala);

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

//creates an Event from the string [csv]
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

//Returns a string representing of an Event an its variables in a string with json format
  String toJson() {
    return '{ "Curso": "$curso", "Unidade Curricular": "$unidadeCurricular", "Turno": "$turno", "Turma": "$turma", "Inscritos no turno": "$inscritosNoTurno", "Dia da semana": "$diaDaSemana", "Hora início da aula": "$horaInicioAula", "Hora fim da aula": "$horaFimAula", "Data da aula": "$dataAula", "Sala atribuída à aula": "$salaAtribuidaAAula", "Lotação da sala": "$lotacaoSala" }';
  }

  String toCSV() {
    return "${addQuotes(curso)},${addQuotes(unidadeCurricular)},${addQuotes(turno)},${addQuotes(turma)},$inscritosNoTurno,${addQuotes(diaDaSemana)},${addQuotes(horaInicioAula)},${addQuotes(horaFimAula)},${addQuotes(dataAula)},${addQuotes(salaAtribuidaAAula)},$lotacaoSala";
  }

  String addQuotes(String value) {
    return value.contains(",") ? "\"$value\"" : value;
  }
}
