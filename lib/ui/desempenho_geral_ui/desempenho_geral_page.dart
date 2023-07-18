import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:aplicativoescolas/models/avaliacao_model.dart';
import 'package:aplicativoescolas/models/processa_avaliacao_service.dart';
import 'package:aplicativoescolas/repositories/aluno_data_repository.dart';
import 'package:aplicativoescolas/repositories/alunos_data_repository.dart';
import 'package:aplicativoescolas/repositories/avaliacoes_data_repository.dart';

class DesempenhoGeral extends StatefulWidget {
  String escolaId;
  String turmaId;

  DesempenhoGeral(this.escolaId, this.turmaId);

  @override
  _DesempenhoGeralState createState() =>
      _DesempenhoGeralState(escolaId, turmaId);
}

class _DesempenhoGeralState extends State<DesempenhoGeral> {
  String escolaId;
  String turmaId;
  double atingiu = 0;
  double naoAtingiu = 0;
  double atingiuParcialmente = 0;
  AlunosDataRepository repositoryAlunos;
  // = List<CircularStackEntry>();

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  _DesempenhoGeralState(this.escolaId, this.turmaId) {
    repositoryAlunos = AlunosDataRepository(this.escolaId, this.turmaId);
    realizaAvaliacaoGeral();
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  List<CircularStackEntry> data = <CircularStackEntry>[
    CircularStackEntry(
      <CircularSegmentEntry>[],
      rankKey: 'Partes',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Desempenho Geral"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 13,
                        width: 13,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 8,
                        width: 8,
                      ),
                      Text(atingiu.toString() + "% Atingiu"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 13,
                        width: 13,
                        color: Colors.pink,
                      ),
                      SizedBox(
                        height: 8,
                        width: 8,
                      ),
                      Text(atingiuParcialmente.toString() +
                          "% Atingiu parcialmente"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 13,
                        width: 13,
                        color: Colors.green,
                      ),
                      SizedBox(
                        height: 8,
                        width: 8,
                      ),
                      Text(naoAtingiu.toString() + "% Não atingiu"),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedCircularChart(
              key: _chartKey,
              size: const Size(400, 400),
              initialChartData: data,
              chartType: CircularChartType.Pie,
              percentageValues: true,
              duration: Duration(seconds: 0),
            ),
          ],
        ),
      ),
    );
  }

  void realizaAvaliacaoGeral() async {
    List<Avaliacao> todasAvaliacoes = List<Avaliacao>();
    AvaliacoesDataRepository avaliecoesDataRepository;
    repositoryAlunos.buscaTodas().then((alunos) {
      alunos.forEach((aluno) => {
            avaliecoesDataRepository =
                AvaliacoesDataRepository(this.escolaId, this.turmaId, aluno.id),
            avaliecoesDataRepository.buscaTodas().then((avaliacoes) => {
                  avaliacoes
                      .forEach((avaliacao) => {todasAvaliacoes.add(avaliacao)}),
                  setState(() {
                    ProcessadorDeAvaliacoes processadorDeAvaliacoes =
                        new ProcessadorDeAvaliacoes(todasAvaliacoes);
                    this.atingiu = num.parse(processadorDeAvaliacoes
                        .processaAvaliacaoGeralParaAtingiu()
                        .toStringAsFixed(2));
                    this.atingiuParcialmente = num.parse(processadorDeAvaliacoes
                        .processaAvaliacaoGeralParaParcial()
                        .toStringAsFixed(2));
                    this.naoAtingiu = num.parse(processadorDeAvaliacoes
                        .processaAvaliacaoGeralParaNaoAtingiu()
                        .toStringAsFixed(2));

                    List<CircularStackEntry> nextData = <CircularStackEntry>[
                      CircularStackEntry(
                        <CircularSegmentEntry>[
                          new CircularSegmentEntry(atingiu, Colors.blue,
                              rankKey: 'Q1'),
                          new CircularSegmentEntry(
                              atingiuParcialmente, Colors.pink,
                              rankKey: 'Q2'),
                          new CircularSegmentEntry(naoAtingiu, Colors.green,
                              rankKey: 'Q3'),
                        ],
                        rankKey: 'Nova data',
                      )
                    ];
                    _chartKey.currentState.updateData(nextData);
                  })
                })
          });
    });
  }
}
