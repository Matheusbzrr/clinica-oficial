class Agendamento {
  final String objectId;
  final String especialidade;
  final String medico;
  final DateTime data;
  final String hora;
  final String cliente;
  final String bairro;
  final String clinica;

  Agendamento({
    required this.objectId,
    required this.especialidade,
    required this.medico,
    required this.data,
    required this.hora,
    required this.cliente,
    required this.bairro,
    required this.clinica,
  });

  Map<String, dynamic> toJson() {
    return {
      'especialidade': especialidade,
      'medico': medico,
      'data': data,
      'hora': hora,
      'cliente': cliente,
      'bairro': bairro,
      'clinica': clinica,
    };
  }
}
