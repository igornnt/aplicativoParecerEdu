import 'package:aplicativoescolas/models/avaliacao_model.dart';

class ProcessadorDeAvaliacoes {
  double valorPorcentagem = 100;

  double resultado;

  List<Avaliacao> listAvaliacoes;

  ProcessadorDeAvaliacoes(List<Avaliacao> avaliacoes) {
    this.listAvaliacoes = avaliacoes;
    resultado = 0;
  }

  double processaAvaliacaoIndividual() {
    this.listAvaliacoes.forEach((avaliacao) => {resultado += avaliacao.peso});
    return (resultado * valorPorcentagem) / listAvaliacoes.length;
  }

  double processaAvaliacaoGeralParaAtingiu() {
    int resultadoParcial = 0;
    this.listAvaliacoes.forEach((avaliacao) => {
          if (avaliacao.peso == 1) {resultadoParcial += 1}
        });
    return (resultadoParcial * valorPorcentagem) / listAvaliacoes.length;
  }

  double processaAvaliacaoGeralParaParcial() {
    int resultadoParcial = 0;
    this.listAvaliacoes.forEach((avaliacao) => {
          if (avaliacao.peso == 0.5) {resultadoParcial += 1}
        });
    return (resultadoParcial * valorPorcentagem) / listAvaliacoes.length;
  }

  double processaAvaliacaoGeralParaNaoAtingiu() {
    int resultadoParcial = 0;
    this.listAvaliacoes.forEach((avaliacao) => {
          if (avaliacao.peso == 0) {resultadoParcial += 1}
        });
    return (resultadoParcial * valorPorcentagem) / listAvaliacoes.length;
  }
}
