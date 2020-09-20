import 'package:aplicativoescolas/database/evaluation_provider.dart';
import 'package:aplicativoescolas/model/evaluation.dart';
import 'package:aplicativoescolas/model/student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'horizonral_chart_ui.dart';

class IndicadorCriterioPage extends StatefulWidget {
  int area;
  Student student;
  String titulo;

  IndicadorCriterioPage({this.area, this.titulo, this.student});

  @override
  _IndicadorCriterioPageState createState() => _IndicadorCriterioPageState();
}

class _IndicadorCriterioPageState extends State<IndicadorCriterioPage> {

  String studentName;

  @override
  void initState() {
    // TODO: implement initState
    studentName = super.widget.student.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(super.widget.titulo)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
              width: 100,
            ),
            Center(child: Text("Veja abaixo os indicadores do aluno $studentName .")),
            SizedBox(
              height: 20,
              width: 50,
            ),
            Column(
              children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.blue,
                      height: 15,
                      width: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Percentual atingido"),
                  )
                ]),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey,
                      height: 15,
                      width: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Percentual não atingido"),
                  )
                ],
              )
            ],
            ),
            SizedBox(
              height: 30,
              width: 100,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    child: FutureBuilder(
                      future: EvaluationProvider.db.getAllEvaluationIdStutedent(widget.student.id),
                      builder: (BuildContext context, AsyncSnapshot<List<Evaluation>> snapshot){
                        if(snapshot.connectionState == ConnectionState.done){
                            return ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, indice){
                                return this.widget.area == snapshot.data[indice].idArea ? HorizontalChart(snapshot.data[indice].criterio, snapshot.data[indice].peso) : Container();
                              });
                        }
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
