import 'package:flutter/material.dart';

/// Chart import.
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../database/evaluation_provider.dart';

class ExportChartToPdf extends StatefulWidget {
  int idAluno;

  // ExportChartToPdf(this.idAluno);

  @override
  ExportChartToPdfState createState() => ExportChartToPdfState(this.idAluno);
}

class ExportChartToPdfState extends State<ExportChartToPdf> {
  int idAluno;

  ExportChartToPdfState(this.idAluno);

  double graficoLinguagens = 0;
  double graficocienciashumanas = 0;
  double graficocienciasnatureza = 0;
  double graficomatematica = 0;
  double graficoensinoreligioso = 0;

  GlobalKey<SfCartesianChartState> _cartesianChartKey;

  @override
  void initState() {
    calculaPorcentagens();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter Charts'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 550,
                  child: SfCartesianChart(
                    title: ChartTitle(text: "Desempenho indivídual"),
                    primaryXAxis: CategoryAxis(
                        title: AxisTitle(text: "Área de conhecimento")),
                    primaryYAxis:
                        NumericAxis(title: AxisTitle(text: "Score p/ área")),
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
        ));
  }

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

class SalesData {
  String x;
  double y;

  SalesData(this.x, this.y);
}
