import 'package:flutter/material.dart';
import 'pagina_inicial_page.dart';
import 'carteirinha.dart';
import 'tela_especialidades_page.dart';
import 'package:clinica_agil/models/cliente.dart';

class LocalizacaoClinica extends StatefulWidget {
  final Cliente cliente;

  const LocalizacaoClinica({super.key, required this.cliente});

  @override
  State<LocalizacaoClinica> createState() => _LocalizacaoClinicaState();
}

class _LocalizacaoClinicaState extends State<LocalizacaoClinica> {
  String? _selectedBairro;

  final List<String> bairros = [
    'Curado',
    'Agua Fria',
    'Mustardinha',
    'Afogados',
    'Tejipió',
    'Pina',
    'Cavaleiro',
    'Muribeca',
    'Prazeres',
    'Abreu e Lima'
  ];

  final Map<String, List<Map<String, dynamic>>> clinicasPorBairro = {
    'Curado': [
      {
        'nome': 'Clínica Curado Vida',
        'endereco': 'Rua A, 100',
        'telefone': '(81) 1234-5678',
        'avaliacao': '4.7',
        'salvo': false
      },
      {
        'nome': 'Curado Saúde',
        'endereco': 'Av. B, 200',
        'telefone': '(81) 8765-4321',
        'avaliacao': '4.5',
        'salvo': false
      },
      {
        'nome': 'Clínica Vida Curado',
        'endereco': 'Rua C, 300',
        'telefone': '(81) 5555-6666',
        'avaliacao': '4.2',
        'salvo': false
      },
      {
        'nome': 'Saúde Curado',
        'endereco': 'Av. D, 400',
        'telefone': '(81) 7777-8888',
        'avaliacao': '4.8',
        'salvo': false
      },
      {
        'nome': 'Clínica Bem-Estar',
        'endereco': 'Rua E, 500',
        'telefone': '(81) 9999-0000',
        'avaliacao': '4.3',
        'salvo': false
      },
      {
        'nome': 'Curado Saúde +',
        'endereco': 'Av. F, 600',
        'telefone': '(81) 3333-4444',
        'avaliacao': '4.1',
        'salvo': false
      },
    ],
    'Agua Fria': [
      {
        'nome': 'Clínica Água Viva',
        'endereco': 'Rua G, 100',
        'telefone': '(81) 2222-3333',
        'avaliacao': '4.6',
        'salvo': false
      },
      {
        'nome': 'Água Fria Saúde',
        'endereco': 'Av. H, 200',
        'telefone': '(81) 1111-2222',
        'avaliacao': '4.4',
        'salvo': false
      },
      {
        'nome': 'Saúde Vida Água',
        'endereco': 'Rua I, 300',
        'telefone': '(81) 4444-5555',
        'avaliacao': '4.5',
        'salvo': false
      },
      {
        'nome': 'Bem-Estar Água',
        'endereco': 'Av. J, 400',
        'telefone': '(81) 6666-7777',
        'avaliacao': '4.7',
        'salvo': false
      },
      {
        'nome': 'Clínica Saúde Viva',
        'endereco': 'Rua K, 500',
        'telefone': '(81) 8888-9999',
        'avaliacao': '4.2',
        'salvo': false
      },
      {
        'nome': 'Vida Água Saúde',
        'endereco': 'Av. L, 600',
        'telefone': '(81) 0000-1111',
        'avaliacao': '4.3',
        'salvo': false
      },
    ],
    'Mustardinha': [
      {
        'nome': 'Clínica Mustardinha Saúde',
        'endereco': 'Rua M, 100',
        'telefone': '(81) 1357-2468',
        'avaliacao': '4.8',
        'salvo': false
      },
      {
        'nome': 'Saúde e Vida Mustardinha',
        'endereco': 'Av. N, 200',
        'telefone': '(81) 2468-1357',
        'avaliacao': '4.3',
        'salvo': false
      },
      {
        'nome': 'Mustardinha Bem-Estar',
        'endereco': 'Rua O, 300',
        'telefone': '(81) 3579-4680',
        'avaliacao': '4.6',
        'salvo': false
      },
      {
        'nome': 'Vida Mustardinha',
        'endereco': 'Av. P, 400',
        'telefone': '(81) 4680-3579',
        'avaliacao': '4.2',
        'salvo': false
      },
      {
        'nome': 'Saúde Total',
        'endereco': 'Rua Q, 500',
        'telefone': '(81) 5791-6802',
        'avaliacao': '4.9',
        'salvo': false
      },
      {
        'nome': 'Clínica Bem',
        'endereco': 'Av. R, 600',
        'telefone': '(81) 6802-5791',
        'avaliacao': '4.7',
        'salvo': false
      },
    ],
    'Afogados': [
      {
        'nome': 'Clínica Afogados Vida',
        'endereco': 'Rua S, 100',
        'telefone': '(81) 3456-7890',
        'avaliacao': '4.9',
        'salvo': false
      },
      {
        'nome': 'Afogados Saúde',
        'endereco': 'Av. T, 200',
        'telefone': '(81) 2345-6789',
        'avaliacao': '4.2',
        'salvo': false
      },
      {
        'nome': 'Saúde e Bem-Estar',
        'endereco': 'Rua U, 300',
        'telefone': '(81) 4567-8901',
        'avaliacao': '4.8',
        'salvo': false
      },
      {
        'nome': 'Afogados Total Saúde',
        'endereco': 'Av. V, 400',
        'telefone': '(81) 5678-9012',
        'avaliacao': '4.4',
        'salvo': false
      },
      {
        'nome': 'Vida Saudável Afogados',
        'endereco': 'Rua W, 500',
        'telefone': '(81) 6789-0123',
        'avaliacao': '4.3',
        'salvo': false
      },
      {
        'nome': 'Clínica Saúde Afogados',
        'endereco': 'Av. X, 600',
        'telefone': '(81) 7890-1234',
        'avaliacao': '4.5',
        'salvo': false
      },
    ],
    'Tejipió': [
      {
        'nome': 'Clínica Tejipió Saúde',
        'endereco': 'Rua Y, 100',
        'telefone': '(81) 9876-5432',
        'avaliacao': '4.6',
        'salvo': false
      },
      {
        'nome': 'Saúde e Bem-Estar Tejipió',
        'endereco': 'Av. Z, 200',
        'telefone': '(81) 8765-4321',
        'avaliacao': '4.5',
        'salvo': false
      },
      {
        'nome': 'Vida e Saúde',
        'endereco': 'Rua AA, 300',
        'telefone': '(81) 7654-3210',
        'avaliacao': '4.7',
        'salvo': false
      },
      {
        'nome': 'Clínica Tejipió Plus',
        'endereco': 'Av. BB, 400',
        'telefone': '(81) 6543-2109',
        'avaliacao': '4.4',
        'salvo': false
      },
      {
        'nome': 'Bem-Estar Tejipió',
        'endereco': 'Rua CC, 500',
        'telefone': '(81) 5432-1098',
        'avaliacao': '4.8',
        'salvo': false
      },
      {
        'nome': 'Vida Tejipió Saúde',
        'endereco': 'Av. DD, 600',
        'telefone': '(81) 4321-0987',
        'avaliacao': '4.3',
        'salvo': false
      },
    ],
  };

