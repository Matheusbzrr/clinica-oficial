import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Cliente extends ParseObject implements ParseCloneable {
  Cliente() : super(_keyTableName);
  Cliente.clone() : this();

  @override
  clone(Map<String, dynamic> map) => Cliente.clone()..fromJson(map);

  static const String _keyTableName = 'Cliente';
  static const String keyObjectId = 'objectId';
  static const String keyEmail = 'email';
  static const String keySenha = 'senha';
  static const String keyNome = 'nome';
  static const String keyNumCarteira = 'numCarteira';
  static const String keyIdade = 'idade';

  String? get objectId => get<String>(keyObjectId);
  String? get email => get<String>(keyEmail);
  String? get senha => get<String>(keySenha);
  String? get nome => get<String>(keyNome);
  String? get numCarteira => get<String>(keyNumCarteira);
  String? get idade => get<String>(keyIdade);

  set email(String? email) => set<String>(keyEmail, email ?? '');
  set senha(String? senha) => set<String>(keySenha, senha ?? '');
  set nome(String? nome) => set<String>(keyNome, nome ?? '');
  set numCarteira(String? numCarteira) =>
      set<String>(keyNumCarteira, numCarteira ?? "");
  set idade(String? idade) => set<String>(keyIdade, idade ?? '');
}
