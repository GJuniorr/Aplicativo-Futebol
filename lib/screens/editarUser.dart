// ignore_for_file: non_constant_identifier_names, unused_field

import 'package:baba/app_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mysql_client/mysql_client.dart';

class editarUser extends StatefulWidget {
  
  final String? Confirmou;
  final String? Pagou;
  final String? Nome;
  final String? Posicao;
  final String? Avaliacao;
  final String? G;
  final String? Assistencia;
  final String? GS;
  final int index;
  final List<Map<String, String>> Dados;

  const editarUser({
    super.key,
    required this.Confirmou,
    required this.Pagou,
    required this.Nome,
    required this.Posicao,
    required this.Avaliacao,
    required this.G,
    required this.Assistencia,
    required this.GS,
    required this.index, 
    required this.Dados,
  });

  @override
  State<editarUser> createState() => _editarUserState();
}

class _editarUserState extends State<editarUser> {
  bool? _ConfirmouController;
  bool? _PagouController;
  final TextEditingController _NomeController = TextEditingController();
  final TextEditingController _PosicaoController = TextEditingController();
  final TextEditingController _AvaliacaoController = TextEditingController();
  final TextEditingController _GController = TextEditingController();
  final TextEditingController _AController = TextEditingController();
  final TextEditingController _GSController = TextEditingController();
  final TextEditingController _indexController = TextEditingController();
  final TextEditingController _dadosController = TextEditingController();
  

  late MySQLConnection conn;
  List<Map<String, String>> dados = [];
  int? index;

  @override
  void initState() {
    super.initState();
    getConnection();
    _ConfirmouController = widget.Dados[widget.index] ['Confirmou'] == '1';
    _PagouController = widget.Dados[widget.index] ['Pagou'] == '1';
    _dadosController.text = widget.Dados[widget.index] ['ID']!;
    _NomeController.text = widget.Dados[widget.index] ['Nome']!;
    _PosicaoController.text = widget.Dados[widget.index] ['Posição']!;
    _AvaliacaoController.text = widget.Dados[widget.index] ['Avaliação']!;
    _GController.text = widget.Dados[widget.index] ['G']!;
    _AController.text = widget.Dados[widget.index] ['A']!;
    _GSController.text = widget.Dados[widget.index] ['GS']!;
  }

  Future getConnection() async {
   conn = await MySQLConnection.createConnection(
    host: '10.0.2.2',
    port: 3306,
    userName: 'root',
    password: 'kinafox223',
    databaseName: 'baba',
  );
   try {
      await conn.connect();
      print('Conexão bem sucedida');
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }
}

Future atualizarDados(bool Confirmou, bool Pagou, String Nome, String P, String Avl, String G, String A, String GS, String ID) async {
    try {
    final Map<String, dynamic> parametros = {'Confirmou' : Confirmou, 'Pagou' : Pagou, 'Nome': Nome, 'P': P, 'Avl' : Avl, 'G' : G, 'A' : A, 'GS' : GS, 'ID' : ID};

    var update = await conn.execute(
      'UPDATE pessoa SET Confirmou = :Confirmou, Pagou = :Pagou, Nome = :Nome, Posição = :P, Avaliação = :Avl, G = :G, A = :A, GS = :GS WHERE ID = :ID', 
      {
        'ID': ID,
        'Confirmou': Confirmou,
        'Pagou': Pagou,
        'Nome': Nome,
        'P': P,
        'Avl': Avl,
        'G': G,
        'A': A,
        'GS': GS,
      } );
    print(update.affectedRows);
    await conn.execute('COMMIT');
    print('Dados salvos com sucesso');
  } catch (e) {
    print('Erro ao salvar os dados: $e');
  }
}
  List<String> avl = List.generate(11, (index) => '$index');

  List<String> avlGol = List.generate(101, (indexGol) => '$indexGol');

  List<String> avlA = List.generate(101, (indexA) => '$indexA');
  
