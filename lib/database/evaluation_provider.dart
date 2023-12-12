import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
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
    String path = join(directory.path, "evaluation.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE evaluation ("
          "id integer primary key AUTOINCREMENT,"
          "idArea integer,"
          "idClassSchool integer,"
          "idCriterio integer,"
          "criterio TEXT,"
          "idAluno integer,"
          "peso REAL,"
          "FOREIGN KEY (idClassSchool) REFERENCES Class(id),"
          "FOREIGN KEY (idCriterio) REFERENCES Knowledge(id),"
          "FOREIGN KEY (idAluno) REFERENCES Student(id)"
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

  backupDB() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    try {
      String appDocumentsDir = (await getApplicationDocumentsDirectory()).path;
      String evaluationDBPath = '$appDocumentsDir/evaluation.db';

      File ourDBFile = File(evaluationDBPath);

      await ourDBFile.copy("/storage/emulated/0/Download/evaluation.db");
    } catch (e) {
      print("========================= error ${e.toString()}");
    }
  }

  restoreDB() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    try {
      File saveDBFile = File("/storage/emulated/0/Download/evaluation.db");

      await saveDBFile.copy(
          "/data/user/0/com.example.aplicativoescolas/app_flutter/evaluation.db");
    } catch (e) {
      print("========================= error ${e.toString()}");
    }
  }
}
