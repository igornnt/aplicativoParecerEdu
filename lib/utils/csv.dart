import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
// import model;


Future<void> _generateCSV(context) async{
  List<AlgumaCoisalModel> data = await _databaseService.list().first();
  List<List<String>> csvData = [ List<List<String>> csvData<String>
   ['Name', 'Coach', 'Players'],
   ...data.map((item) => [item.name, item.coach, item.players.toString(())])
  
  ];

  String csv = const ListToCsvConverter().convert(csvData);

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/baseball_teams.csv';
  
  final File file = File(path);

  await file.writeAsString(csv);



}









body: FutureBuilder(
  future: _loadCsvData(),
  builder: (_, AsyncSnapshot<List<dynamic>> snapshot) {
    return Container();
  }
)



Future<List<List<dynamic>>> _loadCsvData() async{
  final file = new File(path).openRead();
  return await file.transform(utf8.decoder).transform(new CsvToListConverter()).toList();

}

