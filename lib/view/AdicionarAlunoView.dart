import 'package:flutter/material.dart';

class AdicionarAlunoView extends StatefulWidget {
  @override
  _AdicionarAlunoViewState createState() => _AdicionarAlunoViewState();
}

class _AdicionarAlunoViewState extends State<AdicionarAlunoView> {
  List _alunos = [
    "Jõao Pedro Siqueira",
    "Dora de Oliveira",
    "Amanda Junqueira",
    "Maria Joaquina",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alunos"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                //Captura o tamanho da minha lista
                itemCount: _alunos.length,
                //Constroi a minha lista e retorna cada Item
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_alunos[index]),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Adicionar Aluno"),
                  content: TextField(
                    decoration:
                        InputDecoration(labelText: ("Informe o nome do aluno")),
                    onChanged: (text) {},
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Cancelar"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: Text("Salvar"),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                );
              });
          print("Botão pressionado");
        },
      ),
      //bottomNavigationBar: BottomNavigationBar(items: null,),
    );
  }
}
