import 'package:cloud_firestore/cloud_firestore.dart';

class Criterio {

  String id;
  String descricao;
  String areaRef;

  Criterio({this.descricao, this.id, this.areaRef});

  factory Criterio.fromFirestore(DocumentSnapshot documento) {
    Map dados = documento.data;

    return Criterio(
        id: documento.documentID,
        descricao: dados['descricao'],
        areaRef: dados['areaRef']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'descricao' : descricao,
      'areaRef' : areaRef
    };
  }

  String getDescricao() {
    return this.descricao;
  }

}