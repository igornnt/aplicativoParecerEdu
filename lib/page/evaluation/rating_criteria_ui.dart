import 'package:aplicativoescolas/database/knowledge_provider.dart';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/model/knowledge.dart';
import 'package:flutter/material.dart';

import 'card_evaluation.dart';

class RatingCriteriaPage extends StatefulWidget {
  
  String title;
  int codArea;
  ClassSchool classSchool;

  RatingCriteriaPage({this.title, this.classSchool, this.codArea});

  @override
  _RatingCriteriaPageState createState() =>
   _RatingCriteriaPageState(this.title, this.classSchool, this.codArea);
}

class _RatingCriteriaPageState extends State<RatingCriteriaPage> {
  String title;
  int codArea;
  ClassSchool classSchool;
  _RatingCriteriaPageState(this.title, this.classSchool, this.codArea);

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
            .getAllCriteriosClassSchool(codArea, classSchool.id)
            .timeout(Duration(seconds: 1)),
        builder:
            (BuildContext context, AsyncSnapshot<List<Knowledge>> snapshot) {
          return ListView.builder(
            itemCount: (snapshot.data != null) ? snapshot.data.length : 0,
            itemBuilder: (context, index) {
              return EvaluationCard(snapshot.data[index],this.codArea);
            },
          );
        },
      )
    );
  }
}
