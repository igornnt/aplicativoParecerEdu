import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parecer_app/models/area_do_conhecimanto.dart';

class AreasDoConhecimentoDataRepository {

  final Firestore _database = Firestore.instance;
  String _caminho = 'areas-de-conhecimento';

  Stream<List<AreaDoConhecimento>> buscaTodasComoStream() {
    var ref = this._database.collection(this._caminho);

    return ref.snapshots().map((lista) =>
        lista.documents
            .map((documento) => AreaDoConhecimento.fromFirestore(documento))
            .toList());
  }

  Future<List<AreaDoConhecimento>> buscaTodas() async {
    var ref = this._database.collection(this._caminho);
    List<DocumentSnapshot> documentos = new List<DocumentSnapshot>();

    await ref.getDocuments().then((dados) => {
      dados.documents.forEach((documento) => {
        documentos.add(documento)
      })
    });

    return documentos.map((areas) => AreaDoConhecimento.fromFirestore(areas)).toList();
  }

}
