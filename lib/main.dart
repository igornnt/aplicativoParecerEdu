import 'package:aplicativoescolas/home_page.dart';
import 'package:aplicativoescolas/page/class/class_ui.dart';
import 'package:aplicativoescolas/page/menu/menu_ui.dart';
import 'package:aplicativoescolas/page/observation/observation_list_ui.dart';
import 'package:aplicativoescolas/page/observation/observation_ui.dart';
import 'package:aplicativoescolas/page/student/student_ui.dart';
import 'package:aplicativoescolas/page/individual_performance/student_chart.dart';
import 'package:aplicativoescolas/page/main_ui/main_page.dart';
import 'package:aplicativoescolas/page/main_ui/screen_ui.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParecerEdu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MainPage(),
        '/first-time': (context) => ScreenFirst(),
        '/home' : (context) => HomePage(),
        '/turma': (context) => ClassSchoolPage(),
        '/menu': (context) => MenuPage(),
        '/alunos': (context) => StudentsPage(),
        '/observacao': (context) => ObservationPage(),
        '/add-observacao': (context) => ObservationListPage(),
        "/alunos-chart": (context) => AlunoViewChart(),
      },
    );
  }
}