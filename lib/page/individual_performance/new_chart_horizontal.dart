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

class HorizontalNewChart extends StatefulWidget {
  double peso;
  String criterio;
  String valorPercentual;

  HorizontalNewChart({this.peso, this.criterio, this.valorPercentual});

  @override
  State<StatefulWidget> createState() => HorizontalNewChartState(
      peso: this.peso,
      criterio: criterio,
      valorPercentual: this.valorPercentual);
}

class HorizontalNewChartState extends State<HorizontalNewChart> {
  double peso;
  String criterio;
  String valorPercentual;

  HorizontalNewChartState({this.peso, this.criterio, this.valorPercentual});

  GlobalKey<SfCartesianChartState> _cartesianChartKey;

  @override
  void initState() {
    _cartesianChartKey = GlobalKey();
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
            spreadRadius: 4,
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
        SfCartesianChart(
            key: _cartesianChartKey,
            backgroundColor: Colors.white,
            borderColor: Colors.white,
            title: ChartTitle(
              text: criterio + ": " + valorPercentual + " %",
              backgroundColor: Colors.white,
            ),
            series: <ChartSeries>[
              BarSeries<ChartData, String>(
                dataSource: <ChartData>[
                  ChartData(criterio, peso),
                ],
                xValueMapper: (ChartData data, _) => data.criterio,
                yValueMapper: (ChartData data, _) => data.peso,
                width: 0.3, // Width of the bars
                // Spacing between the bars
              ),
            ],
            primaryXAxis: CategoryAxis(isVisible: false),
            primaryYAxis: NumericAxis(
              isVisible: false,
              visibleMaximum: 1,
            ))
      ]),
    );
  }

  Future<void> _renderChartAsImage() async {
    final ui.Image data =
        await _cartesianChartKey.currentState.toImage(pixelRatio: 3.0);

    final ByteData bytes =
        await data.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List imageBytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    final Directory directory = await getApplicationSupportDirectory();
    final String path = directory.path;
    //Create an empty file to write PDF data
    File file = File('$path/Output.jpg');

    await file.writeAsBytes(imageBytes);

    OpenFile.open('$path/Output.jpg');
  }
}

class ChartData {
  ChartData(this.criterio, this.peso);

  final String criterio;
  final double peso;
}
