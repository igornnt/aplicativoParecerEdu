import 'package:aplicativoescolas/database/knowledge_provider.dart';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/model/knowledge.dart';
import 'package:aplicativoescolas/page/criteria_categories/add_knowledge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toast/toast.dart';
import 'card_criterios_page.dart';

class CriterioPage extends StatefulWidget {
  String title;
  int codArea;
  ClassSchool classSchool;

  CriterioPage({this.title, this.classSchool, this.codArea});

  @override
  _CriterioPageState createState() =>
      _CriterioPageState(this.title, this.classSchool, this.codArea);
}

class _CriterioPageState extends State<CriterioPage> {
  String title;
  int codArea;
  ClassSchool classSchool;
  _CriterioPageState(this.title, this.classSchool, this.codArea);
  TextEditingController nameEditingController = TextEditingController();

  @override
  void didUpdateWidget(CriterioPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  void initState() {
    print(this.classSchool.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ParecerEdu: " + title),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: KnowledgeProvider.db
            .getAllCriteriosClassSchool(
                this.widget.codArea, this.classSchool.id)
            .timeout(Duration(seconds: 1)),
        builder:
            (BuildContext context, AsyncSnapshot<List<Knowledge>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data.isEmpty) {
            return Center(child: Text('Nenhum item cadastrado'));
          }

          return ListView.builder(
            itemCount: (snapshot.data != null) ? snapshot.data.length : 0,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
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
                            snapshot.data[index].criterio,
                            style: (TextStyle(
                                color: Colors.black, fontSize: 17.0)),
                          ),
                          SizedBox(width: 60),
                          Row(
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      nameEditingController.text = "";
                                      nameEditingController.text =
                                          snapshot.data[index].criterio;
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
                                                        "Excluir este critério?"),
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
                                                                        'Critério excluído com sucesso')));
                                                            setState(() {
                                                              KnowledgeProvider
                                                                  .db
                                                                  .deleteCriterioWithId(
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
                                        semanticLabel:
                                            'Text to announce in accessibility modes',
                                      )),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          show(limpar: true);
        },
        tooltip: "Adicione um critério",
        child: Icon(Icons.add),
      ),
    );
  }

  void show({bool limpar, int index}) {
    if (limpar == true) {
      nameEditingController.text = "";
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Adicionar Critério"),
              content: TextField(
                decoration:
                    InputDecoration(labelText: ("Informe o nome do critério")),
                controller: nameEditingController,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      if (nameEditingController.text != "" || null) {
                        Knowledge criterio = Knowledge(
                          id: index,
                          criterio: nameEditingController.text,
                          idArea: codArea,
                          idTurma: classSchool.id,
                          isAvaliado: 0,
                        );
                        KnowledgeProvider.db.addKnowledgeToDatabase(criterio);
                        setState(() {
                          Navigator.pop(context);
                          nameEditingController.text = "";
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Critério adicionado com sucesso')));
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
              title: Text("Editar Critério"),
              content: TextField(
                decoration:
                    InputDecoration(labelText: ("Informe o nome do critério")),
                controller: nameEditingController,
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
                        Knowledge criterio = Knowledge();
                        criterio.criterio = nameEditingController.text;
                        criterio.id = index;
                        criterio.idArea = codArea;
                        criterio.idTurma = classSchool.id;

                        KnowledgeProvider.db.updateKnowledge(criterio);
                        setState(() {
                          Navigator.pop(context);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text('Critério editado com sucesso')));
                      }
                      if (limpar == true) {
                        Navigator.pop(context);
                        nameEditingController.text = "";
                      }
                    }),
              ],
            );
          });
    }
  }
}
