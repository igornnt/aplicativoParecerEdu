import 'package:cloud_firestore/cloud_firestore.dart';

class AreaDoConhecimento {

  String id;
  String area;

  AreaDoConhecimento({this.id, this.area});

  factory AreaDoConhecimento.fromFirestore(DocumentSnapshot documento) {
    Map dados = documento.data;

    return AreaDoConhecimento(
        id: documento.documentID,
        area: dados['area']
    );
  }

}