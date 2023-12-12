import 'package:aplicativoescolas/database/evaluation_provider.dart';
import 'package:aplicativoescolas/model/evaluation.dart';
import 'package:aplicativoescolas/model/student.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:io';

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// Chart import.
import 'package:syncfusion_flutter_charts/charts.dart';

/// Pdf import.
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// Chart import.
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../database/evaluation_provider.dart';
import '../../model/class_school.dart';

class LineChartSample2 extends StatefulWidget {
  int idAluno;
  String classSchool;
  String nomeAluno;

  LineChartSample2(this.idAluno, this.classSchool, this.nomeAluno);

  @override
  _LineChartSample2State createState() =>
      _LineChartSample2State(this.idAluno, this.classSchool, this.nomeAluno);
}

class _LineChartSample2State extends State<LineChartSample2> {
  int idAluno;
  String classSchool;
  String nomeAluno;

  _LineChartSample2State(this.idAluno, this.classSchool, this.nomeAluno);

  GlobalKey<SfCartesianChartState> _cartesianChartKey;

  double graficoLinguagens = 0;
  double graficocienciashumanas = 0;
  double graficocienciasnatureza = 0;
  double graficomatematica = 0;
  double graficoensinoreligioso = 0;

  dynamic getColumnData() {
    List<SalesData> columnData = <SalesData>[
      SalesData("LIN", graficoLinguagens),
      SalesData("C. HUM", graficocienciashumanas),
      SalesData("C. NAT", graficocienciasnatureza),
      SalesData("MAT", graficomatematica),
      SalesData("ENS. R", graficoensinoreligioso),
    ];

    return columnData;
  }

  @override
  void initState() {
    _cartesianChartKey = GlobalKey();
    calculaPorcentagens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                SizedBox(width: 25),
                ElevatedButton(
                    onPressed: () {
                      print(classSchool);
                      _renderPDF();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    ),
                    child: Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    )),
                SizedBox(width: 25),
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
            Container(
              height: 300,
              child: SfCartesianChart(
                key: _cartesianChartKey,
                borderColor: Colors.white,
                backgroundColor: Colors.white,
                title: ChartTitle(
                  text: "Desempenho de " + nomeAluno,
                  backgroundColor: Colors.white,
                ),
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                series: <ChartSeries>[
                  ColumnSeries<SalesData, String>(
                    dataSource: getColumnData(),
                    xValueMapper: (SalesData sales, _) => sales.x,
                    yValueMapper: (SalesData sales, _) => sales.y,
                  )
                ],
              ),
            )
          ]),
    );
  }

  calculaPorcentagens() {
    Data linguagens = new Data();
    Data chumanas = new Data();
    Data cnatureza = new Data();
    Data matematica = new Data();
    Data ensreligioso = new Data();
    EvaluationProvider.db
        .getAllEvaluationIdStutedent(this.idAluno)
        .then((onValue) {
      onValue.forEach((f) {
        if (f.idArea == 1) {
          linguagens.ocorrencia(f.peso);
        }
        if (f.idArea == 2) {
          chumanas.ocorrencia(f.peso);
        }
        if (f.idArea == 3) {
          cnatureza.ocorrencia(f.peso);
        }
        if (f.idArea == 4) {
          matematica.ocorrencia(f.peso);
        }
        if (f.idArea == 5) {
          ensreligioso.ocorrencia(f.peso);
        }
      });
      setState(() {
        if (linguagens.total > 0) {
          this.graficoLinguagens = ((5 * linguagens.calculo()) / 100);
        }
        if (chumanas.total > 0) {
          this.graficocienciashumanas = ((5 * chumanas.calculo()) / 100);
        }
        if (cnatureza.total > 0) {
          this.graficocienciasnatureza = ((5 * cnatureza.calculo()) / 100);
        }
        if (matematica.total > 0) {
          this.graficomatematica = ((5 * matematica.calculo()) / 100);
        }
        if (ensreligioso.total > 0) {
          this.graficoensinoreligioso = ((5 * ensreligioso.calculo()) / 100);
        }
      });
    });
  }

  Future<void> _renderPDF() async {
    final List<int> imageBytes = await _readImageData();
    final PdfBitmap bitmap = PdfBitmap(imageBytes);
    final PdfDocument document = PdfDocument();

    final PdfPage page = document.pages.add();

    final Size pageSize = page.getClientSize();
    PdfBrush solidBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    Rect bounds = Rect.fromLTWH(0, 0, page.graphics.clientSize.width, 30);

//Draws a rectangle to place the heading in that region
    page.graphics.drawRectangle(brush: solidBrush, bounds: bounds);

//Creates a font for adding the heading in the page
    PdfFont subHeadingFont = PdfStandardFont(PdfFontFamily.timesRoman, 14);

//Creates a text element to add the invoice number
    PdfTextElement element = PdfTextElement(text: '-', font: subHeadingFont);
    element.brush = PdfBrushes.white;

//Draws the heading on the page
    PdfLayoutResult result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, bounds.top + 8, 0, 0));

