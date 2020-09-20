import 'package:aplicativoescolas/database/student_provider.dart';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/model/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toast/toast.dart';

class StudentsPage extends StatefulWidget {
  @override
  _AdicionarAlunoViewState createState() => _AdicionarAlunoViewState();
}

class _AdicionarAlunoViewState extends State<StudentsPage> {

  TextEditingController _alunoTextEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  ClassSchool idClass;

  @override
  Widget build(BuildContext context) {

    idClass = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Alunos"),
        elevation: 0.2,
      ),
      body: FutureBuilder(
        future: StudentProvider.db.getAllStudentsClass(idClass.id),
        builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
          return ListView.builder(
            itemCount: snapshot.data != null ? snapshot.data.length : 0,
            itemBuilder: (context, index) {
              return Container(
                child: Slidable(
                    key: ValueKey(index),
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: <Widget>[
                      Container(
                        height: 100,
                        child: IconSlideAction(
                          caption: 'Editar',
                          color: Colors.grey.shade300,
                          icon: Icons.edit,
                          closeOnTap: true,
                          onTap: () {
                            _alunoTextEditingController.text = "";
                            _alunoTextEditingController.text =
                                snapshot.data[index].name;
                            show(limpar: false, index: snapshot.data[index].id);
                          },
                        ),
                      ),
                      Container(
                        height: 100,
                        child: IconSlideAction(
                          caption: 'Deletar',
                          color: Colors.red,
                          icon: Icons.delete,
                          closeOnTap: true,
                          onTap: () {
                            Toast.show('removido com sucesso', context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                            setState(() {
                              StudentProvider.db
                                  .deleteStudentWithId(snapshot.data[index].id);
                            });
                          },
                        ),
                      )
                    ],
                    child: Container(
                      decoration: BoxDecoration(
                          border: new BorderDirectional(
                        bottom: BorderSide(
                          color: Colors.blue.shade100,
                          width: 1.5,
                        ),
                      )),
                      child: ListTile(
                        title: Text(snapshot.data[index].name),
                      ),
                    )),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          show(limpar: true);
        },
      ),
    );
  }

  void show({bool limpar, int index}) {
    if (limpar == true) {
      _alunoTextEditingController.text = "";
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Adicionar Aluno"),
              content: TextField(
                decoration:
                    InputDecoration(labelText: ("Informe o nome do aluno")),
                controller: _alunoTextEditingController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      if(_alunoTextEditingController.text != "" || null){
                                             Student student =
                          Student(name: _alunoTextEditingController.text,
                          idClass: idClass.id);
                      StudentProvider.db.addStudentToDatabase(student);
                      setState(() {
                        Navigator.pop(context);
                        _alunoTextEditingController.text = "";
                      }); 
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
              title: Text("Adicionar Aluno"),
              content: TextField(
                decoration:
                    InputDecoration(labelText: ("Informe o nome do aluno")),
                controller: _alunoTextEditingController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      if (limpar == false ) {
                        Student student = Student();
                        student.name = _alunoTextEditingController.text;
                        student.id = index;
                        student.idClass = idClass.id;
                        StudentProvider.db.updateStudents(student);
                        setState(() {
                          Navigator.pop(context);
                        });
                      }
                      if (limpar == true) {
                        Navigator.pop(context);
                        _alunoTextEditingController.text = "";
                      }
                    }),
              ],
            );
          });
    }
  }
}
