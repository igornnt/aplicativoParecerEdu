import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'desempenho_individual_serie.dart';

class DesempenhoIndividualChart extends StatelessWidget {

  final List<DesempenhoSeries> data;

  DesempenhoIndividualChart({@required this.data});

  Widget build(BuildContext context) {

    List<charts.Series<DesempenhoSeries, String>> series = [
      charts.Series(
          id: "Desempenho",
          data: data,
          domainFn: (DesempenhoSeries series, _) => series.areaConhecimento,
          measureFn: (DesempenhoSeries series, _) => series.metrica,
          colorFn: (DesempenhoSeries series, _) => series.barColor),
    ];

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(1),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Desempenho Individual %",
                style: Theme.of(context).textTheme.body1,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true, vertical: true,),
              )
            ],
          ),
        ),
      ),
    );
  }
}