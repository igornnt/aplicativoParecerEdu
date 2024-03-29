import 'package:flutter/material.dart';
import 'package:aplicativoescolas/ui/MenuPrincipal.dart';

class TurmaView extends StatelessWidget {
  String turmaId;
  String escolaId;

  String titulo = "";
  TurmaView(String titulo, String turmaId, String escolaId) {
    this.titulo = titulo;
    this.escolaId = turmaId;
    this.turmaId = escolaId;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuPrincipal(escolaId, turmaId),
              ));
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.blue, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(this.titulo),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("0 alunos cadastrados"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
