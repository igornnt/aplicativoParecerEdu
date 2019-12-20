import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parecer_app/models/aluno_model.dart';
import 'package:parecer_app/models/avaliacao_model.dart';

import 'avaliacoes_data_repository.dart';

class AlunosDataRepository {

  final Firestore _database = Firestore.instance;
  String _caminho = 'escolas';
  String _escolaID;
  String _turmaID;

  AlunosDataRepository(String escolaID, String turmaID) {
    this._escolaID = escolaID;
    this._turmaID = turmaID;
    this._caminho = this._caminho + '/' + escolaID + '/turmas/' + turmaID + '/alunos';
  }

  Stream<List<Aluno>> buscaTodasComoStream() {
    var ref = this._database.collection(this._caminho);

    return ref.snapshots().map((lista) => lista.documents
        .map((documento) => Aluno.fromFirestore(documento))
        .toList());
  }

  Future<List<Aluno>> buscaTodas() async {
    var ref = this._database.collection(this._caminho);
    List<DocumentSnapshot> documentos = new List<DocumentSnapshot>();

    await ref.getDocuments().then((dados) => {
      dados.documents.forEach((documento) => {documentos.add(documento)})
    });

    return documentos.map((alunos) => Aluno.fromFirestore(alunos)).toList();
  }

  Future<List<Avaliacao>> buscaTodasAsAvaliacoesDosAlunos() async {
    List<Avaliacao> todasAvaliacoes = List<Avaliacao>();

    AvaliacoesDataRepository avaliecoesDataRepository;
    await this.buscaTodas().then((alunos) => {
      alunos.forEach((aluno) => {
        avaliecoesDataRepository = AvaliacoesDataRepository(this._escolaID, this._turmaID, aluno.id),
        avaliecoesDataRepository.buscaTodas().then((avaliacoes) => {
          avaliacoes.forEach((avaliacao) => {
            todasAvaliacoes.add(avaliacao)
          }),

          print(todasAvaliacoes.length)
        })
      })
    });

    return todasAvaliacoes;
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

  Future<DocumentReference> adiciona(dynamic aluno) async {
    return await this._database.collection(this._caminho).add(aluno);
  }

  Stream<Aluno> pegaPeloIDComoStream(String id) {
    var ref = this._database.collection(this._caminho).document(id);

    return ref.snapshots().map((documento) => Aluno.fromFirestore(documento));
  }

  Future<Aluno> pegaPeloID(String id) async {
    DocumentSnapshot doc;

    await this
        ._database
        .collection(this._caminho)
        .document(id)
        .get()
        .then((dado) {
      doc = dado;
    });

    return Aluno.fromFirestore(doc);
  }

}
