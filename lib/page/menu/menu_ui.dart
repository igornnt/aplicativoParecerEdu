import 'package:aplicativoescolas/database/evaluation_provider.dart';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/page/criteria_categories/knowledge_areas_ui.dart';
import 'package:aplicativoescolas/page/evaluation/evaluation_areas.dart';
import 'package:aplicativoescolas/page/general_performace/general_chart.dart';
import 'package:aplicativoescolas/page/individual_performance/student_chart.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  ClassSchool classSchool;

  @override
  Widget build(BuildContext context) {
    final classSchool = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: GridLayout(classSchool),
    );
  }
}

class GridLayout extends StatelessWidget {

  ClassSchool classSchool;

  GridLayout(this.classSchool);

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
        title: Text(classSchool.name, style: TextStyle(fontWeight: FontWeight.w400)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 9,
      ),
      body: Container(
        child: GridView(
          physics: BouncingScrollPhysics(),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/alunos', arguments: classSchool);
              },
              child: Container(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(22.0),
                  child: getCardByTitle("Alunos"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          KnowledgeAreasPage(this.classSchool)),
                );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(22.0),
                child: getCardByTitle("Criterios"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Evaluation_AreasPage(this.classSchool)),
                );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(22.0),
                child: getCardByTitle("Avaliar"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/observacao',
                    arguments: classSchool);
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(22.0),
                child: getCardByTitle("Observações"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/alunos-chart",
                    arguments: classSchool);
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(22.0),
                child: getCardByTitle("Desempenho individual"),
              ),
            ),
            GestureDetector(
              onTap: (){
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GeneralChart(this.classSchool)),
                );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(20.0),
                child: getCardByTitle("Desempenho geral"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCardByTitle(String titulo) {
    String img = "";

    if (titulo == "Alunos") {
      img = "resource/icons/alunos.png";
    }
    if (titulo == "Criterios") {
      img = "resource/icons/criterios.png";
    }
    if (titulo == "Avaliar") {
      img = "resource/icons/avaliar.png";
    }
    if (titulo == "Observações") {
      img = "resource/icons/observacoes.png";
    }
    if (titulo == "Desempenho individual") {
      img = "resource/icons/desempenho-individual.png";
    }
    if (titulo == "Desempenho geral") {
      img = "resource/icons/desempenho-geral.png";
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
                  height: 40.0,
                  width: 40.0,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          titulo,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
