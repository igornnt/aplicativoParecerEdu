import 'dart:io';
import 'package:aplicativoescolas/model/knowledge.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class KnowledgeProvider{

  KnowledgeProvider._();

  static final KnowledgeProvider db = KnowledgeProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Knowledge.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE knowledge ("
              "id integer primary key AUTOINCREMENT,"
              "criterio TEXT,"
              "idArea integer,"
              "idTurma integer,"
              "isAvaliado integer"
              ")");
        });
  }

  addKnowledgeToDatabase(Knowledge knowledge) async {
    final db = await database;
    var raw = await db.insert(
      "Knowledge",
      knowledge.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

updateKnowledge(Knowledge knowledge) async {
  final db = await database;
  var response = await db.update("Knowledge", knowledge.toMap(),
      where: "id = ?", whereArgs: [knowledge.id]);
  return response;
}

 
 Future<List<Knowledge>> getAllCriterios(int idArea) async {
    final db = await database;
    var response = await db.rawQuery("SELECT * FROM Knowledge WHERE idArea = $idArea");
    List<Knowledge> list = response.map((c) => Knowledge.fromMap(c))
        .toList();
    return list;
  }

   Future<List<Knowledge>> getAllCriteriosClassSchool(int idArea, int classSchool) async {
    final db = await database;
    var response = await db.rawQuery("SELECT * FROM Knowledge WHERE idArea = $idArea AND idTurma=$classSchool ");
    List<Knowledge> list = response.map((c) => Knowledge.fromMap(c))
        .toList();
    return list;
  }

   Future<Knowledge> getCriterioWithID(int id) async {
    final db = await database;
    var response = await db.rawQuery("SELECT * FROM Knowledge WHERE id = $id");
    Knowledge knowledge = response.map((c) => Knowledge.fromMap(c)).elementAt(0);
    return knowledge;
  }

 deleteCriterioWithId(int id) async {   
   final db = await database;
   return db.delete("Knowledge", where: "id = ?", whereArgs: [id]);
 }

//
//  deleteAllSchool() async {
//    final db = await database;
//    db.delete("School");
//  }
//
//  Future<int> countClass(int idSchool) async {
//    var count = await ClassProvider.db.countClass(idSchool);
//    return count;
//  }


}