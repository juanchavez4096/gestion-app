import 'package:flutter/material.dart';
import 'package:gestion_costos_operativos_app/login_page.dart';
import 'package:gestion_costos_operativos_app/my_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var _title = 'Gestión Costos Operativos';
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: _title,),
    );
  }
}




