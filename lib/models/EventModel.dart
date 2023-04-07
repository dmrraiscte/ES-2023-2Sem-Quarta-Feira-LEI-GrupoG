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

  toJson() {
    return '{ "Curso": "$curso", "Unidade Curricular": "$unidadeCurricular", "Turno": "$turno", "Turma": "$turma", "Inscritos no turno": "$inscritosNoTurno", "Dia da semana": "$diaDaSemana", "Hora início da aula": "$horaInicioAula", "Hora fim da aula": "$horaFimAula", "Data da aula": "$dataAula", "Sala atribuída à aula": "$salaAtribuidaAAula", "Lotação da sala": "$lotacaoSala" }';
  }
}
