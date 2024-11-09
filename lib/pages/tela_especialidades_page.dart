import 'package:clinica_agil/models/cliente.dart';
import 'package:clinica_agil/pages/carteirinha.dart';
import 'package:flutter/material.dart';
import 'package:clinica_agil/models/especialidades.dart';
import 'package:clinica_agil/services/ParseRestService_especialidades.dart';
import 'escolha_do_medico_page.dart';
import 'pagina_inicial_page.dart';

class TelaEspecialidades extends StatefulWidget {
  final Cliente cliente;

  const TelaEspecialidades({Key? key, required this.cliente}) : super(key: key);

  @override
  State<TelaEspecialidades> createState() => _TelaEspecialidadesState();
}

class _TelaEspecialidadesState extends State<TelaEspecialidades> {
  int _selectedIndex = 0;
  late Future<List<Especialidades>> _especialidadesFuture;

  @override
  void initState() {
    super.initState();
    _especialidadesFuture =
        ParseRestServiceEspecialidades().getEspecialidades();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PaginaInicial(cliente: widget.cliente)),
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

  void _navigateToEscolhaDoMedico(Especialidades especialidade) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EscolhaDoMedico(
          especialidade: especialidade,
          cliente: widget.cliente,
        ),
      ),
    );
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
            const Center(
              child: Text(
                'Especialidades',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Especialidades>>(
                future: _especialidadesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Nenhuma especialidade encontrada.'));
                  } else {
                    final especialidades = snapshot.data!;
                    return ListView.builder(
                      itemCount: especialidades.length,
                      itemBuilder: (context, index) {
                        final especialidade = especialidades[index];
                        return EspecialidadeBar(
                          especialidade: especialidade,
                          onTap: () =>
                              _navigateToEscolhaDoMedico(especialidade),
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
}

class EspecialidadeBar extends StatelessWidget {
  final Especialidades especialidade;
  final VoidCallback onTap;

  const EspecialidadeBar({
    Key? key,
    required this.especialidade,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85, // Ajuste de largura
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF2260FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(especialidade.nome,
                style: const TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
