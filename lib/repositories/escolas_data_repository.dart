import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplicativoescolas/models/escola_model.dart';

class EscolasDataRepository {
  final Firestore _database = Firestore.instance;
  String _caminho = 'escolas';

  Stream<List<Escola>> buscaTodasAsEscolasComoStream() {
    var ref = this._database.collection(this._caminho);

    return ref.snapshots().map((lista) => lista.documents
        .map((documento) => Escola.fromFirestore(documento))
        .toList());
  }

  Future<List<Escola>> buscaTodas() async {
    var ref = this._database.collection(this._caminho);
    List<DocumentSnapshot> documentos = new List<DocumentSnapshot>();

    await ref.getDocuments().then((dados) => {
          dados.documents.forEach((documento) => {documentos.add(documento)})
        });

    return documentos.map((escolas) => Escola.fromFirestore(escolas)).toList();
  }

  Future<void> atualiza(Map data, String id) async {
    return await this
        ._database
        .collection(this._caminho)
        .document(id)
        .updateData(data);
  }

  Future<void> remove(String id) async {
    return await this._database.collection(this._caminho).document(id).delete();
  }

  Future<DocumentReference> adiciona(dynamic escola) async {
    return await this._database.collection(this._caminho).add(escola);
  }

  Stream<Escola> pegaPeloIDComoStream(String id) {
    var ref = this._database.collection(this._caminho).document(id);

    return ref.snapshots().map((documento) => Escola.fromFirestore(documento));
  }

  Future<Escola> pegaPeloID(String id) async {
    DocumentSnapshot doc;

    await this
        ._database
        .collection(this._caminho)
        .document(id)
        .get()
        .then((dado) {
      doc = dado;
    });

    return Escola.fromFirestore(doc);
  }
}
