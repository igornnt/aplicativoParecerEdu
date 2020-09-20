import 'dart:io';
import 'package:aplicativoescolas/model/observation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ObservationProvider{

  ObservationProvider._();

  static final ObservationProvider db = ObservationProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "observation.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Observation ("
              "id integer primary key AUTOINCREMENT,"
              "observation TEXT,"
              "idStudent integer,"
              "ano integer,"
              "mes integer,"
              "dia integer"
              ")");
        });
  }

  addObservationToDatabase(Observation observation) async {
    final db = await database;
    var raw = await db.insert(
      "Observation",
      observation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateObservation(Observation observation) async {
    final db = await database;
    var response = await db.update("Observation", observation.toMap(),
        where: "id = ?", whereArgs: [observation.id]);
    return response;
  }

  Future<Observation> getObservationWithId(int id) async {
    final db = await database;
    var response = await db.query("Observation", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Observation.fromMap(response.first) : null;
  }

  Future<List<Observation>> getAllObservation() async {
    final db = await database;
    var response = await db.query("Observation");
    List<Observation> list = response.map((c) => Observation.fromMap(c)).toList();
    return list;
  }

  deleteObservationWithId(int id) async {
    final db = await database;
    return db.delete("Observation", where: "id = ?", whereArgs: [id]);
  }

  deleteAllObservation() async {
    final db = await database;
    db.delete("Observation");
  }

  Future<List<Observation>> getAllObservationWithId(int idStudent) async {
    final db = await database;
    var response = await db.rawQuery("SELECT * FROM Observation WHERE idStudent = $idStudent");
    List<Observation> list = response.map((c) => Observation.fromMap(c))
        .toList();
    return list;
  }


  Future<int> countObservation(int idStudent) async {
    final db = await database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Observation WHERE idStudent=$idStudent'));
  }

}