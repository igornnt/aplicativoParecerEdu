import 'package:cloud_firestore/cloud_firestore.dart';

class Avaliacao {

  String id;
  double peso;
  DocumentReference criterioRef;

  Avaliacao({this.peso, this.id, this.criterioRef});

  factory Avaliacao.fromFirestore(DocumentSnapshot documento) {
    Map dados = documento.data;

    return Avaliacao(
        id: documento.documentID,
        peso: dados['avaliacao'],
        criterioRef: dados['criterioRef']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'avaliacao' : peso,
      'criterioRef' : criterioRef
    };
  }

}