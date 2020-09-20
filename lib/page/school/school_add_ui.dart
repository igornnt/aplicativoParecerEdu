import 'package:aplicativoescolas/database/school_provider.dart';
import 'package:aplicativoescolas/model/school.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SchoolPage extends StatefulWidget {
  final bool edit;
  final School school;

  SchoolPage(this.edit, {this.school}) : assert(edit == true || school == null);

  @override
  _EditPersonState createState() => _EditPersonState();
}

class _EditPersonState extends State<SchoolPage> {
  TextEditingController nameEditingController = TextEditingController();

  bool bott = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit == true) {
      nameEditingController.text = widget.school.name;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit ? "Editar Escola" : "Adicionar uma Escola"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image(
                      image: AssetImage('resource/escola.png'),
                      height: 150,
                      width: 150,
                    ),
                  ),
                  textFormField(
                      nameEditingController,
                      "Escola",
                      "Adicione um nome para a escola",
                      Icons.school,
                      widget.edit ? widget.school.name : "s"),
                  SizedBox(
                    height: 15.0,
                    width: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              SchoolDatabaseProvider.db.updateSchool(new School(
                                  name: nameEditingController.text,
                                  id: widget.school.id));
                              Navigator.pop(context);
                            } else {
                              await SchoolDatabaseProvider.db.addSchoolToDatabase(
                                  new School(name: nameEditingController.text));
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    ),
                  ),
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
            return 'Você deve preencher com algum texto';
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
