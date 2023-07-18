import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplicativoescolas/models/turma_model.dart';

class Escola {
  String id;
  String nome;
  List<Turma> turmas;

  Escola({this.id, this.nome, this.turmas});

  factory Escola.fromFirestore(DocumentSnapshot documento) {
    Map dados = documento.data;

    return Escola(id: documento.documentID, nome: dados['nome']);
  }

  void setNomeEscola(String nome) {
    this.nome = nome;
  }

  Map<String, dynamic> toMap() {
    return {'nome': nome};
  }

  String nomeEscola() {
    return this.nome;
  }
}
