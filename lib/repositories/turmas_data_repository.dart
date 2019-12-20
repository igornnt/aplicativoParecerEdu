import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parecer_app/models/turma_model.dart';

class TurmasDataRepository {

  final Firestore _database = Firestore.instance;
  String _caminho = 'escolas';

  TurmasDataRepository(String escolaID) {
    this._caminho = this._caminho + '/' + escolaID + '/turmas';
  }

  Stream<List<Turma>> buscaTodasAsEscolasComoStream() {
    var ref = this._database.collection(this._caminho);

    return ref.snapshots().map((lista) => lista.documents
        .map((documento) => Turma.fromFirestore(documento))
        .toList());
  }

  Future<List<Turma>> buscaTodas() async {
    var ref = this._database.collection(this._caminho);
    List<DocumentSnapshot> documentos = new List<DocumentSnapshot>();

    await ref.getDocuments().then((dados) => {
          dados.documents.forEach((documento) => {documentos.add(documento)})
        });

    return documentos.map((escolas) => Turma.fromFirestore(escolas)).toList();
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

  Future<DocumentReference> adiciona(dynamic turma) async {
    return await this._database.collection(this._caminho).add(turma);
  }

  Stream<Turma> pegaPeloIDComoStream(String id) {
    var ref = this._database.collection(this._caminho).document(id);

    return ref.snapshots().map((documento) => Turma.fromFirestore(documento));
  }

  Future<Turma> pegaPeloID(String id) async {
    DocumentSnapshot doc;

    await this
        ._database
        .collection(this._caminho)
        .document(id)
        .get()
        .then((dado) {
      doc = dado;
    });

    return Turma.fromFirestore(doc);
  }

}
