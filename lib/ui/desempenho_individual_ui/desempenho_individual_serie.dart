import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class DesempenhoSeries {

  String areaConhecimento;
  double metrica;
  charts.Color barColor;

  DesempenhoSeries(
      {@required this.areaConhecimento,
      @required this.metrica,
      @required this.barColor});

}
