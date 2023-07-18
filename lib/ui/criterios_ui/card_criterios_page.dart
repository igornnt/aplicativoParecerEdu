import 'package:flutter/material.dart';
import 'package:aplicativoescolas/models/criterio_model.dart';
import 'package:aplicativoescolas/ui/avaliacao_ui/avaliacao_page.dart';

class CriteriosView extends StatelessWidget {
  String titulo = "";
  String criterioId;
  bool avaliar = false;
  String idEscola;
  String idTurma;

  CriteriosView(String titulo, String idEscola, String idTurma, this.criterioId,
      {bool avaliar}) {
    this.avaliar = avaliar;
    this.titulo = titulo;
    this.idEscola = idEscola;
    this.idTurma = idTurma;
  }

  CriteriosView.semParametros();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          if (avaliar == false) {
            return null;
          } else
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AvaliacaoView(
                      titulo, criterioId, this.idEscola, this.idTurma),
                ));
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.blue, width: 1),
          ),
          child: Center(child: Text(this.titulo)),
        ),
      ),
    );
  }
}
