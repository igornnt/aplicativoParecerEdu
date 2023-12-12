import 'package:aplicativoescolas/database/class_school_provider.dart';
import 'package:aplicativoescolas/database/student_provider.dart';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/model/school.dart';
import 'package:aplicativoescolas/page/school/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toast/toast.dart';

import '../school/card_listClass.dart';
import 'class_add_ui.dart';

class ClassSchoolPage extends StatefulWidget {
  @override
  _ClassSchoolPageState createState() => _ClassSchoolPageState();
}

class _ClassSchoolPageState extends State<ClassSchoolPage> {
  TextEditingController classEditText = new TextEditingController();

  School school;

  @override
  Widget build(BuildContext context) {
    school = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("ParecerEdu: Turmas"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<ClassSchool>>(
        future: ClassProvider.db.getAllClass(school.id),
        builder:
            // ignore: missing_return
            (BuildContext context, AsyncSnapshot<List<ClassSchool>> snapshot) {
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data.isEmpty) {
            return Center(child: Text('Nenhum item cadastrado'));
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              ClassSchool item = snapshot.data[index];

              //COMEÇA AQUI
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () => {
                        Navigator.pushNamed(context, '/menu', arguments: item)
                      },
                      child: Container(
                        child: Container(
                          decoration: BoxDecoration(
                              border: new BorderDirectional(
                            bottom: BorderSide(
                              color: Colors.transparent,
                              width: 1.5,
                            ),
                          )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[index].name,
                                    style: (TextStyle(
                                        color: Colors.black, fontSize: 17.0)),
                                  ),
                                ],
                              ),
                              SizedBox(width: 60),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      classEditText.text = "";
                                      classEditText.text =
                                          snapshot.data[index].name;
                                      show(
                                          limpar: false,
                                          index: snapshot.data[index].id);
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
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                    title: Text(
                                                        "Excluir esta turma"),
                                                    content: Text(
                                                        "Você tem certeza disso?"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                                  foregroundColor:
                                                                      Colors
                                                                          .blue),
                                                          child:
                                                              Text("Cancelar")),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    content: Text(
                                                                        'Turma excluída com sucesso')));
                                                            setState(() {
                                                              ClassProvider.db
                                                                  .deleteClassWithId(
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .id);
                                                            });
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                                  foregroundColor:
                                                                      Colors
                                                                          .red),
                                                          child: Text("Sim")),
                                                    ]));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent,
                                        elevation: 0.0,
                                        shadowColor: Colors.transparent,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 2),
                                      ),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red[600],
                                        size: 24.0,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            show(limpar: true);
          }),
    );
  }

  void show({limpar, int index}) {
    if (limpar == true) {
      classEditText.text = "";
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Adicionar Turma"),
              content: TextField(
                decoration:
                    InputDecoration(labelText: ("Informe o nome da turma")),
                controller: classEditText,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      if (classEditText.text != "" || null) {
                        ClassSchool classSchool = ClassSchool(
                          name: classEditText.text,
                          idSchool: school.id,
                        );

                        ClassProvider.db.addClassToDatabase(classSchool);
                        setState(() {
                          Navigator.pop(context);
                          classEditText.text = "";
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Turma adicionada com sucesso')));
                      }
                    })
              ],
            );
          });
    }
    if (limpar == false) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Editar turma"),
              content: TextField(
                decoration:
                    InputDecoration(labelText: ("Informe o nome da turma")),
                controller: classEditText,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                    child: Text("Salvar"),
                    onPressed: () async {
                      if (limpar == false) {
                        ClassSchool classSchool = ClassSchool();
                        classSchool.name = classEditText.text;
                        classSchool.id = index;
                        classSchool.idSchool = school.id;

                        ClassProvider.db.updateClassSchool(classSchool);
                        setState(() {
                          Navigator.pop(context);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text('Turma editada com sucesso')));
                      }
                      if (limpar == true) {
                        Navigator.pop(context);
                        classEditText.text = "";
                      }
                    }),
              ],
            );
          });
    }
  }

  void onLoadScoolComplete() {
    setState(() {});
  }
}
