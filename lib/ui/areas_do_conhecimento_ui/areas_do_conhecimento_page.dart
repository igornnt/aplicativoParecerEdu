import 'package:flutter/material.dart';
import 'package:aplicativoescolas/ui/criterios_ui/linguagens_ui/criterios_linguagens_page.dart';

class AreasConhecimentoView extends StatelessWidget {
  bool avaliar = false;
  String escolaId;
  String turmaId;

  AreasConhecimentoView(String escolaID, turmaID, {bool avaliar}) {
    this.escolaId = escolaID;
    this.turmaId = turmaID;
    this.avaliar = avaliar;
  }

  final linguagens = "Linguagens";
  final cienciasDaNatureza = "Ciências da natureza";
  final cienciasHumanas = "Ciências humanas";
  final matematica = "Matemática";
  final ensinoReligioso = "Ensino religioso";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Áreas do conhecimento"),
      ),
      body: Column(
        children: <Widget>[
          //Linguagens
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, bottom: 12.0, right: 12.0, top: 25.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CriterioLinguagensView(
                          turmaID: turmaId,
                          escolaID: escolaId,
                          titulo: linguagens),
                    ));
              },
              splashColor: Colors.blue,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: Center(
                  child: textoPersonalizado(linguagens),
                ),
              ),
            ),
          ),
          //Ciências humanas
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {},
              splashColor: Colors.blue,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: Center(
                  child: textoPersonalizado(cienciasHumanas),
                ),
              ),
            ),
          ),
          //Ciências da natureza
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {},
              splashColor: Colors.blue,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: Center(
                  child: textoPersonalizado(cienciasDaNatureza),
                ),
              ),
            ),
          ),
          //Matemática
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {},
              splashColor: Colors.blue,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: Center(
                  child: textoPersonalizado(matematica),
                ),
              ),
            ),
          ),
          //Ensino Religioso
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {},
              splashColor: Colors.blue,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: Center(
                  child: textoPersonalizado(ensinoReligioso),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textoPersonalizado(String titulo) {
    return Text(
      titulo,
      style: TextStyle(fontSize: 17),
    );
  }
}
