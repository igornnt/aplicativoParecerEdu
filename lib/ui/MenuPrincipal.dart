import 'package:flutter/material.dart';
import 'package:aplicativoescolas/ui/alunos_ui/AdicionarAlunoView.dart';
import 'package:aplicativoescolas/ui/desempenho_individual_ui/alunos_desempenho_ui.dart';
import 'package:aplicativoescolas/ui/observacao_ui/Observacao_page.dart';
import 'areas_do_conhecimento_ui/areas_do_conhecimento_page.dart';
import 'desempenho_geral_ui/desempenho_geral_page.dart';
import 'desempenho_individual_ui/desempenho_individual_page.dart';

class MenuPrincipal extends StatelessWidget {
  String turmaId;
  String escolaId;

  MenuPrincipal(this.escolaId, this.turmaId);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GridLayout(escolaId, turmaId),
    );
  }
}

class GridLayout extends StatelessWidget {
  final double borda = 0.5;

  String turmaId;
  String escolaId;

  GridLayout(this.escolaId, this.turmaId);

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
        title: Text("Menu principal"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Container(
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
                        builder: (context) =>
                            AdicionarAlunoView(turmaId, escolaId),
                      ));
                },
                child: Card(
                  margin: const EdgeInsets.all(22.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.blue, width: borda),
                      ),
                      child: getCardByTitle("Alunos")),
                ),
              ),
              GestureDetector(
                child: Card(
                  margin: const EdgeInsets.all(22.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.blue, width: borda),
                      ),
                      child: getCardByTitle("Criterios")),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AreasConhecimentoView(
                            escolaId, turmaId,
                            avaliar: false),
                      ));
                },
              ),
              GestureDetector(
                child: Card(
                  margin: const EdgeInsets.all(22.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.blue, width: borda),
                      ),
                      child: getCardByTitle("Avaliar")),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AreasConhecimentoView(
                            escolaId, turmaId,
                            avaliar: true),
                      ));
                },
              ),
              GestureDetector(
                child: Card(
                  margin: const EdgeInsets.all(22.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.blue, width: borda),
                      ),
                      child: getCardByTitle("Observações")),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ObservacaoView(),
                      ));
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlunoViewChart(turmaId, escolaId),
                      ));
                },
                child: Card(
                  margin: const EdgeInsets.all(22.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.blue, width: borda),
                      ),
                      child: getCardByTitle("Desempenho individual")),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DesempenhoGeral(turmaId, escolaId),
                      ));
                },
                child: Card(
                  margin: const EdgeInsets.all(20.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.blue, width: borda),
                      ),
                      child: getCardByTitle("Desempenho geral")),
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
                  height: 50.0,
                  width: 50.0,
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
