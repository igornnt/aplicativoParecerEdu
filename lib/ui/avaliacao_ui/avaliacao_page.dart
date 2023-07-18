import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aplicativoescolas/models/aluno_model.dart';
import 'package:aplicativoescolas/models/avaliacao_model.dart';
import 'package:aplicativoescolas/models/criterio_model.dart';
import 'package:aplicativoescolas/repositories/alunos_data_repository.dart';
import 'package:aplicativoescolas/repositories/avaliacoes_data_repository.dart';
import 'package:aplicativoescolas/repositories/criterio_data_repository.dart';

class AvaliacaoView extends StatefulWidget {
  String criterioId;
  String idEscola;
  String idTurma;
  String titulo;

  AvaliacaoView(
      this.titulo, String criterioId, String idEscola, String idTurma) {
    this.criterioId = criterioId;
    this.idEscola = idEscola;
    this.idTurma = idTurma;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AvaliacaoViewState(
        this.titulo, this.criterioId, this.idEscola, idTurma);
  }
}

class _AvaliacaoViewState extends State<AvaliacaoView> {
  String idEscola;
  String idTurma;
  String titulo;
  int qtdAlunos;
  int tamanhoList;
  int qtdAvaliados = 0;
  double peso;
  String criterioId;
  List<Aluno> alunos;
  AlunosDataRepository alunoDataRepository;
  AvaliacoesDataRepository avaliacoesDataRepository;
  CriterioDataRepository criterioDataRepository;

  @override
  void initState() {
    super.initState();
    this.onLoadAvaliacaoComplete();
  }

  _AvaliacaoViewState(
      this.titulo, String criterio, this.idTurma, this.idEscola) {
    this.criterioId = criterio;
    alunoDataRepository = AlunosDataRepository(idEscola, idTurma);
    criterioDataRepository = CriterioDataRepository(idEscola, idTurma);
  }

  Color corBtnFundoAtingiu = Colors.white;
  Color corBordaAtingiu = Colors.blue;
  Color corLetraTextoAtingiu = Colors.black;

  Color corBtnFundoAtingiuParcialmente = Colors.white;
  Color corBordaAtingiuParcialmente = Colors.blue;
  Color corLetraTextoAtingiuParcialmente = Colors.black;

  Color corBtnFundoNaoAtingiu = Colors.white;
  Color corBordaNaoAtingiu = Colors.blue;
  Color corLetraTextoNaoAtingiu = Colors.black;

  void stateBtnAtingiu() {
    this.peso = 1;
    setState(() {
      if (this.corBtnFundoAtingiu == Colors.green) {
        this.corBtnFundoAtingiu = Colors.white;
        this.corBordaAtingiu = Colors.blue;
        this.corLetraTextoAtingiu = Colors.black;
      } else {
        this.corBtnFundoAtingiu = Colors.green;
        this.corBordaAtingiu = Colors.green;
        this.corLetraTextoAtingiu = Colors.white;

        this.corBtnFundoAtingiuParcialmente = Colors.white;
        this.corBordaAtingiuParcialmente = Colors.blue;
        this.corLetraTextoAtingiuParcialmente = Colors.black;

        this.corBtnFundoNaoAtingiu = Colors.white;
        this.corBordaNaoAtingiu = Colors.blue;
        this.corLetraTextoNaoAtingiu = Colors.black;
      }
    });
  }

  void stateBtnAtingiuParcialmente() {
    this.peso = 0.5;

    setState(() {
      if (this.corBtnFundoAtingiuParcialmente == Colors.green) {
        this.corBtnFundoAtingiuParcialmente = Colors.white;
        this.corBordaAtingiuParcialmente = Colors.blue;
        this.corLetraTextoAtingiuParcialmente = Colors.black;
      } else {
        this.corBtnFundoAtingiuParcialmente = Colors.green;
        this.corBordaAtingiuParcialmente = Colors.green;
        this.corLetraTextoAtingiuParcialmente = Colors.white;

        this.corBtnFundoNaoAtingiu = Colors.white;
        this.corBordaNaoAtingiu = Colors.blue;
        this.corLetraTextoNaoAtingiu = Colors.black;

        this.corBtnFundoAtingiu = Colors.white;
        this.corBordaAtingiu = Colors.blue;
        this.corLetraTextoAtingiu = Colors.black;
      }
    });
  }

