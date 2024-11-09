import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:clinica_agil/models/cliente.dart'; // Importa a classe Cliente

class ClienteRepository {
  Future<Cliente> criarCliente(String nome, String email, String senha,
      String idade, String numCarteira) async {
    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
      throw Exception("Nome, email e senha são obrigatórios");
    }

    final cliente = Cliente()
      ..nome = nome
      ..email = email
      ..senha = senha
      ..idade = idade
      ..numCarteira = numCarteira;

    final response = await cliente.save();

    if (!response.success) {
      throw Exception(
          "Falha ao criar cliente: ${response.error?.message ?? 'Erro desconhecido'}");
    }

    return cliente;
  }

  Future<bool> clienteExiste(String email) async {
    final query = QueryBuilder<Cliente>(Cliente())
      ..whereEqualTo('email', email); // Assumindo que 'email' é único

    final response = await query.query();
    return response.success && (response.results?.isNotEmpty ?? false);
  }

  Future<bool> loginCliente(String email, String senha) async {
    final query = QueryBuilder<Cliente>(Cliente())
      ..whereEqualTo('email', email)
      ..whereEqualTo('senha', senha);

    final response = await query.query();

    if (response.success &&
        response.results != null &&
        response.results!.isNotEmpty) {
      return true; // Login bem-sucedido
    } else {
      print(
          "Erro ao fazer login: ${response.error?.message ?? 'Credenciais inválidas'}");
      return false; // Login falhou
    }
  }

  Future<void> deleteClienteById(String id) async {
    final cliente = Cliente()..objectId = id;
    final response = await cliente.delete();

    if (response.success) {
      print("Cliente deletado com sucesso.");
    } else {
      print("Erro ao deletar cliente: ${response.error?.message}");
      throw Exception("Falha ao deletar cliente");
    }
  }

  Future<Cliente> atualizarCliente(String id,
      {String? nome,
      String? email,
      String? senha,
      String? idade,
      String? numCarteira}) async {
    final cliente = Cliente()..objectId = id;

    // atualiza os campos se não forem nulos
    if (nome != null) cliente.nome = nome;
    if (email != null) cliente.email = email;
    if (senha != null) cliente.senha = senha;
    if (idade != null) cliente.idade = idade;
    if (numCarteira != null) cliente.numCarteira = numCarteira;

    final response = await cliente.save();

    if (response.success) {
      print("Cliente atualizado com sucesso: ${response.result}");
      return cliente;
    } else {
      print("Erro ao atualizar cliente: ${response.error?.message}");
      throw Exception("Falha ao atualizar cliente");
    }
  }
}
