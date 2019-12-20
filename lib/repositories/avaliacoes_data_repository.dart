import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parecer_app/models/avaliacao_model.dart';

class AvaliacoesDataRepository {


  final Firestore _database = Firestore.instance;
  String _caminho = 'escolas';

  AvaliacoesDataRepository(String escolaID, String turmaID, String alunoID) {
    this._caminho = this._caminho + '/' + escolaID + '/turmas/' + turmaID + '/alunos/' + alunoID + '/avaliacoes';
  }

  Stream<List<Avaliacao>> buscaTodasAsComoStream() {
    var ref = this._database.collection(this._caminho);

    return ref.snapshots().map((lista) =>
        lista.documents
            .map((documento) => Avaliacao.fromFirestore(documento))
            .toList());
  }

  Future<List<Avaliacao>> buscaTodas() async {
    var ref = this._database.collection(this._caminho);
    List<DocumentSnapshot> documentos = new List<DocumentSnapshot>();

    await ref.getDocuments().then((dados) => {
      dados.documents.forEach((documento) => {
        documentos.add(documento)
      })
    });

    return documentos.map((avaliacoes) => Avaliacao.fromFirestore(avaliacoes)).toList();
  }

  Future<List<Avaliacao>> buscaTodasPeloCriterio(DocumentReference criterioRef) async {
    var ref = this._database.collection(this._caminho).where('criterioRef', isEqualTo: criterioRef);
    List<DocumentSnapshot> documentos = new List<DocumentSnapshot>();

    await ref.getDocuments().then((dados) => {
      dados.documents.forEach((documento) => {
        documentos.add(documento)
      })
    });

    return documentos.map((avaliacoes) => Avaliacao.fromFirestore(avaliacoes))
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

  Future<DocumentReference> adiciona(dynamic avaliacao) async {
    return await this._database.collection(this._caminho).add(avaliacao);
  }

  Stream<Avaliacao> pegaPeloIDComoStream(String id) {
    var ref = this._database.collection(this._caminho).document(id);

    return ref.snapshots().map((documento) => Avaliacao.fromFirestore(documento));
  }

  Future<Avaliacao> pegaPeloID(String id) async {
    DocumentSnapshot doc;

    await this._database.collection(this._caminho).document(id).get().then((
        dado) {
      doc = dado;
    });

    return Avaliacao.fromFirestore(doc);
  }

}