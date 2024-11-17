class Medico {
  final String objectId;
  final String nome;
  final String crm;
  final Especialidade? especialidade;

  Medico({
    required this.objectId,
    required this.nome,
    required this.crm,
    this.especialidade,
  });

  factory Medico.fromJson(Map<String, dynamic> json) {
    return Medico(
      objectId: json['objectId'],
      nome: json['nome'],
      crm: json['CRM'],
      especialidade: json['especialidade'] != null
          ? Especialidade.fromJson(json['especialidade'])
          : null,
    );
  }
}

class Especialidade {
  final String objectId;
  final String nome;

  Especialidade({
    required this.objectId,
    required this.nome,
  });

  factory Especialidade.fromJson(Map<String, dynamic> json) {
    return Especialidade(
      objectId: json['objectId'],
      nome: json['nome'],
    );
  }
}
