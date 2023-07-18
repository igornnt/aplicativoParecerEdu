import 'package:aplicativoescolas/page/individual_performance/indicador.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

/// Chart import.
import 'package:syncfusion_flutter_charts/charts.dart';

/// Pdf import.
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// Chart import.
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../database/evaluation_provider.dart';
import '../../model/class_school.dart';

class CircularChart extends StatefulWidget {
  double qtdAtingiu;
  double qtdAtingiuParcialmente;
  double qtdNaoAtingiu;
  String criterio;

  CircularChart(
      {this.qtdAtingiu,
      this.qtdAtingiuParcialmente,
      this.qtdNaoAtingiu,
      this.criterio});

  @override
  State<StatefulWidget> createState() => CircularChartState(
      qtdAtingiu: this.qtdAtingiu,
      qtdAtingiuParcialmente: this.qtdAtingiuParcialmente,
      qtdNaoAtingiu: this.qtdNaoAtingiu,
      criterio: criterio);
}

class CircularChartState extends State<CircularChart> {
  double qtdAtingiu;
  double qtdAtingiuParcialmente;
  double qtdNaoAtingiu;
  String criterio;

  CircularChartState(
      {this.qtdAtingiu,
      this.qtdAtingiuParcialmente,
      this.qtdNaoAtingiu,
      this.criterio});

  GlobalKey<SfCircularChartState> _circularChartKey;

  @override
  void initState() {
    _circularChartKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(criterio);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      child: Column(children: <Widget>[
        Row(
          children: [
            SizedBox(width: 7),
            ElevatedButton(
                onPressed: () {
                  print("============================$qtdAtingiu");
                  _renderChartAsImage();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Icon(
                  Icons.image,
                  color: Colors.white,
                  size: 24.0,
                )),
          ],
        ),
        SfCircularChart(
            key: _circularChartKey,
            legend: Legend(isVisible: true),
            backgroundColor: Colors.white,
            title: ChartTitle(
              text: "Critério: " + criterio,
              backgroundColor: Colors.white,
            ),
            series: <CircularSeries>[
              // Renders doughnut chart
              DoughnutSeries<ChartData, String>(
                  dataSource: <ChartData>[
                    ChartData('Atingiu', qtdAtingiu),
                    ChartData('Parcial', qtdAtingiuParcialmente),
                    ChartData('Não atingiu', qtdNaoAtingiu),
                  ],
                  xValueMapper: (ChartData data, _) => data.status,
                  yValueMapper: (ChartData data, _) => data.porcentagem,
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]),
      ]),
    );
  }

  Future<void> _renderChartAsImage() async {
    print(_circularChartKey.currentState);
    final ui.Image data = await _circularChartKey.currentState.toImage();

    final ByteData bytes =
        await data.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List imageBytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    final Directory directory = await getApplicationSupportDirectory();
    final String path = directory.path;

    File file = File('$path/Output.png');

    await file.writeAsBytes(imageBytes);

    OpenFile.open('$path/Output.png');
  }
}

class ChartData {
  ChartData(this.status, this.porcentagem, [this.color]);
  final String status;
  final double porcentagem;
  final Color color;
}
