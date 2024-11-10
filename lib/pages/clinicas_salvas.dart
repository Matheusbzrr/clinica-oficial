import 'package:flutter/material.dart';
import 'pagina_inicial_page.dart';
import 'carteirinha.dart';
import 'package:clinica_agil/models/cliente.dart'; // Certifique-se de que o caminho está correto.

class ClinicasSalvas extends StatefulWidget {
  final Cliente cliente;

  const ClinicasSalvas({Key? key, required this.cliente}) : super(key: key);

  @override
  State<ClinicasSalvas> createState() => _ClinicasSalvasState();
}

class _ClinicasSalvasState extends State<ClinicasSalvas> {
  int _selectedIndex = 0;

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
          builder: (context) => CarteirinhaPage(cliente: widget.cliente),
        ),
      );
    }
  }

  final List<Map<String, dynamic>> clinicasSalvas = [
    {
      'nome': 'Clínica Curado Vida',
      'endereco': 'Rua A, 100',
      'telefone': '(81) 1234-5678',
      'avaliacao': '4.7'
    },
    {
      'nome': 'Curado Saúde',
      'endereco': 'Av. B, 200',
      'telefone': '(81) 8765-4321',
      'avaliacao': '4.5'
    },
    {
      'nome': 'Clínica Água Viva',
      'endereco': 'Rua C, 300',
      'telefone': '(81) 5555-6666',
      'avaliacao': '4.6'
    },
    {
      'nome': 'Água Fria Saúde',
      'endereco': 'Av. D, 400',
      'telefone': '(81) 7777-8888',
      'avaliacao': '4.4'
    },
    {
      'nome': 'Clínica Mustardinha Saúde',
      'endereco': 'Rua E, 500',
      'telefone': '(81) 9999-0000',
      'avaliacao': '4.8'
    },
    {
      'nome': 'Saúde e Vida Mustardinha',
      'endereco': 'Av. F, 600',
      'telefone': '(81) 3333-4444',
      'avaliacao': '4.3'
    },
  ];

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Clínicas Salvas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 200,
                ),
                itemCount: clinicasSalvas.length,
                itemBuilder: (context, index) {
                  var clinica = clinicasSalvas[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clinica['nome'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Endereço:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            clinica['endereco'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Telefone: ${clinica['telefone']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '⭐ ${clinica['avaliacao']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const Icon(
                                Icons.bookmark,
                                color: Color(0xFF222083),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
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
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
