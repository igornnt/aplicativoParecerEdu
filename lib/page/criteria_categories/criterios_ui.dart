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
        title: Text(title),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: KnowledgeProvider.db
            .getAllCriteriosClassSchool(this.widget.codArea, this.classSchool.id)
            .timeout(Duration(seconds: 1)),
        builder:
            (BuildContext context, AsyncSnapshot<List<Knowledge>> snapshot) {
          return ListView.builder(
            itemCount: (snapshot.data != null) ? snapshot.data.length : 0,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddKnowledge(true,
                                knowledge: snapshot.data[index],
                                    ),
                              ));
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
                          setState(() {
                            KnowledgeProvider.db
                                .deleteCriterioWithId(snapshot.data[index].id);
                          });
                          Toast.show('Deletado ', context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        },
                      ),
                    )
                  ],
                  child: CriteriosView(snapshot.data[index].criterio),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddKnowledge(false,
                    idArea: codArea, idTurma: classSchool.id),
              ));
        },
        tooltip: "Adicione um critério",
        child: Icon(Icons.add),
      ),
    );
  }

  void removeCriterio(String id) {
//    this.criterioDataRepository.remove(id);
  }
//
//  void onLoadCriteriosComplete() {
////    KnowledgeProvider.db.getAllKnowledge().then((dados) => {
////      this.setState(() {
////        this.criterios = dados;
////      })
////    });
//  }
}
