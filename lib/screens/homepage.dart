import 'package:baba/screens/editarUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mysql_client/mysql_client.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String? valueF;
  List<Map<String, String>> dados = [];
  late MySQLConnection conn;

  bool readNome = false;

  var res = '';
  var targetId = '';

  @override
  void initState() {
    super.initState();
    getConnection();
  }

  Future getConnection() async {
    conn = await MySQLConnection.createConnection(
      host: '',
      port: ,
      userName: '',
      password: '',
      databaseName: '',
    );
    try {
      await conn.connect();
      print('Conexão bem sucedida');
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }

    await carregarDados();
    //await conn.close();
  }

  Future carregarDados() async {
    var resultado = await conn.execute('SELECT * FROM pessoa ORDER BY ID ASC');

    List<Map<String, String>> list = [];

    for (final row in resultado.rows) {
      final data = {
        'ID': row.colAt(0)!,
        'Confirmou': row.colAt(1)!,
        'Pagou': row.colAt(2)!,
        'Nome': row.colAt(3)!,
        'Posição': row.colAt(4)!,
        'Avaliação': row.colAt(5)!,
        'G': row.colAt(6)!,
        'A': row.colAt(7)!,
        'GS': row.colAt(8)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

  Future<void> excluirRegistro(String ID) async{
    var res = await conn.execute(
      'DELETE FROM pessoa WHERE ID = :ID',
      {
        'ID': ID,
      },
    );
    print(res.affectedRows);
    await carregarDados();
  }
Future carregarDadosN() async {
    var resultado = await conn.execute('SELECT * FROM pessoa ORDER BY Nome ASC');

    List<Map<String, String>> list = [];

    for (final row in resultado.rows) {
      final data = {
        'ID': row.colAt(0)!,
        'Confirmou': row.colAt(1)!,
        'Pagou': row.colAt(2)!,
        'Nome': row.colAt(3)!,
        'Posição': row.colAt(4)!,
        'Avaliação': row.colAt(5)!,
        'G': row.colAt(6)!,
        'A': row.colAt(7)!,
        'GS': row.colAt(8)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

Future carregarDadosP() async {
    var resultado = await conn.execute('SELECT * FROM pessoa ORDER BY Posição ASC');

    List<Map<String, String>> list = [];

    for (final row in resultado.rows) {
      final data = {
        'ID': row.colAt(0)!,
        'Confirmou': row.colAt(1)!,
        'Pagou': row.colAt(2)!,
        'Nome': row.colAt(3)!,
        'Posição': row.colAt(4)!,
        'Avaliação': row.colAt(5)!,
        'G': row.colAt(6)!,
        'A': row.colAt(7)!,
        'GS': row.colAt(8)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

  Future carregarDadosAvl() async {
    var resultado = await conn.execute('SELECT * FROM pessoa ORDER BY Avaliação ASC');

    List<Map<String, String>> list = [];

    for (final row in resultado.rows) {
      final data = {
        'ID': row.colAt(0)!,
        'Confirmou': row.colAt(1)!,
        'Pagou': row.colAt(2)!,
        'Nome': row.colAt(3)!,
        'Posição': row.colAt(4)!,
        'Avaliação': row.colAt(5)!,
        'G': row.colAt(6)!,
        'A': row.colAt(7)!,
        'GS': row.colAt(8)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

  Future carregarDadosG() async {
    var resultado = await conn.execute('SELECT * FROM pessoa ORDER BY G ASC');

    List<Map<String, String>> list = [];

    for (final row in resultado.rows) {
      final data = {
        'ID': row.colAt(0)!,
        'Confirmou': row.colAt(1)!,
        'Pagou': row.colAt(2)!,
        'Nome': row.colAt(3)!,
        'Posição': row.colAt(4)!,
        'Avaliação': row.colAt(5)!,
        'G': row.colAt(6)!,
        'A': row.colAt(7)!,
        'GS': row.colAt(8)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

  Future carregarDadosA() async {
    var resultado = await conn.execute('SELECT * FROM pessoa ORDER BY A ASC');

    List<Map<String, String>> list = [];

    for (final row in resultado.rows) {
      final data = {
        'ID': row.colAt(0)!,
        'Confirmou': row.colAt(1)!,
        'Pagou': row.colAt(2)!,
        'Nome': row.colAt(3)!,
        'Posição': row.colAt(4)!,
        'Avaliação': row.colAt(5)!,
        'G': row.colAt(6)!,
        'A': row.colAt(7)!,
        'GS': row.colAt(8)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

  Future carregarDadosGS() async {
    var resultado = await conn.execute('SELECT * FROM pessoa ORDER BY GS ASC');

    List<Map<String, String>> list = [];

    for (final row in resultado.rows) {
      final data = {
        'ID': row.colAt(0)!,
        'Confirmou': row.colAt(1)!,
        'Pagou': row.colAt(2)!,
        'Nome': row.colAt(3)!,
        'Posição': row.colAt(4)!,
        'Avaliação': row.colAt(5)!,
        'G': row.colAt(6)!,
        'A': row.colAt(7)!,
        'GS': row.colAt(8)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: const Text('Início'),
                onTap: () {
                  Navigator.pushNamed(context, 'homepage');
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Center(
          child: Text(
            'Baba do Hannover',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {
              Navigator.pushNamed(context, 'criacaoUser');
            }, icon: const Icon(Icons.add_circle,
            size: 50,))
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
    children: [
      DropdownButton<String>(
        hint: const Text('Filtrar',
        style: TextStyle(color: Colors.white),),
        value: valueF,
        onChanged: (String? newValueF) {
          valueF = newValueF;
        },
        items:  [
          DropdownMenuItem<String>(
            value: 'Nome',
            child: const Text('Nome'),
            onTap:  () {
              setState(() {
                carregarDadosN();
              });
            },
          ),
         DropdownMenuItem<String>(
            value: 'Posição',
            child: const Text('Posição'),
            onTap: () {
              setState(() {
                carregarDadosP();
              });
            },
          ),
           DropdownMenuItem<String>(
            value: 'Avaliação',
            child: const Text('Avaliação'),
            onTap: () {
              setState(() {
                carregarDadosAvl();
              });
            },
          ),
           DropdownMenuItem<String>(
            value: 'G',
            child: const Text('G'),
            onTap: () {
              setState(() {
                carregarDadosG();
              });
            },
          ),
           DropdownMenuItem<String>(
            value: 'A',
            child: const Text('A'),
            onTap: () {
              setState(() {
                carregarDadosA();
              });
            },
          ),
          DropdownMenuItem<String>(
            value: 'GS',
            child: const Text('GS'),
            onTap: () {
              setState(() {
                carregarDadosGS();
              });
            },
          ),
        ],
      ),
      const SizedBox(height: 10),
         Column(
          children: List.generate(dados.length, (index) {
            return Card(
              child: ListTile(
                leading: Column(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 100,
                      child: Row(
                        children: [
                          const Text(
                            'Confirmou',
                            style: TextStyle(fontSize: 13),
                          ),
                          Checkbox(
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: dados[index]['Confirmou'] == '1',
                            onChanged: (newValueC) {
                              setState(() {
                                //dados[index]['Confirmou'] = newValueC! ? '1' : '0';
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 100,
                      child: Row(
                        children: [
                          const Text(
                            'Pagou',
                            style: TextStyle(fontSize: 13),
                          ),
                          Checkbox(
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: dados[index]['Pagou'] == '1',
                            onChanged: (newValueP) {
                              setState(() {
                                //dados[index]['Pagou'] = newValueP! ? '1' : '0';
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 70.0),
                          child: Text('Nome: ${dados[index]['Nome'] ?? ''}',
                          style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 21.0),
                          child: IconButton(
                            onPressed: () {
                              excluirRegistro(dados[index] ['ID']!);
                            },
                            icon: const Icon(Icons.person_remove_alt_1),
                          ),
                        )
                      ],
                    ),
                    Text('Posição: ${dados[index]['Posição'] ?? ''}',
                    style: const TextStyle(fontSize: 15),),
                    Text(
                        'Avaliação: ${double.parse(dados[index]['Avaliação'] ?? '0').toStringAsFixed(1)}',
                        style: const TextStyle(fontSize: 15),),
                    Text('Gols: ${dados[index]['G'] ?? ''}',
                    style: const TextStyle(fontSize: 15),),
                    Text('Assistência: ${dados[index]['A'] ?? ''}',
                    style: const TextStyle(fontSize: 15),),
                    Text('Gol Sofrido: ${dados[index]['GS'] ?? ''}',
                    style: const TextStyle(fontSize: 15),),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                       Navigator.push(context,
                       MaterialPageRoute(builder: (context) => editarUser(
                        Dados: dados,
                        Confirmou: dados[index] ['Confirmou'], 
                        Pagou: dados[index] ['Pagou'], 
                        Nome: dados[index] ['Nome'], 
                        Posicao: dados[index] ['Posição'], 
                        Avaliacao: dados[index] ['Avaliação'], 
                        G: dados[index] ['G'], 
                        Assistencia: dados[index] ['A'], 
                        GS: dados[index] ['GS'], 
                        index: index),));
                      },
                      child: const Text('Editar',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
    ]
        )
      )
    );
  }
}



