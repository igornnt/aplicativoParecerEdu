import 'dart:io';
import 'package:aplicativoescolas/model/evaluation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EvaluationProvider {
  EvaluationProvider._();

  static final EvaluationProvider db = EvaluationProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Evaluation.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE evaluation ("
          "id integer primary key AUTOINCREMENT,"
          "idArea integer,"
          "idClassSchool integer,"
          "idCriterio integer,"
          "criterio TEXT,"
          "idAluno integer,"
          "peso REAL"
          ")");
    });
  }

  addEvaluationToDatabase(Evaluation evaluation) async {
    final db = await database;
    var raw = await db.insert(
      "Evaluation",
      evaluation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  Future<List<Evaluation>> getAllEvaluation(int idArea) async {
    final db = await database;
    var response = await db
        .rawQuery("SELECT * FROM Evaluation WHERE idClassSchool = $idArea");
    List<Evaluation> list = response.map((c) => Evaluation.fromMap(c)).toList();
    return list;
  }

  Future<List<Evaluation>> getAllEvaluationIdClass(int idClass) async {
    final db = await database;
    var response = await db
        .rawQuery("SELECT * FROM Evaluation WHERE idClassSchool = $idClass");
    List<Evaluation> list = response.map((c) => Evaluation.fromMap(c)).toList();
    return list;
  }

  Future<List<Evaluation>> getAllEvaluationIdClassArea(
      int idClass, int area) async {
    final db = await database;
    var response = await db.rawQuery(
        "SELECT * FROM Evaluation WHERE idClassSchool=$idClass AND idArea=$area");
    List<Evaluation> list = response.map((c) => Evaluation.fromMap(c)).toList();
    return list;
  }

  Future<List<Evaluation>> getAllEvaluationIdStutedent(int idStudent) async {
    final db = await database;
    var response = await db
        .rawQuery("SELECT * FROM Evaluation WHERE idAluno = $idStudent");
    List<Evaluation> list = response.map((c) => Evaluation.fromMap(c)).toList();
    return list;
  }

  Future<int> countAtingiuCriterioId(int criterioId, double peso) async {
    final db = await database;
    return Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM Evaluation WHERE idCriterio=$criterioId AND peso=$peso'));
  }
}
