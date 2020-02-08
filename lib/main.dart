import 'package:costos_operativos/service/auth_service.dart';
import 'package:costos_operativos/config/flavor_config.dart';
import 'package:costos_operativos/screen/login_page.dart';
import 'package:costos_operativos/screen/my_home_page.dart';
import 'package:costos_operativos/screen/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:provider/provider.dart';

void main() {
  FlavorConfig(
      flavor: Flavor.DEV,
      flavorValues: FlavorValues(baseUrl: "http://192.168.1.84:8081"));

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    //MyHomePage().createState().alertDialog();
  };

  Stetho.initialize();

  runApp(ChangeNotifierProvider<AuthService>(
    child: MyApp(),
    create: (BuildContext context) {
      return AuthService();
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const _title = 'Gestión Costos Operativos';
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Consumer<AuthService>(
          builder: (ctx, auth, _) => MaterialApp(
            title: _title,
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.blue[600],
              accentColor: Colors.lightBlue[900],
              //primarySwatch: Colors.blue,
            ),
            home: auth.token != null
                ? MyHomePage()
                : FutureBuilder(
                    future: auth.getToken(),
                    builder: (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? SplashPage()
                            : LoginPage(),
                  ),
          ),
        ));
  }
}
