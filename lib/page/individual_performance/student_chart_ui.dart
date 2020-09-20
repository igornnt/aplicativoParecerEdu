import 'package:aplicativoescolas/database/evaluation_provider.dart';
import 'package:aplicativoescolas/database/knowledge_provider.dart';
import 'package:aplicativoescolas/model/evaluation.dart';
import 'package:aplicativoescolas/model/knowledge.dart';
import 'package:aplicativoescolas/model/student.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:aplicativoescolas/page/individual_performance/indicador.dart';

import 'general_indicador.dart';
import 'indicador_criterio_page.dart';

class StudentChartPage extends StatefulWidget {
  Student student;

  StudentChartPage(this.student);

  @override
  _StudentChartPageState createState() => _StudentChartPageState(this.student);
}

class _StudentChartPageState extends State<StudentChartPage> {

    List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  Student student;

  _StudentChartPageState(this.student);

  List<Evaluation> evaluations;

  final linguagens = "Linguagens";
  final cienciasDaNatureza = "Ciências da natureza";
  final cienciasHumanas = "Ciências humanas";
  final matematica = "Matemática";
  final ensinoReligioso = "Ensino religioso";

  int touchedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Desempenho Individual"),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height + 500,
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Text(student.name,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChartSample2(this.student.id),
              ),

              Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  "Selecione a area de ensino para exibir as informações:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IndicadorCriterioPage(
                                  area: 1,
                                  student: this.student,
                                  titulo: linguagens,
                                )));
                  },
                  splashColor: Colors.blue,
                  child: areaGrafico(linguagens)),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IndicadorCriterioPage(
                                area: 2,
                                student: this.student,
                                titulo: cienciasHumanas,
                              )));
                },
                splashColor: Colors.blue,
                child: areaGrafico(cienciasHumanas),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IndicadorCriterioPage(
                                area: 3,
                                student: this.student,
                                titulo: cienciasDaNatureza,
                              )));
                },
                splashColor: Colors.blue,
                child: areaGrafico(cienciasDaNatureza),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IndicadorCriterioPage(
                                area: 4,
                                student: this.student,
                                titulo: matematica,
                              )));
                },
                splashColor: Colors.blue,
                child: areaGrafico(matematica),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IndicadorCriterioPage(
                                area: 5,
                                student: this.student,
                                titulo: ensinoReligioso,
                              )));
                },
                splashColor: Colors.blue,
                child: areaGrafico(ensinoReligioso),
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/add-observacao',
                        arguments: student);
                  },
                  child: areaGrafico("Observações")),
            ],
          ),
        ),
      ),
    );
  }

  Widget areaGrafico(String base) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: gradientColors[0], width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                base,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: gradientColors[1],
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
