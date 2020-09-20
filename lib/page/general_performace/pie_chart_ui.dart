  
import 'package:aplicativoescolas/page/individual_performance/indicador.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartGeneral extends StatefulWidget {
   
   String criterio;
   double qtdAtingiu;
   double qtdAtingiuParcialmente;
   double qtdNaoAtingiu;

  PieChartGeneral({this.qtdAtingiu, this.qtdAtingiuParcialmente, this.qtdNaoAtingiu, this.criterio});

  @override
  State<StatefulWidget> createState() => PieChartGeneralState(qtdAtingiu: this.qtdAtingiu,
   qtdAtingiuParcialmente: this.qtdAtingiuParcialmente,
   qtdNaoAtingiu: this.qtdNaoAtingiu,
   criterio: criterio
   );
}

class PieChartGeneralState extends State<PieChartGeneral> {
 
  int touchedIndex;
  String criterio;
  double qtdAtingiu;
   double qtdAtingiuParcialmente;
   double qtdNaoAtingiu;

  PieChartGeneralState({this.qtdAtingiu, this.qtdAtingiuParcialmente, this.qtdNaoAtingiu, this.criterio});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(child: Text(criterio)),
          )),
        SizedBox(height: 0),  
        AspectRatio(
          aspectRatio: 1.3,
          child: Card(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                            setState(() {
                              if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                  pieTouchResponse.touchInput is FlPanEnd) {
                                touchedIndex = -1;
                              } else {
                                touchedIndex = pieTouchResponse.touchedSectionIndex;
                              }
                            });
                          }),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections()),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Indicator(
                      color: Color(0xff0293ee),
                      text: 'Atingiu',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Color(0xfff8b250),
                      text: 'Atingiu Parcialmente',
                      isSquare: true,

                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Color(0xff845bef),
                      text: 'Não Atingiu',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {

    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 10;
      final double radius = isTouched ? 60 : 50;
      switch (i) {

        //Atingiu
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: qtdAtingiu,
            title: '$qtdAtingiu%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: qtdAtingiuParcialmente,
            title: '$qtdAtingiuParcialmente%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: qtdNaoAtingiu,
            title: '$qtdNaoAtingiu%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}