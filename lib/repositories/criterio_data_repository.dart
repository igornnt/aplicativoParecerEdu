import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parecer_app/models/criterio_model.dart';

class CriterioDataRepository {

  final Firestore _database = Firestore.instance;
  String _caminho = 'escolas';

  CriterioDataRepository(String escolaID, String turmaID) {
    this._caminho = this._caminho + '/' + escolaID + '/turmas/' + turmaID + '/criterios';
  }

  Stream<List<Criterio>> buscaTodasAsComoStream() {
    var ref = this._database.collection(this._caminho);

    return ref.snapshots().map((lista) =>
        lista.documents
            .map((documento) => Criterio.fromFirestore(documento))
            .toList());
  }

  Future<List<Criterio>> buscaTodas() async {
    var ref = this._database.collection(this._caminho);
    List<DocumentSnapshot> documentos = new List<DocumentSnapshot>();

    await ref.getDocuments().then((dados) => {
      dados.documents.forEach((documento) => {
        documentos.add(documento)
      })
    });
    return documentos.map((criterios) => Criterio.fromFirestore(criterios)).toList();
  }

  Future<List<Criterio>> buscaTodasPelaArea(String areaDoConhecimento) async {
    var ref = this._database.collection(this._caminho).where('areaRef', isEqualTo: areaDoConhecimento);
    List<DocumentSnapshot> documentos = new List<DocumentSnapshot>();

    await ref.getDocuments().then((dados) => {
      dados.documents.forEach((documento) => {
        documentos.add(documento)
      })
    });

    return documentos.map((criterios) => Criterio.fromFirestore(criterios))
        .toList();
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

  Future<DocumentReference> adiciona(dynamic criterio) async {
    return await this._database.collection(this._caminho).add(criterio);
  }

  Stream<Criterio> pegaPeloIDComoStream(String id) {
    var ref = this._database.collection(this._caminho).document(id);

    return ref.snapshots().map((documento) => Criterio.fromFirestore(documento));
  }

  Future<Criterio> pegaPeloID(String id) async {
    DocumentSnapshot doc;

    await this._database.collection(this._caminho).document(id).get().then((
        dado) {
      doc = dado;
    });

    return Criterio.fromFirestore(doc);
  }

  Future<DocumentReference> pegaPeloReferece(String id) async {
    DocumentReference doc;

    await this._database.collection(this._caminho).document(id).get().then((
        dado) {
      doc = dado.reference;
    });

    return doc;
  }

}