//Use 'intl' package for date format.
    String currentDate =
        'Data: ' + DateFormat('dd-MM-yyyy').format(DateTime.now());

//Measures the width of the text to place it in the correct location
    Size textSize = subHeadingFont.measureString(currentDate);
    Offset textPosition = Offset(
        page.graphics.clientSize.width - textSize.width - 10,
        result.bounds.top);

//Draws the date by using drawString method
    page.graphics.drawString(currentDate, subHeadingFont,
        brush: element.brush,
        bounds: Offset(page.graphics.clientSize.width - textSize.width - 10,
                result.bounds.top) &
            Size(textSize.width + 2, 20));

//Creates text elements to add the address and draw it to the page
    element = PdfTextElement(
        text: nomeAluno,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 20,
            style: PdfFontStyle.bold));
    element.brush = PdfSolidBrush(PdfColor(126, 155, 203));
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

    PdfFont timesRoman = PdfStandardFont(PdfFontFamily.timesRoman, 10);

    element = PdfTextElement(text: '-', font: timesRoman);
    element.brush = PdfBrushes.black;

    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0));

//Draws a line at the bottom of the address
    page.graphics.drawLine(
        PdfPen(PdfColor(126, 151, 173), width: 0.7),
        Offset(0, result.bounds.bottom + 3),
        Offset(page.graphics.clientSize.width, result.bounds.bottom + 3));

//Creates the header style
    PdfGridCellStyle headerStyle = PdfGridCellStyle();
    headerStyle.borders.all = PdfPen(PdfColor(126, 151, 173));
    headerStyle.backgroundBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    headerStyle.textBrush = PdfBrushes.white;
    headerStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 14,
        style: PdfFontStyle.regular);

    page.graphics.drawString(
        'Desempenho Global', PdfStandardFont(PdfFontFamily.timesRoman, 14),
        bounds: Rect.fromLTWH(90, 100, 300, 50));
    //Tamanho do gráfico
    page.graphics.drawImage(bitmap, Rect.fromLTWH(90, 150, 350, 450));

    final List<int> bytes = document.save();
    document.dispose();
    //Get external storage directory
    final Directory directory = await getApplicationSupportDirectory();
    //Get directory path
    final String path = directory.path;
    //Create an empty file to write PDF data
    File file = File('$path/Output.pdf');
    //Write PDF bytes data
    await file.writeAsBytes(bytes, flush: true);
    //Open the PDF document in mobile
    OpenFile.open('$path/Output.pdf');
  }

  Future<List<int>> _readImageData() async {
    final ui.Image data =
        await _cartesianChartKey.currentState.toImage(pixelRatio: 3.0);

    print(data);

    final ByteData bytes =
        await data.toByteData(format: ui.ImageByteFormat.png);
    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
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

class SalesData {
  String x;
  double y;

  SalesData(this.x, this.y);
}

class Data {
  int total;
  int porcentagem = 100;
  double peso;

  Data() {
    total = 0;
    peso = 0;
  }

  double calculo() {
    if (peso == null) {
      return 0;
    } else
      return (peso * porcentagem) / total;
  }

  ocorrencia(double p) {
    this.total++;
    peso = peso + p;
  }
}
