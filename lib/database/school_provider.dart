import 'dart:async';
import 'dart:io';
import 'package:aplicativoescolas/database/class_school_provider.dart';
import 'package:aplicativoescolas/model/school.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SchoolDatabaseProvider {

  SchoolDatabaseProvider._();

  static final SchoolDatabaseProvider db = SchoolDatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "school.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE School ("
              "id integer primary key AUTOINCREMENT,"
              "name TEXT"
              ")");
        });
  }

  addSchoolToDatabase(School school) async {
    final db = await database;
    var raw = await db.insert(
      "School",
      school.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateSchool(School school) async {
    final db = await database;
    var response = await db.update("School", school.toMap(),
        where: "id = ?", whereArgs: [school.id]);
    return response;
  }

  Future<School> getSchoolWithId(int id) async {
    final db = await database;
    var response = await db.query("School", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? School.fromMap(response.first) : null;
  }

  Future<List<School>> getAllSchool() async {
    final db = await database;
    var response = await db.query("School");
    List<School> list = response.map((c) => School.fromMap(c)).toList();
    return list;
  }

  deleteSchoolWithId(int id) async {
    final db = await database;
    return db.delete("School", where: "id = ?", whereArgs: [id]);
  }

  deleteAllSchool() async {
    final db = await database;
    db.delete("School");
  }

  Future<int> countClass(int idSchool) async {
    var count = await ClassProvider.db.countClass(idSchool);
    return count;
  }


}