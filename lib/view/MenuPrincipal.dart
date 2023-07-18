import 'package:flutter/material.dart';
import 'package:aplicativoescolas/view/AdicionarAlunoView.dart';

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GridLayout(),
    );
  }
}

class GridLayout extends StatelessWidget {
  List<String> grids = [
    "alunos",
    "criterios",
    "avaliar",
    "observacoes",
    "desempenho-individual",
    "desempenho-geral"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Titulo da escola"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("icons/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: GridView(
            //Pesquisar essa função
            physics: BouncingScrollPhysics(),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdicionarAlunoView(),
                      ));
                },
                child: Card(
                  margin: const EdgeInsets.all(22.0),
                  child: getCardByTitle("Alunos"),
                ),
              ),
              GestureDetector(
                child: Card(
                  margin: const EdgeInsets.all(22.0),
                  child: getCardByTitle("Criterios"),
                ),
              ),
              GestureDetector(
                child: Card(
                  margin: const EdgeInsets.all(22.0),
                  child: getCardByTitle("Avaliar"),
                ),
              ),
              GestureDetector(
                child: Card(
                  margin: const EdgeInsets.all(22.0),
                  child: getCardByTitle("Observações"),
                ),
              ),
              GestureDetector(
                child: Card(
                  margin: const EdgeInsets.all(22.0),
                  child: getCardByTitle("Desempenho individual"),
                ),
              ),
              GestureDetector(
                child: Card(
                  margin: const EdgeInsets.all(20.0),
                  child: getCardByTitle("Desempenho geral"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCardByTitle(String titulo) {
    String img = "";

    if (titulo == "Alunos") {
      img = "icons/alunos.png";
    }
    if (titulo == "Criterios") {
      img = "icons/criterios.png";
    }
    if (titulo == "Avaliar") {
      img = "icons/avaliar.png";
    }
    if (titulo == "Observações") {
      img = "icons/observacoes.png";
    }
    if (titulo == "Desempenho individual") {
      img = "icons/desempenho-individual.png";
    }
    if (titulo == "Desempenho geral") {
      img = "icons/desempenho-geral.png";
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Center(
          child: Container(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  img,
                  height: 60.0,
                  width: 60.0,
                )
              ],
            ),
          ),
        ),
        Text(
          titulo,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
