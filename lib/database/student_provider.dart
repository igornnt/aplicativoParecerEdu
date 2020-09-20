import 'dart:io';

import 'package:aplicativoescolas/model/school.dart';
import 'package:aplicativoescolas/model/student.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StudentProvider {
  StudentProvider._();

  static final StudentProvider db = StudentProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "student.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Student ("
          "id integer primary key AUTOINCREMENT,"
          "idClass integer,"
          "name TEXT"
          ")");
    });
  }

  addStudentToDatabase(Student student) async {
    final db = await database;
    var raw = await db.insert(
      "Student",
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateStudents(Student student) async {
    final db = await database;
    var response = await db.update("Student", student.toMap(),
        where: "id = ?", whereArgs: [student.id]);
    return response;
  }

//  Future<School> getSchoolWithId(int id) async {
//    final db = await database;
//    var response = await db.query("School", where: "id = ?", whereArgs: [id]);
//    return response.isNotEmpty ? School.fromMap(response.first) : null;
//  }

  Future<List<Student>> getAllStudentsClass(int id) async {
    final db = await database;
    var response = await db.query("Student", where: "idClass = ?", whereArgs: [id]);
    List<Student> list = response.map((c) => Student.fromMap(c)).toList();
    return list;
  }


  deleteStudentWithId(int id) async {
    final db = await database;
    return db.delete("Student", where: "id = ?", whereArgs: [id]);
  }

  Future<int> countStudents(int idClass) async {
    final db = await database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Student WHERE idClass=$idClass'));
  }

}
