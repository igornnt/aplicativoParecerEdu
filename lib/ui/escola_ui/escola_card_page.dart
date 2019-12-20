import 'package:flutter/material.dart';
import 'package:parecer_app/ui/turmas_ui/cadastro_turma_page.dart';
import 'package:parecer_app/ui/turmas_ui/home_turma_page.dart';

class CardEscolaView extends StatelessWidget {

  String titulo = "";
  String idEscola = "";
  CardEscolaView(this.titulo,this.idEscola);



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
        child: InkWell(
          splashColor: Colors.blue,
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => HomeTurma(escolaId: idEscola),
                )
            );
          },

          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: Colors.blue,
                width: 1
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(titulo),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("0 turmas cadastradas"),
                )
              ],
            ),
          ),
        ),
    );
  }
}
