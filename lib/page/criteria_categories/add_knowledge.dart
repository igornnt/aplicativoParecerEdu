import 'package:aplicativoescolas/database/knowledge_provider.dart';
import 'package:aplicativoescolas/model/knowledge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddKnowledge extends StatefulWidget {
  final Knowledge knowledge;
  final bool edit;
  final int idArea;
  final int idTurma;

  AddKnowledge(this.edit, {this.idTurma,this.idArea, this.knowledge}) : assert(edit == true || knowledge == null);

  @override
  _EditAddKnowledgeState createState() => _EditAddKnowledgeState();
}

class _EditAddKnowledgeState extends State<AddKnowledge> {

  TextEditingController nameEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit == true) {
      nameEditingController.text = widget.knowledge.criterio;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit ? "Editar Critério" : "Adicionar critério"),
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
                      image: AssetImage('resource/iconcriterio.png'),
                      height: 150,
                      width: 150,
                    ),
                  ),
                  textFormField(
                      nameEditingController,
                      "Critério",
                      "Escrevar um critério de aprendizagem",
                      Icons.insert_chart,
                      widget.edit ? widget.knowledge.criterio : "s"),
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
                             setState(() {
                               KnowledgeProvider.db.updateKnowledge(new Knowledge(
                               id: widget.knowledge.id,
                               criterio: nameEditingController.text,
                               idArea: widget.knowledge.idArea,
                               idTurma: widget.knowledge.idTurma,
                               isAvaliado: widget.knowledge.isAvaliado
                             ));
                               Navigator.pop(context);
                             });
                            
                            } else {
                              await KnowledgeProvider.db.addKnowledgeToDatabase(
                                  new Knowledge(
                                      criterio: nameEditingController.text,
                                  idArea: widget.idArea,
                                    idTurma: widget.idTurma,
                                    isAvaliado: 0
                                  ));
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
