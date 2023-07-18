import 'package:aplicativoescolas/database/knowledge_provider.dart';
import 'package:aplicativoescolas/database/evaluation_provider.dart';
import 'package:aplicativoescolas/model/evaluation.dart';
import 'package:aplicativoescolas/model/knowledge.dart';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/page/general_performace/pie_chart_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'circular_chart.dart';

class GenneralCriterioPage extends StatefulWidget {
  int area;
  String titulo;
  ClassSchool classSchool;

  GenneralCriterioPage({this.area, this.classSchool, this.titulo});

  @override
  _GenneralCriterioPageState createState() => _GenneralCriterioPageState(area);
}

class _GenneralCriterioPageState extends State<GenneralCriterioPage> {
  String className;
  int area;

  List<int> indices = new List();

  bool nPossui = true;

  _GenneralCriterioPageState(this.area);

  @override
  void initState() {
    // TODO: implement initState
    className = super.widget.classSchool.name;
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
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Veja abaixo os indicadores para $className ."),
              )),
              SizedBox(
                height: 20,
                width: 50,
              ),
              SizedBox(
                height: 30,
                width: 100,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: FutureBuilder(
                        future: EvaluationProvider.db
                            .getAllEvaluationIdClassArea(
                                widget.classSchool.id, area),
                        // ignore: missing_return
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Evaluation>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, indice) {
                                  if (this.indices.length == 0) {
                                    DataPorcentagem d = new DataPorcentagem();
                                    d.idCriterio =
                                        snapshot.data[indice].idCriterio;
                                    indices
                                        .add(snapshot.data[indice].idCriterio);
                                    snapshot.data.forEach((f) {
                                      if (snapshot.data[indice].idCriterio ==
                                          f.idCriterio) {
                                        if (f.peso == 0) {
                                          d.naoAtingiuI();
                                        }
                                        if (f.peso == 0.5) {
                                          d.atingiuParcialmenteI();
                                        }
                                        if (f.peso == 1) {
                                          d.atingiuI();
                                        }
                                      }
                                    });
                                    double at = d.resultadoAtingiu();
                                    double atp = d.resultadoParcialmente();
                                    double nat = d.resultadoNaoAtingiu();

                                    return Container(
                                      child: CircularChart(
                                        criterio:
                                            snapshot.data[indice].criterio,
                                        qtdAtingiu: at,
                                        qtdAtingiuParcialmente: atp,
                                        qtdNaoAtingiu: nat,
                                      ),
                                    );
                                  } else {
                                    // tem um critério no indice
                                    //percorrar o array e veja se o id do critério está lá;
                                    bool esta = false;
                                    indices.forEach((f) {
                                      if (f ==
                                          snapshot.data[indice].idCriterio) {
                                        esta = true;
                                      }
                                    });

                                    if (esta == false) {
                                      //adiciona o indice ao array
                                      indices.add(
                                          snapshot.data[indice].idCriterio);
                                      //cria uma instancia;
                                      DataPorcentagem d = new DataPorcentagem();
                                      d.idCriterio =
                                          snapshot.data[indice].idCriterio;
                                      // percorre o array e vê quantas avaliações possui
                                      snapshot.data.forEach((f) {
                                        if (d.idCriterio == f.idCriterio) {
                                          if (f.peso == 0) {
                                            d.naoAtingiuI();
                                          }
                                          if (f.peso == 0.5) {
                                            d.atingiuParcialmenteI();
                                          }
                                          if (f.peso == 1) {
                                            d.atingiuI();
                                          }
                                        }
                                      });
                                      // copula os resultados
                                      double at = d.resultadoAtingiu();
                                      double atp = d.resultadoParcialmente();
                                      double nat = d.resultadoNaoAtingiu();
                                      // retorna o resultado
                                      return Container(
                                        child: CircularChart(
                                          criterio:
                                              snapshot.data[indice].criterio,
                                          qtdAtingiu: at,
                                          qtdAtingiuParcialmente: atp,
                                          qtdNaoAtingiu: nat,
                                        ),
                                      );
                                    }
                                    return Container();
                                  }
                                });
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
        ));
  }
}

class DataPorcentagem {
  int idCriterio;
  int total;
  double atingiu;
  double atingiuParcialmente;
  double naoAtingiu;

  DataPorcentagem() {
    this.atingiu = 0;
    this.atingiuParcialmente = 0;
    this.naoAtingiu = 0;
    this.total = 0;
  }

  void atingiuI() {
    total++;
    this.atingiu = atingiu + 1.0;
  }

  void atingiuParcialmenteI() {
    total++;
    this.atingiuParcialmente = atingiuParcialmente + 1.0;
  }

  void naoAtingiuI() {
    total++;
    this.naoAtingiu = naoAtingiu + 1.0;
  }

  double resultadoAtingiu() {
    double porcentagem =
        double.parse(((this.atingiu * 100) / this.total).toStringAsFixed(2));

    return porcentagem;
  }

  double resultadoParcialmente() {
    double porcentagem = double.parse(
        ((this.atingiuParcialmente * 100) / this.total).toStringAsFixed(2));

    return porcentagem;
  }

  double resultadoNaoAtingiu() {
    double porcentagem =
        double.parse(((this.naoAtingiu * 100) / this.total).toStringAsFixed(2));

    return porcentagem;
  }
}
