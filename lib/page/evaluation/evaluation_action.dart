import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'package:aplicativoescolas/database/evaluation_provider.dart';
import 'package:aplicativoescolas/database/knowledge_provider.dart';
import 'package:aplicativoescolas/database/student_provider.dart';
import 'package:aplicativoescolas/model/evaluation.dart';
import 'package:aplicativoescolas/model/knowledge.dart';
import 'package:aplicativoescolas/model/student.dart';

class EvaluationActionPage extends StatefulWidget {
  Knowledge knowledge;
  int idArea;

  EvaluationActionPage(this.knowledge, this.idArea);

  @override
  State<StatefulWidget> createState() {
    return _EvaluationActionPageState(this.knowledge, this.idArea);
  }
}

class _EvaluationActionPageState extends State<EvaluationActionPage> {
  Knowledge knowledge;
  int idArea;
  double peso;

  _EvaluationActionPageState(this.knowledge, this.idArea);

  int index = 0;
  int qtdStudantes = 0;
  int avaliados = 0;
  Student student;

  @override
  void initState() {
    super.initState();
  }

  bool inicio = true;

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
      this.inicio = false;
      if (this.corBtnFundoAtingiu == Colors.green) {
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
      this.inicio = false;
      if (this.corBtnFundoAtingiuParcialmente == Colors.green) {
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
      this.inicio = false;
      if (this.corBtnFundoNaoAtingiu == Colors.green) {
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
    StudentProvider.db
        .countStudents(this.knowledge.idTurma)
        .then((onValue) => this.qtdStudantes = onValue);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Avaliação"),
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            this.inicio == true
                ? Container(
                    width: 196,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text(
                        'Confirmar',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 0,
                        primary: Colors.white,
                      ),
                    ),
                  )
                : Container(
                    width: 196,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        int score = await Future.delayed(
                            const Duration(milliseconds: 1000), () => 42);
                        return setState(() {
                          reinicio();
                          if (index < qtdStudantes - 1) {
                            EvaluationProvider.db.addEvaluationToDatabase(
                                new Evaluation(
                                    idAluno: this.student.id,
                                    idArea: this.idArea,
                                    idCriterio: this.knowledge.id,
                                    idClassSchool: this.knowledge.idTurma,
                                    criterio: this.knowledge.criterio,
                                    peso: this.peso));
                            this.index++;
                            avaliados++;
                          } else {
                            EvaluationProvider.db.addEvaluationToDatabase(
                                new Evaluation(
                                    idAluno: this.student.id,
                                    idArea: this.idArea,
                                    idCriterio: this.knowledge.id,
                                    idClassSchool: this.knowledge.idTurma,
                                    criterio: this.knowledge.criterio,
                                    peso: this.peso));
                            Knowledge novo = knowledge;
                            novo.isAvaliado = 1;
                            KnowledgeProvider.db.updateKnowledge(novo);
                            Navigator.of(context).pop();
                          }
                        });
                      },
                      child: Text(
                        'Confirmar',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 0,
                        primary: Colors.blue,
                      ),
                    ),
                  ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
            width: 10,
          ),
          FutureBuilder(
            future: StudentProvider.db.getAllStudentsClass(knowledge.idTurma),
            builder:
                (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // ou outro indicador de carregamento
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('Nenhum dado disponível');
              }

              List<Student> students = snapshot.data;

              if (index >= students.length) {
                return Text('Índice fora dos limites');
              }

              this.student = snapshot.data[index];
              return Center(
                  child: Text(
                snapshot.data[index].name,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ));
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            knowledge.criterio,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          Column(
            children: <Widget>[
              btnAtingiu("Atingiu"),
              btnAtingiuParcialmente("Atingiu parcialmente"),
              btnNaoAtingiu("Não atingiu"),
            ],
          ),
          FutureBuilder(
              initialData: 0,
              future: StudentProvider.db.countStudents(knowledge.idTurma),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                int qtd = snapshot.data;
                return Text(
                  "Alunos avaliados $avaliados de $qtd.",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                );
              })
        ],
      ),
    );
  }

  reinicio() {
    setState(() {
      this.inicio = true;

      this.corBtnFundoAtingiu = Colors.white;
      this.corBordaAtingiu = Colors.blue;
      this.corLetraTextoAtingiu = Colors.black;

      this.corBtnFundoAtingiuParcialmente = Colors.white;
      this.corBordaAtingiuParcialmente = Colors.blue;
      this.corLetraTextoAtingiuParcialmente = Colors.black;

      this.corBtnFundoNaoAtingiu = Colors.white;
      this.corBordaNaoAtingiu = Colors.blue;
      this.corLetraTextoNaoAtingiu = Colors.black;
    });
  }

  Widget btnAtingiu(String nome) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 0),
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
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
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
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 50),
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
