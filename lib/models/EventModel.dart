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

    return Event(event[0], event[1], event[2], event[3], event[4], event[5],
        event[6], event[7], event[8], event[9], event[10].trim());
  }

  toJson() {
    return '{ "Curso": "${curso.replaceAll('"', "")}", "Unidade Curricular": "${unidadeCurricular.replaceAll('"', "")}", "Turno": "${turno.replaceAll('"', "")}", "Turma": "${turma.replaceAll('"', "")}", "Inscritos no turno": "$inscritosNoTurno", "Dia da semana": "${diaDaSemana.replaceAll('"', "")}", "Hora início da aula": "${horaInicioAula.replaceAll('"', "")}", "Hora fim da aula": "${horaFimAula.replaceAll('"', "")}", "Data da aula": "${dataAula.replaceAll('"', "")}", "Sala atribuída à aula": "${salaAtribuidaAAula.replaceAll('"', "")}", "Lotação da sala": "$lotacaoSala" }';
  }
}
