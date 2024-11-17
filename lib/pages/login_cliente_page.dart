import 'package:clinica_agil/pages/cadastro_cliente_page.dart';
import 'package:flutter/material.dart';
import 'package:clinica_agil/Controllers/ClienteController.dart';
import 'package:clinica_agil/services/ParseUsarService.dart';
import 'pagina_inicial_page.dart';

class TelaDeLogin extends StatefulWidget {
  const TelaDeLogin({super.key});

  @override
  State<TelaDeLogin> createState() => _TelaDeLoginState();
}

class _TelaDeLoginState extends State<TelaDeLogin> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final ClienteController _clienteController = ClienteController();
  String? _mensagemErro;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _inicializarParse();
  }

  Future<void> _inicializarParse() async {
    await ParseUsarService().initializeParse();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _loginCliente() async {
    final email = _emailController.text;
    final senha = _senhaController.text;

    try {
      final cliente = await _clienteController.loginCliente(email, senha);

      if (cliente != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login realizado com sucesso!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PaginaInicial(
              cliente: cliente, // Passa o objeto Cliente
            ),
          ),
        );
      } else {
        setState(() {
          _mensagemErro = 'E-mail ou senha inválidos.';
        });
      }
    } catch (e) {
      setState(() {
        _mensagemErro = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset(
                'assets/images/foto_de_login.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),

            // Campo de Usuário (Email)
            const Text(
              'Usuário',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Insira seu email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                errorText: _mensagemErro,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Senha',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _senhaController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: 'Insira sua senha',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
                errorText: _mensagemErro,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loginCliente,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF222083),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Esqueci minha senha',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ainda não possui uma conta? ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CadastroClientePage()),
                        );
                      },
                      child: const Text(
                        'Crie aqui',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
