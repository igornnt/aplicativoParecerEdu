import 'package:flutter/material.dart';

class CriteriosView extends StatelessWidget {

  String criterio;

  CriteriosView(this.criterio);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        splashColor: Colors.blue,
        onTap: (){
//          if(avaliar == false){
//            return null;
//          }else
//            Navigator.push(context,
//                MaterialPageRoute(
//                  builder: (context) => AvaliacaoView(titulo, criterioId, this.idEscola, this.idTurma),
//                )
//            );

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
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(child: Text(this.criterio)),
          ),
        ),
      ),
    );
  }
}
