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

toCSV() {
  return "${curso},${unidadeCurricular},${turno},${turma},${inscritosNoTurno},${diaDaSemana},${horaInicioAula},${horaFimAula},${dataAula},${salaAtribuidaAAula},${lotacaoSala}";
}
}
