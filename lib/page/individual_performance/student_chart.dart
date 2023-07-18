import 'package:aplicativoescolas/database/student_provider.dart';
import 'package:aplicativoescolas/model/student.dart';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/page/individual_performance/student_chart_ui.dart';
import 'package:flutter/material.dart';

import 'general_indicador.dart';

class AlunoViewChart extends StatefulWidget {
  @override
  _AdicionarAlunoViewState createState() => _AdicionarAlunoViewState();
}

class _AdicionarAlunoViewState extends State<AlunoViewChart> {
  List<Student> alunos;

  ClassSchool classSchool;

  bool _isLoading;

  @override
  void initState() {
    super.initState();
    this._isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    classSchool = ModalRoute.of(context).settings.arguments;
    this.onLoadAlunosComplete(classSchool.id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Desempenho individual",
            style: TextStyle(fontWeight: FontWeight.w400)),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: (this.alunos != null) ? this.alunos.length : 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentChartPage(
                              alunos[index], this.classSchool.name)),
                    );
                  },
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(alunos[index].name),
                        subtitle: Text("Selecione para obter informações"),
                      ),
                      Divider(
                        color: Colors.blue,
                      ),
                    ],
                  )),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void onLoadAlunosComplete(int id) {
    StudentProvider.db.getAllStudentsClass(id).then((dados) => {
          this.setState(() {
            this.alunos = dados;
          })
        });
  }
}
