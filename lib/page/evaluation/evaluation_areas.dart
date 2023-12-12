import 'package:aplicativoescolas/database/evaluation_provider.dart';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/page/evaluation/rating_criteria_ui.dart';
import 'package:flutter/material.dart';

class Evaluation_AreasPage extends StatelessWidget {
  ClassSchool classSchool;

  Evaluation_AreasPage(this.classSchool);

  final linguagens = "Linguagens";
  final cienciasDaNatureza = "Ciências da natureza";
  final cienciasHumanas = "Ciências humanas";
  final matematica = "Matemática";
  final ensinoReligioso = "Ensino religioso";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avaliar", style: TextStyle(fontWeight: FontWeight.w400)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Linguagens
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, bottom: 12.0, right: 12.0, top: 25.0),
              child: InkWell(
                onTap: () {
                  EvaluationProvider.db.getAllEvaluation(1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RatingCriteriaPage(
                            codArea: 1,
                            title: linguagens,
                            classSchool: classSchool)),
                  );
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RatingCriteriaPage(
                            codArea: 2,
                            title: cienciasHumanas,
                            classSchool: classSchool)),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RatingCriteriaPage(
                            codArea: 3,
                            title: cienciasDaNatureza,
                            classSchool: classSchool)),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RatingCriteriaPage(
                            codArea: 4,
                            title: matematica,
                            classSchool: classSchool)),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RatingCriteriaPage(
                            codArea: 5,
                            title: ensinoReligioso,
                            classSchool: classSchool)),
                  );
                },
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
