import 'package:aplicativoescolas/database/class_school_provider.dart';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClassPage extends StatefulWidget {

  final bool edit;
  final ClassSchool classSchool;
  final int idSchool;

  ClassPage({this.edit, this.classSchool, this.idSchool})
      : assert(edit == true || classSchool == null);


  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {

  TextEditingController nameEditingController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit == true) {
      nameEditingController.text = widget.classSchool.name;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.edit?"Edite a turma" : "Adicionar uma turma"),),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image(
                      image: AssetImage('resource/livro.png'),
                      height: 150,
                      width: 150,
                    ),
                  ),
                  textFormField(nameEditingController,  "Turma",
                      "Adicione um nome para a turma",
                      Icons.school, widget.edit ? widget.classSchool.name : "s"),
                  SizedBox(
                    height: 15.0,
                    width: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "         Salvar         ",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState.validate()) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processando os dados')));
                          } else if (widget.edit == true) {
                            ClassProvider.db.updateClassSchool(new ClassSchool(
                                name: nameEditingController.text,
                                id: widget.classSchool.id,
                                idSchool: widget.classSchool.idSchool
                            ));
                            setState(() {
                            });
                            Navigator.pop(context);
                          } else {
                            await ClassProvider.db.addClassToDatabase(new ClassSchool(
                                name: nameEditingController.text,
                              idSchool: widget.idSchool
                            ));
                            setState(() {
                              print(widget.idSchool.toString() +"osko");
                            });
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  textFormField(TextEditingController t, String label, String hint,
      IconData iconData, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        },
        controller: t,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            prefixIcon: Icon(iconData),
            hintText: hint,
            labelText: label,
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

}
