class Event {
  String curso;
  String unidadeCurricular;
  String turno;
  String turma;
  int inscritosNoTurno;
  String diaDaSemana;
  String horaInicioAula;
  String horaFimAula;
  String dataAula;
  String salaAtribuidaAAula;
  int lotacaoSala;

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

  toJson() {
    return '{ "Curso": "${curso}", "Unidade Curricular": "${unidadeCurricular}", "Turno": "${turno}", "Turma": "${turma}", "Inscritos no turno": "${inscritosNoTurno}", "Dia da semana": "${diaDaSemana}", "Hora início da aula": "${horaInicioAula}", "Hora fim da aula": "${horaFimAula}", "Data da aula": "${dataAula}", "Sala atribuída à aula": "${salaAtribuidaAAula}", "Lotação da sala": "${lotacaoSala}" }';
  }
}
