import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/model/school.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {

  final School school;
  final int classNumber;
  final int studentNumber;
  final ClassSchool classSchool;

  bool x;

  CardList({this.school, this.classSchool, this.x, this.classNumber, this.studentNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          if(classSchool !=  null){
            Navigator.pushNamed(context, '/menu',
            arguments: classSchool);
          }else
            Navigator.pushNamed(context, '/turma',
                arguments: new School(name: school.name, id: school.id));
        },
        child: Container(
          height: 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
            color: Colors.white,
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
                child: Text(
                    this.school == null ? this.classSchool.name : this.school
                        .name,
                style: (TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  fontSize: 17.0
                )

                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(x == false  ? "$classNumber turmas cadastradas"
                    : "$studentNumber alunos na turma",
                style: TextStyle(
                  fontWeight: FontWeight.w400
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
