import 'package:baba/screens/criacaoUser.dart';
import 'package:baba/screens/editarUser.dart';
import 'package:baba/screens/homepage.dart';
import 'package:flutter/material.dart';

class app_widget extends StatefulWidget {
  const app_widget({super.key});

  @override
  State<app_widget> createState() => _app_widgetState();
}

class _app_widgetState extends State<app_widget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: 'homepage',
      routes: {
        'homepage':(context) => const homepage(),
        'criacaoUser':(context) => const criacaoUser(),
        'editarUser':(context) => const editarUser(
          Confirmou: '',
          Pagou: '',
          Nome: '',
          Posicao: '',
          Avaliacao: '',
          G: '',
          Assistencia: '',
          GS: '',
          index: 0,
          Dados: [],
        ),
      },
    );
  }
}