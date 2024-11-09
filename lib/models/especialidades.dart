class Especialidades {
  final String objectId;
  final String nome;

  Especialidades({required this.objectId, required this.nome});

  factory Especialidades.fromJson(Map<String, dynamic> json) {
    return Especialidades(
      objectId: json['objectId'],
      nome: json['nome'], // Certifique-se de que o campo JSON está correto
    );
  }

  Map<String, dynamic> toJson() {
    return {'objectId': objectId, 'nome': nome};
  }
}
