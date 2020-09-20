import 'package:aplicativoescolas/database/class_school_provider.dart';
import 'package:aplicativoescolas/model/school.dart';
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
    // TODO: implement didUpdateWidget
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
        title: Text("ParecerEdu"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      body: FutureBuilder<List<School>>(
        future: SchoolDatabaseProvider.db.getAllSchool(),
        builder: (BuildContext context, AsyncSnapshot<List<School>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                School item = snapshot.data[index];
                return Slidable(
                    key: ValueKey(index),
                    actionPane: SlidableDrawerActionPane(),
                    closeOnScroll: false,
                    secondaryActions: <Widget>[
                      Container(
                        height: 100.0,
                        child: IconSlideAction(
                          caption: "Editar",
                          color: Colors.white,
                          icon: Icons.edit,
                          closeOnTap: true,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SchoolPage(
                                      true,
                                      school: item,
                                    )));
                          },
                        ),
                      ),
                      Container(
                        height: 100.0,
                        child: IconSlideAction(
                          caption: "Excluir",
                          color: Colors.red,
                          icon: Icons.delete,
                          closeOnTap: true,
                          onTap: () {
                            ClassProvider.db.deleteAllClassSchoolWithId(item.id);
                            SchoolDatabaseProvider.db.deleteSchoolWithId(item.id);
                            onLoadScoolComplete();
                          },
                        ),
                      ),
                    ],
                    child: GestureDetector(
                        child: FutureBuilder(
                            initialData: 0,
                            future:  SchoolDatabaseProvider.db.countClass(item.id),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return CardList(
                                  school: item,
                                  x: false,
                                  classNumber: snapshot.data ?? 0);
                            })));
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Colors.black,),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SchoolPage(false)));
          }),
    );
  }

  @override
  void onLoadScoolComplete() {
    setState(() {
    });
  }

}
