import 'package:flutter/material.dart';
import 'package:aplicativoescolas/view/CadastrarTurmaView.dart';
import 'package:aplicativoescolas/view/HomeTurma.dart';

class CardEscolaView extends StatelessWidget {
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
                builder: (context) => HomeTurma(),
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
                child: Text("Escola Osvaldo Dornelles"),
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
