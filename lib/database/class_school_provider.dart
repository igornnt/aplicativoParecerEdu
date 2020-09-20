import 'dart:async';
import 'dart:io';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ClassProvider {

  ClassProvider._();

  static final ClassProvider db = ClassProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "class.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Class ("
              "id integer primary key AUTOINCREMENT,"
              "name TEXT,"
              "idSchool integer"
              ")");
        });
  }

  addClassToDatabase(ClassSchool classSchool) async {
    final db = await database;
    var raw = await db.insert(
      "Class",
      classSchool.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  deleteAllClassSchoolWithId(int id) async {
    final db = await database;
    db.delete("Class WHERE idSchool=$id");
  }

  deleteClassWithId(int id) async {
    final db = await database;
    return db.delete("Class", where: "id = ?", whereArgs: [id]);
  }


  Future<List<ClassSchool>> getAllClass(int idSchool) async {
    final db = await database;
    var response = await db.rawQuery("SELECT * FROM Class WHERE idSchool = $idSchool");
    List<ClassSchool> list = response.map((c) => ClassSchool.fromMap(c))
        .toList();
    return list;
  }

   Future<int> countClass(int idSchool) async {
    final db = await database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Class WHERE idSchool=$idSchool'));
  }

  updateClassSchool(ClassSchool classSchool) async {
    final db = await database;
    var response = await db.update("Class", classSchool.toMap(),
        where: "id = ?", whereArgs: [classSchool.id]);
    return response;
  }


}