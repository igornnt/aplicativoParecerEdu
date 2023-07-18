import 'package:aplicativoescolas/database/student_provider.dart';
import 'package:aplicativoescolas/model/knowledge.dart';
import 'package:aplicativoescolas/page/evaluation/evaluation_action.dart';
import 'package:flutter/material.dart';

class EvaluationCard extends StatefulWidget {
  Knowledge criterio;
  int idArea;

  EvaluationCard(this.criterio, this.idArea);

  @override
  _EvaluationCardState createState() => _EvaluationCardState();
}

class _EvaluationCardState extends State<EvaluationCard> {
  bool isAvaliado = false;

  @override
  void initState() {
    super.initState();

    // Verifica se o critério está avaliado
    setState(() {
      isAvaliado = widget.criterio.isAvaliado == 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          if (widget.criterio.isAvaliado == 0) {
            StudentProvider.db
                .countStudents(widget.criterio.idTurma)
                .then((onValue) {
              if (onValue == 0 || onValue == null) {
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Ops"),
                      content: new Text(
                          "Você precisa ter pelo menos 1 aluno cadastrado para poder avaliar este item."),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new TextButton(
                          child: new Text("Entendi"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EvaluationActionPage(
                          this.widget.criterio, this.widget.idArea),
                    ));
              }
            });
          } else {
            return null;
          }
        },
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: Column(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(child: Text(this.widget.criterio.criterio)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      alignment: Alignment.bottomLeft,
                      child: widget.criterio.isAvaliado == 0
                          ? criterioNaoAvaliado()
                          : criterioAvaliado()),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, bottom: 8),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.blue,
                      size: 25,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget criterioAvaliado() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Transform(
        transform: new Matrix4.identity()..scale(0.8),
        child: Chip(
          elevation: 10,
          backgroundColor: Colors.green,
          avatar: Icon(Icons.done, color: Colors.white),
          label: Text(
            'Critério avaliado',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget criterioNaoAvaliado() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Transform(
        transform: new Matrix4.identity()..scale(0.8),
        child: Chip(
          elevation: 0,
          backgroundColor: Colors.grey[50],
          avatar: Icon(Icons.cancel, color: Colors.black),
          label: Text(
            'Critério não avaliado',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
