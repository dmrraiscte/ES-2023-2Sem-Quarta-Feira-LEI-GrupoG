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

  String toCSV() {
    return "${addQuotes(curso)},${addQuotes(unidadeCurricular)},${addQuotes(turno)},${addQuotes(turma)},$inscritosNoTurno,${addQuotes(diaDaSemana)},${addQuotes(horaInicioAula)},${addQuotes(horaFimAula)},${addQuotes(dataAula)},${addQuotes(salaAtribuidaAAula)},$lotacaoSala";
  }

  String addQuotes(String value) {
    return value.contains(",") ? "\"$value\"" : value;
  }
}
