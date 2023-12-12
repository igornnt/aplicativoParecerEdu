import 'package:flutter/material.dart';

import '../../database/observation_provider.dart';
import '../../database/evaluation_provider.dart';
import '../../database/knowledge_provider.dart';
import '../../database/student_provider.dart';
import '../../database/class_school_provider.dart';
import '../../database/school_provider.dart';

class BackupUi extends StatelessWidget {
  const BackupUi({Key key}) : super(key: key);

  void showBackupSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Backup Realizado"),
          content: Text("O backup dos dados foi realizado com sucesso."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Fechar"),
            ),
          ],
        );
      },
    );
  }

  void showRestoreSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Dados Restaurados"),
          content: Text("Atenção!! Feche e reinicie o seu PadecerEdu app."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Fechar"),
            ),
          ],
        );
      },
    );
  }

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
                        ObservationProvider.db.backupDB();
                        EvaluationProvider.db.backupDB();
                        KnowledgeProvider.db.backupDB();
                        StudentProvider.db.backupDB();
                        ClassProvider.db.backupDB();
                        SchoolDatabaseProvider.db.backupDB();
                        showBackupSuccessDialog(context);
                      },
                      child: const Text('Realizar backup '),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        ClassProvider.db.restoreDB();
                        SchoolDatabaseProvider.db.restoreDB();
                        StudentProvider.db.restoreDB();
                        KnowledgeProvider.db.restoreDB();
                        EvaluationProvider.db.restoreDB();
                        ObservationProvider.db.restoreDB();
                        showRestoreSuccessDialog(context);
                      },
                      child: const Text('Recuperar dados'),
                    ),
                  ],
                ))));
  }
}
