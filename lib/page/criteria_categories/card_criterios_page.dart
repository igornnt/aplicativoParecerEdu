import 'package:aplicativoescolas/page/criteria_categories/add_knowledge.dart';
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
        onTap: () {
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
            border: Border.all(color: Colors.blue, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(this.criterio),
                  SizedBox(width: 30),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 24.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          )),
                      ElevatedButton(
                          onPressed: () {
                             
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 24.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          )),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
