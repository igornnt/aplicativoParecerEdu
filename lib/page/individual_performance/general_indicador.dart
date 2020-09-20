import 'package:aplicativoescolas/database/evaluation_provider.dart';
import 'package:aplicativoescolas/model/evaluation.dart';
import 'package:aplicativoescolas/model/student.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  
  int idAluno;


  LineChartSample2(this.idAluno);

  @override
  _LineChartSample2State createState() => _LineChartSample2State(this.idAluno);
}

class _LineChartSample2State extends State<LineChartSample2> {
  int idAluno;

  _LineChartSample2State(this.idAluno);

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  double graficoLinguagens = 0;
  double graficocienciashumanas = 0;
  double graficocienciasnatureza = 0;
  double graficomatematica = 0;
  double graficoensinoreligioso = 0;


  @override
  void initState() {
    calculaPorcentagens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.4,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.3),
                    ),
                    color: Colors.transparent),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 18.0, left: 12.0, top: 24, bottom: 12),
                  child: LineChart(
                    mainData(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 8),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'LIN';
              case 3:
                return 'C. HUM'; 
              case 5:
                return 'C. NAT';
              case 7:
                return 'MAT';
              case 9:
                return 'ENS. R';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0%';
              case 3:
                return '50%';
              case 5:
                return '100%';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Colors.blue, width: 0.5)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, graficoLinguagens),
            FlSpot(1, graficoLinguagens),
            FlSpot(2.9,graficocienciashumanas),
            FlSpot(5, graficocienciasnatureza),
            FlSpot(6.8, graficomatematica),
            FlSpot(9.5, graficoensinoreligioso),
            FlSpot(11, graficoensinoreligioso),
          ],
          isCurved: false,
          colors: gradientColors,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  calculaPorcentagens(){
    Data linguagens = new Data();
    Data chumanas = new Data();
    Data cnatureza = new Data();
    Data matematica = new Data();
    Data ensreligioso = new Data();
   EvaluationProvider.db.getAllEvaluationIdStutedent(this.idAluno).then((onValue){
     onValue.forEach((f){
        if(f.idArea == 1){
          linguagens.ocorrencia(f.peso);
        }
        if(f.idArea == 2){
          chumanas.ocorrencia(f.peso);
        }
        if(f.idArea == 3){
          cnatureza.ocorrencia(f.peso);
        }
        if(f.idArea == 4){
          matematica.ocorrencia(f.peso);
        }
        if(f.idArea == 5){
          ensreligioso.ocorrencia(f.peso);
        }
     });
    setState(() {
      if(linguagens.total > 0){
         this.graficoLinguagens = ((5 * linguagens.calculo())/100);
      }
      if(chumanas.total > 0){
         this.graficocienciashumanas = ((5 * chumanas.calculo())/100);
      }
      if(cnatureza.total > 0){
         this.graficocienciasnatureza = ((5 * cnatureza.calculo())/100);
      }
      if(matematica.total > 0){
        this.graficomatematica = ((5 * matematica.calculo())/100);
      }
      if(ensreligioso.total > 0){
        this.graficoensinoreligioso = ((5* ensreligioso.calculo())/100);
      }
   });                              
   });
  }


}

class Data {

 int total;
 int porcentagem = 100;
 double peso;

  Data(){
    total = 0;
    peso = 0;
  }

  double calculo(){
    if(peso == null){
      return 0;
    }else
    return (peso * porcentagem) / total;
  }

  ocorrencia(double p){
    this.total ++;
    peso = peso + p;
  }

}
