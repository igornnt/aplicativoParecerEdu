import 'package:aplicativoescolas/database/class_school_provider.dart';
import 'package:aplicativoescolas/model/school.dart';
import 'package:aplicativoescolas/page/backup/backup_ui.dart';
import 'package:aplicativoescolas/page/school/school_add_ui.dart';
import 'package:aplicativoescolas/page/school/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toast/toast.dart';

import 'database/school_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController schoolEditText = new TextEditingController();

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("ParecerEdu: Escolas"),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: const Icon(Icons.backup),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => BackupUi()));
              },
            )
          ]),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<School>>(
        future: SchoolDatabaseProvider.db.getAllSchool(),
        builder: (BuildContext context, AsyncSnapshot<List<School>> snapshot) {
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data.isEmpty) {
            return Center(child: Text('Nenhum item cadastrado'));
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data != null ? snapshot.data.length : 0,
              itemBuilder: (context, index) {
                School item = snapshot.data[index];

                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () => {
                          Navigator.pushNamed(context, '/turma',
                              arguments:
                                  new School(name: item.name, id: item.id))
                        },
                        child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: new BorderDirectional(
                                  bottom: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.5,
                                  ),
                                )),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        schoolEditText.text = "";
                                        schoolEditText.text =
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
                                        semanticLabel:
                                            'Text to announce in accessibility modes',
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                      title: Text(
                                                          "Excluir esta escola"),
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
                                                            child: Text(
                                                                "Cancelar")),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();

                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content: Text(
                                                                          'Escola removida com sucesso')));

                                                              setState(() {
                                                                SchoolDatabaseProvider
                                                                    .db
                                                                    .deleteSchoolWithId(
                                                                        snapshot
                                                                            .data[index]
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
                                          semanticLabel:
                                              'Text to announce in accessibility modes',
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            show(limpar: true);
          }),
    );
  }

  void show({bool limpar, int index}) {
    if (limpar == true) {
      schoolEditText.text = "";
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Adicionar Escola"),
              content: TextField(
                decoration:
                    InputDecoration(labelText: ("Informe o nome da escola")),
                controller: schoolEditText,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      if (schoolEditText.text != "" || null) {
                        School school = School(
                          name: schoolEditText.text,
                          id: index,
                        );
                        SchoolDatabaseProvider.db.addSchoolToDatabase(school);
                        setState(() {
                          Navigator.pop(context);
                          schoolEditText.text = "";
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Escola adicionada com sucesso')));
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
              title: Text("Editar escola"),
              content: TextField(
                decoration:
                    InputDecoration(labelText: ("Informe o nome da escola")),
                controller: schoolEditText,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      if (limpar == false) {
                        School school = School();
                        school.name = schoolEditText.text;
                        school.id = index;

                        SchoolDatabaseProvider.db.updateSchool(school);
                        setState(() {
                          Navigator.pop(context);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text('Escola editada com sucesso')));
                      }
                      if (limpar == true) {
                        Navigator.pop(context);
                        schoolEditText.text = "";
                      }
                    }),
              ],
            );
          });
    }
  }

  @override
  void onLoadScoolComplete() {
    setState(() {});
  }
}