  void stateBtnNaoAtingiu() {
    this.peso = 0;

    setState(() {
      if (this.corBtnFundoNaoAtingiu == Colors.green) {
        this.corBtnFundoNaoAtingiu = Colors.white;
        this.corBordaNaoAtingiu = Colors.blue;
        this.corLetraTextoNaoAtingiu = Colors.black;
      } else {
        this.corBtnFundoNaoAtingiu = Colors.green;
        this.corBordaNaoAtingiu = Colors.green;
        this.corLetraTextoNaoAtingiu = Colors.white;

        this.corBtnFundoAtingiu = Colors.white;
        this.corBordaAtingiu = Colors.blue;
        this.corLetraTextoAtingiu = Colors.black;

        this.corBtnFundoAtingiuParcialmente = Colors.white;
        this.corBordaAtingiuParcialmente = Colors.blue;
        this.corLetraTextoAtingiuParcialmente = Colors.black;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Avaliação"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              onPressed: () {
                print("Cancelar");
              },
              child: Text(
                "Cancelar",
                style: TextStyle(fontSize: 20, color: Colors.red.shade300),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (qtdAvaliados == tamanhoList - 1) {
                    Navigator.pop(context);
                  } else {
                    avaliacoesDataRepository = AvaliacoesDataRepository(
                        idEscola, idTurma, alunos[qtdAvaliados].id);
                    Avaliacao novaAvaliacao;
                    criterioDataRepository
                        .pegaPeloReferece(criterioId)
                        .then((dadoCriterio) => {
                              print(dadoCriterio.path),
                              print(dadoCriterio),
                              novaAvaliacao = Avaliacao(
                                  peso: this.peso, criterioRef: dadoCriterio),
                              avaliacoesDataRepository
                                  .adiciona(novaAvaliacao.toMap())
                                  .then((resposta) => {
//                            print(resposta)
                                      })
                            });
                    qtdAvaliados++;
                    qtdAlunos--;
                    resetaBotao();
                  }
                });
              },
              child: Row(
                children: <Widget>[
                  Text(
                    "Próximo",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  Icon(Icons.navigate_next, color: Colors.blue, size: 30),
                ],
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                "$qtdAvaliados/$qtdAlunos alunos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8, top: 30, right: 8, bottom: 8),
            child: Center(
                //this.alunos[this.qtdAvaliados].nome
                child: Text(
              (this.alunos != null) ? this.alunos[this.qtdAvaliados].nome : "",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8, top: 30, right: 8, bottom: 8),
            child: Center(
                child: Text(
              this.titulo,
              style: TextStyle(
                fontSize: 15,
              ),
            )),
          ),
          Column(
            children: <Widget>[
              btnAtingiu("Atingiu"),
              btnAtingiuParcialmente("Atingiu parcialmente"),
              btnNaoAtingiu("Não atingiu"),
            ],
          ),
        ],
      ),
    );
  }

  Widget btnAtingiu(String nome) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 0),
      child: MaterialButton(
        color: this.corBtnFundoAtingiu,
        height: 50,
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          stateBtnAtingiu();
        },
        shape: OutlineInputBorder(
          gapPadding: 30,
          borderSide: BorderSide(
            color: this.corBordaAtingiu,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(60.0)),
        ),
        child: Text(
          nome,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: this.corLetraTextoAtingiu),
        ),
      ),
    );
  }

  Widget btnAtingiuParcialmente(String nome) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 0),
      child: MaterialButton(
        color: this.corBtnFundoAtingiuParcialmente,
        height: 50,
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          stateBtnAtingiuParcialmente();
        },
        shape: OutlineInputBorder(
          gapPadding: 30,
          borderSide: BorderSide(
            color: this.corBordaAtingiuParcialmente,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(60.0)),
        ),
        child: Text(
          nome,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: this.corLetraTextoAtingiuParcialmente),
        ),
      ),
    );
  }

  Widget btnNaoAtingiu(String nome) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 0),
      child: MaterialButton(
        color: this.corBtnFundoNaoAtingiu,
        height: 50,
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          stateBtnNaoAtingiu();
        },
        shape: OutlineInputBorder(
          gapPadding: 30,
          borderSide: BorderSide(
            color: this.corBordaNaoAtingiu,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(60.0)),
        ),
        child: Text(
          nome,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: this.corLetraTextoNaoAtingiu),
        ),
      ),
    );
  }

  void onLoadAvaliacaoComplete() {
    this.alunoDataRepository.buscaTodas().then((dados) => {
          this.setState(() {
            this.alunos = dados;
            qtdAlunos = alunos.length;
            tamanhoList = alunos.length;
          })
        });
  }

  void resetaBotao() {
    this.corBtnFundoAtingiu = Colors.white;
    this.corBordaAtingiu = Colors.blue;
    this.corLetraTextoAtingiu = Colors.black;

    this.corBtnFundoAtingiuParcialmente = Colors.white;
    this.corBordaAtingiuParcialmente = Colors.blue;
    this.corLetraTextoAtingiuParcialmente = Colors.black;

    this.corBtnFundoNaoAtingiu = Colors.white;
    this.corBordaNaoAtingiu = Colors.blue;
    this.corLetraTextoNaoAtingiu = Colors.black;
  }
}
