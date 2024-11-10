import 'package:clinica_agil/models/cliente.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'pagina_inicial_page.dart';
import 'carteirinha.dart';
import 'package:clinica_agil/models/especialidades.dart';
import 'package:clinica_agil/models/medico.dart';

class ConfirmacaoAgendamentoPage extends StatefulWidget {
  final Especialidades especialidade;
  final Medico medico;
  final DateTime data;
  final String hora;
  final Cliente cliente;
  final String bairro;
  final String clinica;

  const ConfirmacaoAgendamentoPage({
    Key? key,
    required this.especialidade,
    required this.medico,
    required this.data,
    required this.hora,
    required this.cliente,
    required this.bairro,
    required this.clinica,
  }) : super(key: key);

  @override
  State<ConfirmacaoAgendamentoPage> createState() =>
      _ConfirmacaoAgendamentoPageState();
}

class _ConfirmacaoAgendamentoPageState
    extends State<ConfirmacaoAgendamentoPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PaginaInicial(
                  cliente: widget.cliente,
                )),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CarteirinhaPage(
                  cliente: widget.cliente,
                )),
      );
    }
  }

  Future<void> _salvarAgendamento() async {
    final agendamento = ParseObject('Agendamento');

    // Cria ponteiros para especialidade, medico e cliente, usand
    // Atribui os ponteiros e outras informações ao agendamento
    agendamento.set('especialidade', widget.especialidade.nome);
    agendamento.set('medico', widget.medico.nome);
    agendamento.set('cliente', widget.cliente.email);
    agendamento.set('data', widget.data);
    agendamento.set('hora', widget.hora);
    agendamento.set('bairro', widget.bairro);
    agendamento.set('clinica', widget.clinica);

    // Salva o agendamento no Parse Server
    final response = await agendamento.save();

    if (response.success) {
      // Agendamento salvo com sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agendamento realizado com sucesso!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PaginaInicial(
                  cliente: widget.cliente,
                )),
      );
    } else {
      // Erro ao salvar o agendamento
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Erro ao salvar o agendamento: ${response.error?.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222083),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF222083),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                iconSize: 20,
                icon: const Icon(Icons.arrow_back, color: Color(0xFF222083)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const Expanded(
              child: Center(
                child: Image(
                  image: AssetImage('assets/images/foto_de_menu_suspenso.png'),
                  height: 40,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: const Icon(Icons.notifications),
                    color: Colors.white,
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.settings),
                    color: Colors.white,
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle,
                        color: Color(0xFF01C3CC), size: 100),
                    const SizedBox(height: 16),
                    const Text(
                      'Agendamento concluído!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Seu agendamento foi concluído com sucesso. Você receberá um lembrete próximo à data agendada.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _salvarAgendamento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Página Inicial',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_membership), label: 'Carteirinha'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF01C3CC),
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
