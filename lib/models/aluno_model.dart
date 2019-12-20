import 'package:cloud_firestore/cloud_firestore.dart';

class Aluno {

  String id;
  String nome;
  List<String> observacoes = List<String>();

  Aluno({this.nome, this.id, this.observacoes});

  factory Aluno.fromFirestore(DocumentSnapshot documento) {
    Map dados = documento.data;

    return Aluno(
        id: documento.documentID,
        nome: dados['nome'],
        observacoes: dados['observacoes']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome' : nome
    };
  }

  static List<int> metrica = new List();

  String getNomeAluno() {
    return this.nome;
  }

  void avaliarAluno(int avaliacao) {
    //"atingiu"
    if(avaliacao == 1){
      metrica.add(1);
    }
    //"atingiu parcialmente"
    else if(avaliacao == 0)
      metrica.add(0);
    //não atingiu
    else if(avaliacao == -1) {
      metrica.add(-1);
    }
  }

  void adicionaNovaObservacao(String observacao) {
    this.observacoes.add(observacao);
  }

  void removeObservacao(int indice) {
    this.observacoes.removeAt(indice);
  }

}