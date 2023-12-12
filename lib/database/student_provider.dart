import 'dart:io';

import 'package:aplicativoescolas/model/class_school.dart';
import 'package:aplicativoescolas/model/student.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

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
          "name TEXT,"
          "FOREIGN KEY (idClass) REFERENCES Class(id) ON DELETE CASCADE"
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

  Future<ClassSchool> getSchoolWithId(int id) async {
    final db = await database;
    var response = await db.query("ClassSchool", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? ClassSchool.fromMap(response.first) : null;
  }

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

  deleteAllStudent() async {
    final db = await database;
    db.delete("Student");
  }

  backupDB() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    try {
      String appDocumentsDir = (await getApplicationDocumentsDirectory()).path;
      String studentDBPath = '$appDocumentsDir/student.db';

      File ourDBFile = File(studentDBPath);

      await ourDBFile.copy("/storage/emulated/0/Download/student.db");
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
      File saveDBFile = File("/storage/emulated/0/Download/student.db");

      await saveDBFile.copy(
          "/data/user/0/com.example.aplicativoescolas/app_flutter/student.db");
    } catch (e) {
      print("========================= error ${e.toString()}");
    }
  }

}
