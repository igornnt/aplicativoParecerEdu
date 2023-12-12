import 'package:aplicativoescolas/database/class_school_provider.dart';
import 'package:aplicativoescolas/model/school.dart';
import 'package:aplicativoescolas/page/backup/backup_ui.dart';
import 'package:aplicativoescolas/page/school/school_add_ui.dart';
import 'package:aplicativoescolas/page/school/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'database/school_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          title: Text("Escolas"),
          backgroundColor: Colors.blue,
          actions: [
            /* IconButton(
              icon: const Icon(Icons.backup),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => BackupUi()));
              },
            ) */
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
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                School item = snapshot.data[index];

                return GestureDetector(
                    child: FutureBuilder(
                        initialData: 0,
                        future: SchoolDatabaseProvider.db.countClass(item.id),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Column(children: [
                            CardList(
                                school: item,
                                x: false,
                                classNumber: snapshot.data ?? 0),
                          ]);
                        }));
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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SchoolPage(false)));
          }),
    );
  }

  @override
  void onLoadScoolComplete() {
    setState(() {});
  }
}
