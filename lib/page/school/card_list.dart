import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/model/school.dart';
import 'package:aplicativoescolas/page/class/class_ui.dart';
import 'package:aplicativoescolas/page/school/school_add_ui.dart';
import 'package:flutter/material.dart';

import '../../database/class_school_provider.dart';
import '../../database/school_provider.dart';

class CardList extends StatelessWidget {
  final School school;
  final int classNumber;
  final int studentNumber;
  final ClassSchool classSchool;

  bool x;

  CardList(
      {this.school,
      this.classSchool,
      this.x,
      this.classNumber,
      this.studentNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          if (classSchool != null) {
            Navigator.pushNamed(context, '/menu', arguments: classSchool);
          } else
            Navigator.pushNamed(context, '/turma',
                arguments: new School(name: school.name, id: school.id));
        },
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.blue, width: 1),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 25),
                      child: Text(
                        this.school == null
                            ? this.classSchool.name
                            : this.school.name,
                        style: (TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 17.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 25),
                      child: Text(
                        x == false
                            ? "$classNumber turmas cadastradas"
                            : "$studentNumber alunos na turma",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SchoolPage(
                                  true,
                                  school: school,
                                )));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                        padding:
                            EdgeInsets.symmetric(vertical: 13, horizontal: 5),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 24.0,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: Text("Excluir esta escola"),
                                      content: Text("Você tem certeza disso?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.blue),
                                            child: Text("Cancelar")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();

                                              if (x == false) {
                                                SchoolDatabaseProvider.db
                                                    .deleteSchoolWithId(
                                                        school.id);
                                              } else {
                                                ClassProvider.db
                                                    .deleteClassWithId(
                                                        classSchool.id);
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.red),
                                            child: Text("Sim")),
                                      ]));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          padding:
                              EdgeInsets.symmetric(vertical: 13, horizontal: 5),
                        ),
                        child: Icon(
                          Icons.delete,
                          color: Colors.red[600],
                          size: 24.0,
                        )),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
