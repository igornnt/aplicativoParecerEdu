import 'package:aplicativoescolas/database/class_school_provider.dart';
import 'package:aplicativoescolas/database/student_provider.dart';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/model/school.dart';
import 'package:aplicativoescolas/page/school/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'class_add_ui.dart';

class ClassSchoolPage extends StatefulWidget {

  @override
  _ClassSchoolPageState createState() => _ClassSchoolPageState();

}

class _ClassSchoolPageState extends State<ClassSchoolPage> {
  
  @override
  Widget build(BuildContext context) {

    final School school = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("ParecerEdu"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<ClassSchool>>(
        future: ClassProvider.db.getAllClass(school.id),
        builder: (BuildContext context, AsyncSnapshot<List<ClassSchool>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                ClassSchool item = snapshot.data[index];
                return Slidable(
                    actionExtentRatio: 0.3,
                    key: ValueKey(index),
                    actionPane: SlidableDrawerActionPane(),
                    closeOnScroll: false,
                    secondaryActions: <Widget>[
                      Container(
                        height: 100.0,
                        child: IconSlideAction(
                          caption: "Editar",
                          color: Colors.blue,
                          icon: Icons.edit,
                          closeOnTap: true,
                          onTap: () {
                            Navigator.of(context).push( MaterialPageRoute(
                                builder: (context) => ClassPage(
                                  edit: true,
                                  classSchool: item,
                                )));
                          },
                        ),
                      ),
                      Container(
                        height: 100.0,
                        child: IconSlideAction(
                          caption: "Excluir",
                          color: Colors.red,
                          icon: Icons.delete,
                          closeOnTap: true,
                          onTap: () {
                            ClassProvider.db.deleteClassWithId(item.id);
                            onLoadScoolComplete();
                          },
                        ),
                      ),
                    ],
                    child: GestureDetector(
                        child: FutureBuilder(
                            initialData: 0,
                            future:  StudentProvider.db.countStudents(item.id),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              return CardList(
                                  classSchool: item,
                                  x: true,
                                  studentNumber: snapshot.data ?? 0);
                            }
                            )
                    )
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ClassPage(edit: false, idSchool: school.id,)));
          }),
    );
  }

  void onLoadScoolComplete() {
    setState(() {});
  }
}
