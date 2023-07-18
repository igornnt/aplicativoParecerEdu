import 'dart:async';
import 'dart:io';
import 'package:aplicativoescolas/model/class_school.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
    var response =
        await db.rawQuery("SELECT * FROM Class WHERE idSchool = $idSchool");
    List<ClassSchool> list =
        response.map((c) => ClassSchool.fromMap(c)).toList();
    return list;
  }

  Future<int> countClass(int idSchool) async {
    final db = await database;
    return Sqflite.firstIntValue(await db
        .rawQuery('SELECT COUNT(*) FROM Class WHERE idSchool=$idSchool'));
  }

  updateClassSchool(ClassSchool classSchool) async {
    final db = await database;
    var response = await db.update("Class", classSchool.toMap(),
        where: "id = ?", whereArgs: [classSchool.id]);
    return response;
  }

  backupDB() async {
    // Future<List<ClassSchool>> listClassSchool = getAllClass();

//Verifica permissão ao usuário se pode mexer no storage do celular
    var status = await Permission.storage.status;
// Se não for permitido, solicita ao usuário

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    try {
      Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      String classDBPath = join(appDocumentsDir.path, 'class.db');
      String appDBPath = join(appDocumentsDir.path, 'app.db');

      // Abra a conexão com o banco de dados "class.db"
      var classDB = await getDatabaseInstance();

      // Execute a consulta para obter todas as turmas
      var turmas = await classDB.query('Class');

      // Abra a conexão com o banco de dados "app.db"
      var appDB = await openDatabase(appDBPath);

      // Copie os dados das turmas para o banco de dados "app.db"
      for (var turma in turmas) {
        // Verifique se a escola da turma já existe no banco de dados "app.db"
        var escola = await appDB
            .rawQuery('SELECT * FROM School WHERE id = ?', [turma['idSchool']]);

        if (escola.isNotEmpty) {
          // Se a escola já existe, insira apenas a turma
          await appDB.rawInsert(
              'INSERT INTO Class (id, idSchool, name) VALUES (?, ?, ?)',
              [turma['id'], turma['idSchool'], turma['name']]);
        } else {
          // Se a escola não existe, insira a escola e a turma separadamente
          await appDB.rawInsert('INSERT INTO School (id, name) VALUES (?, ?)',
              [turma['idSchool'], turma['schoolName']]);

          await appDB.rawInsert(
              'INSERT INTO Class (id, idSchool, name) VALUES (?, ?, ?)',
              [turma['id'], turma['idSchool'], turma['name']]);
        }
      }
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
      File saveDBFile = File("/storage/emulated/0/Download/class.db");

      await saveDBFile.copy(
          "/data/user/0/com.example.aplicativoescolas/app_flutter/class.db");
    } catch (e) {
      print("========================= error ${e.toString()}");
    }
  }
}
