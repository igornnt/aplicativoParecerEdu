import 'package:aplicativoescolas/database/observation_provider.dart';
import 'package:aplicativoescolas/database/student_provider.dart';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/model/student.dart';
import 'package:flutter/material.dart';

class ObservationPage extends StatefulWidget {
  @override
  _ObservationPageState createState() => _ObservationPageState();
}

class _ObservationPageState extends State<ObservationPage> {
  ClassSchool classSchool;

  @override
  Widget build(BuildContext context) {
    classSchool = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Observações", style: TextStyle(fontWeight: FontWeight.w400)),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: StudentProvider.db.getAllStudentsClass(classSchool.id),
        builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
          if (snapshot.data.length <= 0) {
            return Center(child: Text('Nenhum item cadastrado'));
          }

          return ListView.builder(
            itemCount: snapshot.data != null ? snapshot.data.length : 0,
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(
                      border: new BorderDirectional(
                    bottom: BorderSide(
                      color: Colors.blue.shade100,
                      width: 1.5,
                    ),
                  )),
                  child: FutureBuilder(
                    initialData: 0,
                    future: ObservationProvider.db
                        .countObservation(snapshot.data[index].id),
                    builder:
                        (BuildContext context, AsyncSnapshot<int> newSnapshot) {
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/add-observacao',
                              arguments: snapshot.data[index]);
                        },
                        dense: false,
                        enabled: true,
                        title: Text(snapshot.data[index].name),
                        subtitle: Text("Observações registradas: " +
                            newSnapshot.data.toString()),
                        trailing: Icon(Icons.navigate_next),
                      );
                    },
                  ));
            },
          );
        },
      ),
    );
  }
}
