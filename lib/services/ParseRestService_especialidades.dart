import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clinica_agil/models/especialidades.dart';

class ParseRestServiceEspecialidades {
  final String keyApplicationId = 'g4HqlebHJIb5hK6tyWBcufQfZDutuehirNW80z1D';
  final String keyRestApiKey = 'yFgp4kMNBqzkCaRUP4fOOXi9FgiqxIzbsQ73HLZf';
  final String keyParseServerUrl = 'https://parseapi.back4app.com';

  Future<List<Especialidades>> getEspecialidades() async {
    final url = '$keyParseServerUrl/classes/Especialidades';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-Parse-Application-Id': keyApplicationId,
        'X-Parse-REST-API-Key': keyRestApiKey,
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      print('Data received: $data');
      return data.map((json) => Especialidades.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar especialidades');
    }
  }
}
