import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';//
import 'package:mysql_client/mysql_client.dart';

class criacaoUser extends StatefulWidget {
  const criacaoUser({super.key});

  @override
  State<criacaoUser> createState() => _criacaoUserState();
}

class _criacaoUserState extends State<criacaoUser> {

  late MySQLConnection conn;

  @override
  void initState() {
    super.initState();
    getConnection();
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

Future salvarDados(bool Confirmou, bool Pagou, String Nome, String P, String Avl, String G, String A, String GS) async {
    try {
    final Map<String, dynamic> parametros = {'Confirmou' : Confirmou,'Pagou' : Pagou, 'Nome': Nome, 'P': P, 'Avl' : Avl, 'G' : G, 'A' : A, 'GS' : GS};

    await conn.execute('INSERT INTO pessoa (Confirmou, Pagou, Nome, Posição, Avaliação, G, A, GS) VALUES (:Confirmou, :Pagou, :Nome, :P, :Avl, :G, :A, :GS)', parametros);
    await conn.execute('COMMIT');
    print('Dados salvos com sucesso');
  } catch (e) {
    print('Erro ao salvar os dados: $e');
  }
}

  String nomeUser = '';

  bool ischeckedP = false;

  bool ischeckedC = false;

  List<String> avlGS = List.generate(101, (indexGS) => '$indexGS');

  String? avlGSValue;

  List<String> avlA = List.generate(101, (indexA) => '$indexA');

  String? avlAValue;

  List<String> avlGol = List.generate(101, (indexGol) => '$indexGol');

  String? avlGolValue;

  String? avlValue;

  List<String> avl = List.generate(11, (index) => '$index');

  String? dropDownValue;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Drawer(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.only(top:40),
            child: ListTile(
              leading: const Icon(Icons.home, 
              color: Colors.white,),
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
        title:  const Center(
          child: Text('Baba do Hannover',
          style: TextStyle(fontWeight: FontWeight.bold))),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Drop Posição
                                  DropdownButton<String>(
                                        hint: const Text('Posição',
                                        style: TextStyle(color: Colors.white),),
                                        value: dropDownValue,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropDownValue = newValue!;
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
                                hint: const Text('Avl',
                                style: TextStyle(color: Colors.white),),
                                value: avlValue,
                                onChanged: (String? avlNewValue) {
                                  setState(() {
                                    avlValue = avlNewValue!;
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
                                hint: const Text('G',
                                style: TextStyle(color: Colors.white),),
                                value: avlGolValue,
                                onChanged: (String? avlGolNewValue) {
                                  setState(() {
                                    avlGolValue = avlGolNewValue!;
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
                                hint: const Text('A',
                                style: TextStyle(color: Colors.white),),
                                value: avlAValue,
                                onChanged: (String? avlANewValue) {
                                  setState(() {
                                    avlAValue = avlANewValue!;
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
                                hint: const Text('GS',
                                style: TextStyle(color: Colors.white),),
                                value: avlGSValue,
                                onChanged: (String? avlGSNewValue) {
                                  setState(() {
                                    avlGSValue = avlGSNewValue!;
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
                                        value: ischeckedP,
                                        onChanged: (valueP) {
                                          setState(() {
                                            ischeckedP = valueP!;  
                                          });
                                        }),
                                        const Text('Pagou')
                                    ],
                                  ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                      Checkbox(
                                        value: ischeckedC,
                                        onChanged: (valueC) {
                                          setState(() {
                                            ischeckedC = valueC!;  
                                          });
                                        }),
                                        const Text('Confirmou')
                                        ],
                                      ),
                                    ),
                                  SizedBox(
                                      width: 260,
                                      child: 
                                         TextField(
                                          onChanged: (valueN) {
                                            setState(() {
                                              nomeUser = valueN;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Nome'
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextButton(onPressed: () {
                                                Navigator.pushNamed(context, 'homepage');
                                                salvarDados(ischeckedC, ischeckedP , nomeUser, dropDownValue!, avlValue!, avlGolValue!, avlAValue!, avlGSValue!);
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
        ),
    );
  }
}