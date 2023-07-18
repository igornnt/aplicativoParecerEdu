import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../../database/class_school_provider.dart';
import '../../database/school_provider.dart';

class BackupUi extends StatelessWidget {
  const BackupUi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Backup"),
          backgroundColor: Colors.blue,
        ),
        body: Center(
            child: Padding(
                padding: EdgeInsets.only(top: 120.0),
                child: Column(
                  children: [
                    Text(
                      "Deseja realizar backup dos seus dados?",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        ClassProvider.db.backupDB();
                        SchoolDatabaseProvider.db.backupDB();
                      },
                      child: const Text('Realizar backup '),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        SchoolDatabaseProvider.db.restoreDB();
                        ClassProvider.db.restoreDB();
                      },
                      child: const Text('Recuperar dados'),
                    ),
                  ],
                ))));
  }
}
