import 'package:clinica_agil/models/cliente.dart';
import 'package:clinica_agil/repositories/ClienteRepository.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ClienteController {
  final ClienteRepository _clienteRepository = ClienteRepository();

  Future<Cliente> criarCliente(String nome, String email, String senha,
      String idade, String numCarteira) async {
    try {
      if (await _clienteRepository.clienteExiste(email)) {
        throw Exception("Já existe um cliente com este email");
      }
      return await _clienteRepository.criarCliente(
          nome, email, senha, idade, numCarteira);
    } catch (e) {
      // enviando erro manipulado de forma mais elegante para exibir uma mensagem no Front
      throw Exception("Erro ao tentar criar cliente: $e");
    }
  }

  Future<Cliente?> loginCliente(String email, String senha) async {
    final query = QueryBuilder<ParseObject>(ParseObject('Cliente'))
      ..whereEqualTo('email', email)
      ..whereEqualTo('senha', senha);

    final response = await query.query();

    if (response.success &&
        response.results != null &&
        response.results!.isNotEmpty) {
      final parseObject = response.results!.first as ParseObject;
      return Cliente().fromJson(parseObject.toJson());
    } else {
      return null;
    }
  }

  Future<void> deletarCliente(String id) async {
    try {
      await _clienteRepository.deleteClienteById(id);
    } catch (e) {
      throw Exception("Erro ao deletar cliente: $e");
    }
  }

  Future<Cliente> atualizarCliente(String id,
      {String? nome, String? email, String? senha}) async {
    try {
      return await _clienteRepository.atualizarCliente(id,
          nome: nome, email: email, senha: senha);
    } catch (e) {
      throw Exception("Erro ao atualizar cliente: $e");
    }
  }
}