  List<String> avlGS = List.generate(101, (indexGS) => '$indexGS');

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Card(
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Drop Posição
                                  DropdownButton<String>(
                                        value: _PosicaoController.text,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _PosicaoController.text = newValue!;
                                          });
                                        },
                                        items: const [DropdownMenuItem<String>(
                                            value: 'Goleiro',
                                            child:Text('Goleiro')),
                                              DropdownMenuItem<String>(value: 'Linha', child: Text('Linha'),
                                              ),
                                              
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      //Drop Avl
                                 DropdownButton<String>(
                                value: _AvaliacaoController.text,
                                onChanged: (String? avlNewValue) {
                                  setState(() {
                                    _AvaliacaoController.text = avlNewValue!;
                                  });
                                },
                                items: avl.map<DropdownMenuItem<String>>((String value) {
                                  Color textColor;
                                  if (int.parse(value) < 5) {
                                    textColor = Colors.red; // Cor vermelha se o valor for menor que 5
                                  } else if (int.parse(value) == 5) {
                                    textColor = Colors.white; // Cor branca se o valor for igual a 5
                                  } else if (int.parse(value) < 8){
                                    textColor = Colors.yellow;
                                  } else if (int.parse(value) < 10){
                                    textColor = Colors.green;
                                  } else {
                                    textColor = Colors.blueAccent; // Cor azul se o valor for maior ou igual a 6
                                  }
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value.toString(),
                                  style:  TextStyle(color: textColor),), // Texto exibido para cada item do DropDownButton
                                );
                                }).toList(),
                                ),
                                const SizedBox(
                                        width: 20,
                                      ),
                              //Drop Gol
                                DropdownButton<String>(
                                value: _GController.text,
                                onChanged: (String? avlGolNewValue) {
                                  setState(() {
                                    _GController.text = avlGolNewValue!;
                                  });
                                },
                                items: avlGol.map<DropdownMenuItem<String>>((String valueGol) {
                                return DropdownMenuItem<String>(
                                  value: valueGol,
                                  child: Text(valueGol.toString(),
                                  style: const TextStyle(color: Colors.white,)), // Texto exibido para cada item do DropDownButton
                                );
                                }).toList(),
                                ),
                                const SizedBox(
                                        width: 20,
                                      ),
                                //Drop Assistência
                                DropdownButton<String>(
                                value: _AController.text,
                                onChanged: (String? avlANewValue) {
                                  setState(() {
                                    _AController.text = avlANewValue!;
                                  });
                                },
                                items: avlA.map<DropdownMenuItem<String>>((String valueA) {
                                return DropdownMenuItem<String>(
                                  value: valueA,
                                  child: Text(valueA.toString(),
                                  style: const TextStyle(color: Colors.white),), 
                                );
                                                }).toList(),
                                ),
                                const SizedBox(
                                        width: 20,
                                      ),
                                //Drop GS
                                DropdownButton<String>(
                                value: _GSController.text,
                                onChanged: (String? avlGSNewValue) {
                                  setState(() {
                                    _GSController.text = avlGSNewValue!;
                                  });
                                },
                                items: avlGS.map<DropdownMenuItem<String>>((String valueGS) {
                                return DropdownMenuItem<String>(
                                  value: valueGS,
                                  child: Text(valueGS.toString(),
                                  style: const TextStyle(color: Colors.white),), 
                                );
                                }).toList(),
                                ),   
                                ],
                          ),
                            ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: _ConfirmouController,
                                        onChanged: (valueP) {
                                          setState(() {
                                            _ConfirmouController = valueP!;  
                                          });
                                        }),
                                        const Text('Confirmou')
                                    ],
                                  ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                      Checkbox(
                                        value: _PagouController,
                                        onChanged: (valueC) {
                                          setState(() {
                                            _PagouController = valueC!;  
                                          });
                                        }),
                                        const Text('Pagou')
                                        ],
                                      ),
                                    ),
                                  SizedBox(
                                      width: 260,
                                      child: 
                                         TextField(
                                          controller: _NomeController,
                                          onChanged: (valueN) {
                                            setState(() {
                                              _NomeController.text = valueN;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextButton(onPressed: () {
                                                Navigator.pushNamed(context, 'homepage');
                                                atualizarDados(_ConfirmouController!, _PagouController! , _NomeController.text, _PosicaoController.text, _AvaliacaoController.text, _GController.text, _AController.text, _GSController.text, _dadosController.text);
                                              },
                                              style: const ButtonStyle(
                                              backgroundColor: MaterialStatePropertyAll(
                                      Colors.blue),
                                      minimumSize: MaterialStatePropertyAll(Size(200, 50))),
                                      child: const Text('Confirmar',)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextButton(onPressed: () {
                                        Navigator.pushNamed(context, 'homepage');
                                      },
                                      style: const ButtonStyle(
                                              backgroundColor: MaterialStatePropertyAll(
                                      Colors.blue),
                                      minimumSize: MaterialStatePropertyAll(Size(200, 50))),
                                       child: const Text('Voltar'))
              ],
            ),
        )
      ),
    );
  }
}