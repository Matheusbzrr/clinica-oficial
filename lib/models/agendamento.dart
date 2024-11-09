class Agendamento {
  final String objectId;
  final String especialidade;
  final String medico;
  final DateTime data;
  final String hora;
  final String cliente;

  Agendamento({
    required this.objectId,
    required this.especialidade,
    required this.medico,
    required this.data,
    required this.hora,
    required this.cliente,
  });

  Map<String, dynamic> toJson() {
    return {
      'especialidade': especialidade,
      'medico': medico,
      'data': data,
      'hora': hora,
      'cliente': cliente,
    };
  }
}
