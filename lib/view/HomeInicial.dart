import 'package:flutter/material.dart';

import 'CadastrarEscolaView.dart';
import 'CardEscolaView.dart';

class HomeInicial extends StatefulWidget {
  @override
  _HomeInicialState createState() => _HomeInicialState();
}

class _HomeInicialState extends State<HomeInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ParecerEdu"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          CardEscolaView(),
          CardEscolaView(),
          CardEscolaView()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => CadastrarEscolaView(),
              )
          );
        },
        tooltip: "Adicione uma escola",
        child: Icon(Icons.add),
      ),
    );
  }
}


