import 'package:costos_operativos/model/selection.dart';
import 'package:costos_operativos/screen/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import '../service/auth_service.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Selection selection = Selection.PRODUCTOS;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SelectionHelper.getSelectionString(selection)),
      ),
      floatingActionButton: selection == Selection.PRODUCTOS ||
              selection == Selection.MATERIALES ||
              selection == Selection.ADMINISTRACION
          ? SpeedDial(
              backgroundColor: Theme.of(context).primaryColor,
              animatedIcon: AnimatedIcons.menu_close,
              overlayOpacity: 0,
              children: [
                SpeedDialChild(
                    child: Icon(Icons.add),
                    label:
                        'Agregar ${SelectionHelper.getSingularString(selection)}'),
                SpeedDialChild(child: Icon(Icons.receipt), label: 'Reporte'),
              ],
            )
          : null,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Gestion de costos Operativos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Productos'),
              selected: selection == Selection.PRODUCTOS,
              onTap: () {
                if (selection != Selection.PRODUCTOS) {
                  setState(() {
                    selection = Selection.PRODUCTOS;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Materiales'),
              selected: selection == Selection.MATERIALES,
              onTap: () {
                if (selection != Selection.MATERIALES) {
                  setState(() {
                    selection = Selection.MATERIALES;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Administración'),
              selected: selection == Selection.ADMINISTRACION,
              onTap: () {
                if (selection != Selection.ADMINISTRACION) {
                  setState(() {
                    selection = Selection.ADMINISTRACION;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Perfil'),
              selected: selection == Selection.PERFIL,
              onTap: () {
                if (selection != Selection.PERFIL) {
                  setState(() {
                    selection = Selection.PERFIL;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Preferencias'),
              selected: selection == Selection.SETTINGS,
              onTap: () {
                if (selection != Selection.SETTINGS) {
                  setState(() {
                    selection = Selection.SETTINGS;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Ayuda'),
              selected: selection == Selection.HELP,
              onTap: () {
                if (selection != Selection.HELP) {
                  setState(() {
                    selection = Selection.HELP;
                  });
                }
                Navigator.of(context).pop();
              },
            ),

            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<AuthService>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
      body: selection == Selection.PRODUCTOS ? ProductList() : Container(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
