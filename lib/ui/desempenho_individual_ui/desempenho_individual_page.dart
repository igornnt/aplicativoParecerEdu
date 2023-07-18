import 'package:flutter/material.dart';
import 'package:aplicativoescolas/models/avaliacao_model.dart';
import 'package:aplicativoescolas/models/processa_avaliacao_service.dart';
import 'package:aplicativoescolas/repositories/avaliacoes_data_repository.dart';
import 'package:aplicativoescolas/repositories/criterio_data_repository.dart';
import 'desempenho_individual_chart.dart';
import 'desempenho_individual_serie.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DesempenhoIndividual extends StatefulWidget {
  String turmaID;
  String escolaID;
  String alunoID;

  DesempenhoIndividual(turmaID, escolaID, alunoID) {
    this.turmaID = turmaID;
    this.escolaID = escolaID;
    this.alunoID = alunoID;
  }

  @override
  _DesempenhoIndividualState createState() =>
      _DesempenhoIndividualState(this.turmaID, this.escolaID, this.alunoID);
}

class _DesempenhoIndividualState extends State<DesempenhoIndividual> {
  String turmaID;
  String escolaID;
  String alunoID;
  List<Avaliacao> avaliacoes;
  AvaliacoesDataRepository avaliacoesDataRepository;
  CriterioDataRepository criterioDataRepository;

  final valorPorcentagem = 100;

  double resultado;

  List<Avaliacao> listAvaliacoes;

  double soma = 0;
  List<DesempenhoSeries> data = List();

  @override
  void initState() {
    super.initState();
  }

  _DesempenhoIndividualState(turmaID, escolaID, alunoID) {
    this.turmaID = turmaID;
    this.escolaID = escolaID;
    this.alunoID = alunoID;
    avaliacoesDataRepository =
        AvaliacoesDataRepository(this.escolaID, this.turmaID, this.alunoID);
    criterioDataRepository =
        CriterioDataRepository(this.escolaID, this.turmaID);
    this.realizaAvaliacaoIndividual();
  }

  void populaLista() {
    data = [
      DesempenhoSeries(
          areaConhecimento: "Ling",
          metrica: soma,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      DesempenhoSeries(
          areaConhecimento: "Mat",
          metrica: 45,
          barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      DesempenhoSeries(
          areaConhecimento: "C.H",
          metrica: 76,
          barColor: charts.ColorUtil.fromDartColor(Colors.amber)),
      DesempenhoSeries(
          areaConhecimento: "C.N",
          metrica: 81,
          barColor: charts.ColorUtil.fromDartColor(Colors.indigo)),
      DesempenhoSeries(
          areaConhecimento: "E.R",
          metrica: 29,
          barColor: charts.ColorUtil.fromDartColor(Colors.deepOrange)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Desempenho Individual"),
      ),
      body: Center(
          child: DesempenhoIndividualChart(
        data: data,
      )),
    );
  }

  void realizaAvaliacaoIndividual() async {
    List<Avaliacao> avaliacoesA = List<Avaliacao>();

    await avaliacoesDataRepository.buscaTodas().then((dado) {
      avaliacoes = dado;
      this.avaliacoes.forEach((avaliacao) => {
            avaliacao.criterioRef.get().then((criterio) => {
                  setState(() {
                    if (criterio.data["areaRef"] == "LINGUAGENS") {
                      print('O PESO ENCONTRADO: ' + avaliacao.peso.toString());
                      avaliacoesA.add(avaliacao);
                    }

                    ProcessadorDeAvaliacoes processador =
                        ProcessadorDeAvaliacoes(avaliacoesA);
                    soma = processador.processaAvaliacaoIndividual();
                    this.populaLista();
                  })
                })
          });
    });
  }
}
