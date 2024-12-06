import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clinica_agil/models/agendamento.dart';

class ParseRestServiceAgendamento {
  final String keyApplicationId = 'seuid';
  final String keyRestApiKey = 'suasenha';
  final String keyParseServerUrl = 'https://parseapi.back4app.com';

  Future<void> saveAgendamento(Agendamento agendamento) async {
    final url = '$keyParseServerUrl/classes/Agendamentos';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'X-Parse-Application-Id': keyApplicationId,
        'X-Parse-REST-API-Key': keyRestApiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(agendamento.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao salvar agendamento');
    }
  }
}
