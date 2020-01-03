import 'package:flutter/material.dart';
import 'package:gestion_costos_operativos_app/login_page.dart';
import 'package:gestion_costos_operativos_app/my_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var _title = 'Gestión Costos Operativos';
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          title: _title,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.blue[600],
            accentColor: Colors.lightBlue[900],
            //primarySwatch: Colors.blue,
          ),
          home: MyHomePage(),
        ));
  }
}
