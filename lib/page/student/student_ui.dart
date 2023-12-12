import 'package:aplicativoescolas/database/school_provider.dart';
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
  TextEditingController _alunoTextEditingController =
      new TextEditingController();

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
        title: Text("Alunos", style: TextStyle(fontWeight: FontWeight.w400)),
        elevation: 0.2,
      ),
      body: FutureBuilder(
        future: StudentProvider.db.getAllStudentsClass(idClass.id),
        builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Mostrar um indicador de carregamento enquanto espera.
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data.isEmpty) {
            return Center(child: Text('Nenhum item cadastrado'));
          }

          return ListView.builder(
            itemCount: snapshot.data != null ? snapshot.data.length : 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          snapshot.data[index].name,
                          style:
                              (TextStyle(color: Colors.black, fontSize: 17.0)),
                        ),
                        SizedBox(width: 60),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _alunoTextEditingController.text = "";
                                _alunoTextEditingController.text =
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
                                              title:
                                                  Text("Excluir este aluno(a)"),
                                              content: Text(
                                                  "Você tem certeza disso?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    style: TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.blue),
                                                    child: Text("Cancelar")),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              backgroundColor:
                                                                  Colors.red,
                                                              content: Text(
                                                                  'Aluno(a) excluído(a) com sucesso')));
                                                      setState(() {
                                                        print(snapshot
                                                            .data[index].id);

                                                        StudentProvider.db
                                                            .deleteStudentWithId(
                                                                snapshot
                                                                    .data[index]
                                                                    .id);
                                                      });
                                                    },
                                                    style: TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.red),
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
                TextButton(
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      if (_alunoTextEditingController.text != "" || null) {
                        Student student = Student(
                            name: _alunoTextEditingController.text,
                            idClass: idClass.id);
                        StudentProvider.db.addStudentToDatabase(student);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content:
                                Text('Aluno(a) adicionado(a) com sucesso')));
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
              title: Text("Editar Aluno(a)"),
              content: TextField(
                decoration:
                    InputDecoration(labelText: ("Edite o nome do aluno(a)")),
                controller: _alunoTextEditingController,
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
                        Student student = Student();
                        student.name = _alunoTextEditingController.text;
                        student.id = index;
                        student.idClass = idClass.id;
                        StudentProvider.db.updateStudents(student);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text('Aluno(a) editado(a) com sucesso')));

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
