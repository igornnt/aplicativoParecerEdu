import 'dart:io';
import 'dart:typed_data';
import 'package:aplicativoescolas/database/evaluation_provider.dart';
import 'package:aplicativoescolas/model/evaluation.dart';
import 'package:aplicativoescolas/model/student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:intl/intl.dart';

import '../../utils/pdf.dart';
import 'horizonral_chart_ui.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// Chart import.
import 'package:syncfusion_flutter_charts/charts.dart';

/// Pdf import.
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// Chart import.
import 'package:syncfusion_flutter_charts/charts.dart';

import 'new_chart_horizontal.dart';

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
              Center(
                  child: Text(
                      "Veja abaixo os indicadores do(a) aluno(a) $studentName.")),
              SizedBox(
                height: 20,
                width: 50,
              ),
              Column(
                children: <Widget>[],
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
                        future: EvaluationProvider.db
                            .getAllEvaluationIdStutedent(widget.student.id),
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
                                  double value =
                                      snapshot.data[indice].peso * 100;
                                  String valorPercentual = value.toString();

                                  return this.widget.area ==
                                          snapshot.data[indice].idArea
                                      ? Column(
                                          children: [
                                            Center(
                                                child: Container(
                                                    padding: new EdgeInsets.all(
                                                        20.0),
                                                    child: HorizontalNewChart(
                                                        criterio: snapshot
                                                            .data[indice]
                                                            .criterio,
                                                        peso: snapshot
                                                            .data[indice].peso,
                                                        valorPercentual:
                                                            valorPercentual)))
                                          ],
                                        )
                                      : Container();
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