  void _toggleSalvo(String bairro, int index) {
    setState(() {
      clinicasPorBairro[bairro]![index]['salvo'] =
          !clinicasPorBairro[bairro]![index]['salvo'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final clinicas = clinicasPorBairro[_selectedBairro] ?? [];

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
                  Navigator.pop(context, widget.cliente);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Localize sua clínica',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 1.5,
                  ),
                ),
                child: PopupMenuButton<String>(
                  onSelected: (String newValue) {
                    setState(() {
                      _selectedBairro = newValue;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return bairros.map((bairro) {
                      return PopupMenuItem<String>(
                        value: bairro,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bairro,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            const Divider(color: Colors.grey),
                          ],
                        ),
                      );
                    }).toList();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedBairro ?? 'Selecione um bairro',
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ),
                      const Icon(Icons.arrow_drop_down,
                          color: Colors.blueAccent),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_selectedBairro != null)
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 200,
                  ),
                  itemCount: clinicas.length,
                  itemBuilder: (context, index) {
                    var clinica = clinicas[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaEspecialidades(
                              cliente: widget.cliente,
                              bairro: _selectedBairro!,
                              clinica: clinica['nome'],
                            ),
                          ),
                        );
                      },
                      child: Card(
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
                              Text(
                                'Endereço: ${clinica['endereco']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Telefone: ${clinica['telefone']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '⭐ ${clinica['avaliacao']}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      clinica['salvo']
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: clinica['salvo']
                                          ? const Color(0xFF222083)
                                          : Colors.grey,
                                    ),
                                    onPressed: () =>
                                        _toggleSalvo(_selectedBairro!, index),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
        currentIndex: 0,
        selectedItemColor: const Color(0xFF01C3CC),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
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
                  builder: (context) =>
                      CarteirinhaPage(cliente: widget.cliente)),
            );
          }
        },
      ),
    );
  }
}
