import 'package:cloud_firestore/cloud_firestore.dart';

class Turma {

  String id;
  String nome;

  int _qtdAlunos;

  Turma({this.nome, this.id}) {
    this._qtdAlunos = 0;
  }

  factory Turma.fromFirestore(DocumentSnapshot documento) {
    Map dados = documento.data;

    return Turma(
        id: documento.documentID,
        nome: dados['nome']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome' : nome
    };
  }

  String getNomeTurma() {
    return this.nome;
  }

}