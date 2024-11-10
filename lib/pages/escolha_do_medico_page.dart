import 'package:flutter/material.dart';
import 'package:clinica_agil/models/medico.dart';
import 'package:clinica_agil/models/cliente.dart';
import 'package:clinica_agil/models/especialidades.dart';
import 'package:clinica_agil/services/ParseRestService_medicos.dart';
import 'calendario_page.dart';
import 'pagina_inicial_page.dart';

class EscolhaDoMedico extends StatefulWidget {
  final Cliente cliente;
  final Especialidades especialidade;
  final String bairro;
  final String clinica;

  const EscolhaDoMedico({
    Key? key,
    required this.cliente,
    required this.especialidade,
    required this.bairro,
    required this.clinica,
  }) : super(key: key);

  @override
  State<EscolhaDoMedico> createState() => _EscolhaDoMedicoState();
}

class _EscolhaDoMedicoState extends State<EscolhaDoMedico> {
  int _selectedIndex = 0;
  late Future<List<Medico>> _medicosFuture;

  @override
  void initState() {
    super.initState();
    _medicosFuture = ParseRestServiceMedicos().getMedicos();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PaginaInicial(cliente: widget.cliente),
      ),
    );
  }

  void _navigateToCalendario(Medico medicoSelecionado) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarioPage(
          cliente: widget.cliente,
          especialidade: widget.especialidade,
          medico: medicoSelecionado,
          bairro: widget.bairro,
          clinica: widget.clinica,
        ),
      ),
    );
  }

  String getTituloEspecialidade() {
    return '${widget.especialidade.nome}s disponíveis';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                getTituloEspecialidade(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Medico>>(
                future: _medicosFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Nenhum médico encontrado.'));
                  } else {
                    final medicos = snapshot.data!;
                    // Filtra médicos considerando o `objectId` da especialidade
                    final medicosFiltrados = medicos
                        .where((medico) =>
                            medico.especialidade != null &&
                            medico.especialidade!.objectId ==
                                widget.especialidade.objectId)
                        .toList();

                    return ListView.builder(
                      itemCount: medicosFiltrados.length,
                      itemBuilder: (context, index) {
                        final medico = medicosFiltrados[index];
                        return _buildMedicoCard(
                          nome: medico.nome,
                          onTap: () => _navigateToCalendario(medico),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
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
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildMedicoCard({required String nome, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          nome,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
