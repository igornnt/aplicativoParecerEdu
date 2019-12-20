import 'package:cloud_firestore/cloud_firestore.dart';

class EscolasResource {

  Firestore firestore = Firestore.instance;

  void criaNovaEscola(String nome) async {
    print("salva?");
    DocumentReference reference = await this.firestore.collection("escola").add(
      {
        "nome": nome
      }
    );
  }

}