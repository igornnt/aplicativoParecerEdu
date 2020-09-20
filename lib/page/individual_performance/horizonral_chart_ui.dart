import 'package:flutter/material.dart';

class HorizontalChart extends StatefulWidget {
  String criterio;
  double peso;

  HorizontalChart(this.criterio, this.peso);

  @override
  _HorizontalChartState createState() => _HorizontalChartState();
}

class _HorizontalChartState extends State<HorizontalChart> {
  double largura = 0;
  double larguraRow = 100;
  bool voltou = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        if (widget.peso == 1) {
          this.largura = MediaQuery.of(context).size.width - 20;
          this.larguraRow = MediaQuery.of(context).size.width - 20;
        }
        if (widget.peso == 0.5) {
          this.largura = (MediaQuery.of(context).size.width - 20) / 2;
          this.larguraRow = MediaQuery.of(context).size.width - 20;
        }
        if (widget.peso == 0 && voltou == false) {
          this.largura = MediaQuery.of(context).size.width - 20;
          this.larguraRow = MediaQuery.of(context).size.width - 20;
          voltou = true;
        }
      });
    });
    new Future.delayed(const Duration(milliseconds: 1000), () {
      if (voltou == true) {
        setState(() {
          this.largura = 0;
        });
      }
    });
    return Container(
      height: 300,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(widget.criterio),
          SizedBox(
            height: 20,
          ),
          grafico(context),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget grafico(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 20,
                color: Colors.grey[300],
              ),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                height: 50,
                width: largura,
                color: Colors.blue,
              ),
            ],
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 50,
            width: larguraRow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text("0%"), Text("50%"), Text("100%")],
            ),
          ),
        ],
      ),
    );
  }
}
