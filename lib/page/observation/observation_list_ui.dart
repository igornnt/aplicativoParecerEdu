import 'package:aplicativoescolas/database/observation_provider.dart';
import 'package:aplicativoescolas/model/observation.dart';
import 'package:aplicativoescolas/model/observation.dart';
import 'package:aplicativoescolas/model/student.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toast/toast.dart';
import 'custom_show_dialog.dart';

class ObservationListPage extends StatefulWidget {
  @override
  _ObservationListPageState createState() => _ObservationListPageState();
}

class _ObservationListPageState extends State<ObservationListPage> {
  TextEditingController obsTex = TextEditingController();

  var now = new DateTime.now();

  Student student;

  @override
  Widget build(BuildContext context) {
    student = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        student.name,
        style: TextStyle(color: Colors.white),
      )),
      body: DefaultTextStyle.merge(
        style: const TextStyle(
          fontSize: 16.0,
          //fontFamily: 'monospace',
        ),
        child: FutureBuilder(
          future: ObservationProvider.db.getAllObservationWithId(student.id),
          builder: (BuildContext context,
              AsyncSnapshot<List<Observation>> snapshot) {
            if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data.isEmpty) {
              return Center(child: Text('Nenhum item cadastrado'));
            }
            return ListView.builder(
              itemCount: snapshot.data != null ? snapshot.data.length : 0,
              itemBuilder: (context, index) {
                return Container(
                  child: Container(
                    decoration: BoxDecoration(border: new BorderDirectional()),
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
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data[index].observation,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              obsTex.text = "";
                                              obsTex.text = snapshot
                                                  .data[index].observation;
                                              show(
                                                  limpar: false,
                                                  index:
                                                      snapshot.data[index].id);
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
                                                    builder: (context) =>
                                                        AlertDialog(
                                                            title: Text(
                                                                "Excluir este critério?"),
                                                            content: Text(
                                                                "Você tem certeza disso?"),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  style: TextButton.styleFrom(
                                                                      foregroundColor:
                                                                          Colors
                                                                              .blue),
                                                                  child: Text(
                                                                      "Cancelar")),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .red,
                                                                        content:
                                                                            Text('Observação excluída com sucesso')));
                                                                    setState(
                                                                        () {
                                                                      ObservationProvider
                                                                          .db
                                                                          .deleteObservationWithId(snapshot
                                                                              .data[index]
                                                                              .id);
                                                                    });
                                                                  },
                                                                  style: TextButton.styleFrom(
                                                                      foregroundColor:
                                                                          Colors
                                                                              .red),
                                                                  child: Text(
                                                                      "Sim")),
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
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            show(limpar: true);
          }),
    );
  }

  void show({bool limpar, int index}) {
    if (limpar == true) {
      obsTex.text = "";
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Adicionar Observação"),
              content: TextField(
                controller: obsTex,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      if (obsTex.text != "" || null) {
                        Observation obj = Observation(
                            observation: obsTex.text,
                            idStudent: student.id,
                            ano: now.year,
                            mes: now.month,
                            dia: now.day);

                        setState(() {
                          ObservationProvider.db.addObservationToDatabase(obj);
                          obsTex.text = "";
                          Navigator.pop(context);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content:
                                Text('Observação adicionada com sucesso')));
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
              title: Text("Editar Observação"),
              content: TextField(
                controller: obsTex,
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
                        Observation observation = Observation();
                        observation.id = index;
                        observation.idStudent = student.id;
                        observation.observation = obsTex.text;
                        observation.ano = now.year;
                        observation.mes = now.month;
                        observation.dia = now.day;

                        ObservationProvider.db.updateObservation(observation);
                        setState(() {
                          Navigator.pop(context);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text('Observação editada com sucesso')));
                      }
                      if (limpar == true) {
                        Navigator.pop(context);
                        obsTex.text = "";
                      }
                    }),
              ],
            );
          });
    }
  }
}
