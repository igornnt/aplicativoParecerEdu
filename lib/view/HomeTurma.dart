import 'package:flutter/material.dart';
import 'package:parecer_app/view/CadastrarTurmaView.dart';
import 'package:parecer_app/view/CardTurmaView.dart';

import 'CadastrarEscolaView.dart';
import 'CardEscolaView.dart';

class HomeTurma extends StatefulWidget {
  @override
  _HomeTurmaState createState() => _HomeTurmaState();
}

class _HomeTurmaState extends State<HomeTurma> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turmas"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          TurmaView(),
          TurmaView(),
          TurmaView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => AdicionaTurma(),
              )
          );
        },
        tooltip: "Adicione uma turma",
        child: Icon(Icons.add),
      ),
    );
  }
}


