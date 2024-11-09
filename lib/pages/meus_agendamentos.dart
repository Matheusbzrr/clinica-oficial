import 'package:flutter/material.dart';
import 'pagina_inicial_page.dart';
import 'carteirinha.dart';
import 'package:clinica_agil/models/cliente.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:clinica_agil/models/agendamento.dart';

class MeusAgendamentos extends StatefulWidget {
  final Cliente cliente;

  const MeusAgendamentos({super.key, required this.cliente});

  @override
  State<MeusAgendamentos> createState() => _MeusAgendamentosState();
}

class _MeusAgendamentosState extends State<MeusAgendamentos> {
  int _selectedIndex = 0;
  List<Agendamento> _agendamentos = [];

  @override
  void initState() {
    super.initState();
    buscarAgendamentos();
  }

  Future<void> buscarAgendamentos() async {
    print('Email do cliente: ${widget.cliente.email}');

    final QueryBuilder<ParseObject> queryBuilder =
        QueryBuilder<ParseObject>(ParseObject('Agendamento'))
          ..whereEqualTo('cliente', widget.cliente.email);

    final ParseResponse response = await queryBuilder.query();
    print('Response: ${response.results}');

    if (response.success && response.results != null) {
      setState(() {
        _agendamentos = response.results!.map((object) {
          print('Agendamento encontrado: ${object.get<String>('cliente')}');
          final dataField = object.get<dynamic>('data');
          DateTime? data;
          if (dataField is Map<String, dynamic>) {
            data = DateTime.parse(dataField['iso']);
          } else if (dataField is DateTime) {
            data = dataField;
          } else {
            data = DateTime
                .now(); // Valor padrão se o campo 'data' estiver ausente ou em um formato inesperado
          }
          return Agendamento(
            objectId: object.objectId!,
            especialidade: object.get<String>('especialidade')!,
            medico: object.get<String>('medico')!,
            data: data,
            hora: object.get<String>('hora')!,
            cliente: object.get<String>('cliente')!,
          );
        }).toList();
      });
    }
  }

  Future<void> excluirAgendamento(String objectId) async {
    final agendamento = ParseObject('Agendamento')..objectId = objectId;
    final response = await agendamento.delete();

    if (response.success) {
      setState(() {
        _agendamentos
            .removeWhere((agendamento) => agendamento.objectId == objectId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agendamento cancelado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Erro ao excluir o agendamento: ${response.error?.message}')),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaginaInicial(cliente: widget.cliente),
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CarteirinhaPage(cliente: widget.cliente)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF222083),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
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
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                "Meus Agendamentos",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _agendamentos.isEmpty
                ? const Center(
                    child: Text(
                      "Nenhum agendamento encontrado.",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  )
                : Column(
                    children: _agendamentos.map((agendamento) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDetailRow(
                                  Icons.calendar_today,
                                  "Data",
                                  "${agendamento.data.day}/"
                                      "${agendamento.data.month}/"
                                      "${agendamento.data.year}"),
                              const SizedBox(height: 16),
                              buildDetailRow(Icons.calendar_today, "Hora",
                                  "${agendamento.hora}"),
                              const SizedBox(height: 16),
                              buildDetailRow(Icons.person, "Paciente",
                                  agendamento.cliente),
                              const SizedBox(height: 16),
                              buildDetailRow(Icons.medical_services, "Médico",
                                  agendamento.medico),
                              const SizedBox(height: 16),
                              buildDetailRow(Icons.location_on, "Localização",
                                  "Clínica Ágil - Centro"),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    excluirAgendamento(agendamento.objectId);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_membership),
            label: 'Carteirinha',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF01C3CC),
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String label, String info) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF222083), size: 28),
        const SizedBox(width: 16),
        Text(
          "$label: ",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: Text(
            info,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
