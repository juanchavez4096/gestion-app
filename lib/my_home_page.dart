import 'package:costos_operativos/details.dart';
import 'package:costos_operativos/photo_hero.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  final String title = 'Productos';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _act = 1;

  void changeState() {
    setState(() {
      _act == 1 ? _act = 2 : _act = 1;
    });
  }
  Future<Null> scroll() async{

    await new Future.delayed(new Duration(seconds: 1));

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Theme.of(context).primaryColor,
        animatedIcon: AnimatedIcons.menu_close,
        overlayOpacity: 0,
        children: [
          SpeedDialChild(child: Icon(Icons.add), label: 'Agregar Producto'),
          SpeedDialChild(child: Icon(Icons.receipt), label: 'Reporte')
        ],
      ),
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
              leading: Icon(Icons.message),
              title: Text('Productos'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Materiales'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Administración'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuracion'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Buscar Producto',
                    contentPadding: EdgeInsets.all(5)),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: scroll,
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: ListTile.divideTiles(context: context, tiles: [
                      ListTile(
                          leading: PhotoHero(
                              tagId: 'images/flippers-alpha.png',
                              name: 'Mayonesa',
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute<void>(
                                    builder: (BuildContext context){
                                      return Details(tagId: 'images/flippers-alpha.png',);
                                    }
                                ));
                              }
                          ),
                          title: const Text('Mayonesa'),
                          subtitle: const Text('Se usa para untar'),
                          enabled: true,
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: alertDialog,
                          ),
                          onTap: () {}),
                      ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(
                                'M'), // no matter how big it is, it won't overflow
                          ),
                          title: const Text('Mayonesa'),
                          subtitle: const Text('Se usa para untar'),
                          enabled: true,
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {},
                          ),
                          onTap: () {})
                    ]).toList(),
                  ),
                )
              )
            ],
          ) /*ListView(

          children: ListTile.divideTiles(context: context, tiles: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10
              ),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Buscar Producto', contentPadding: EdgeInsets.all(5)),
              ),
            ),
            ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child:
                      Text('M'), // no matter how big it is, it won't overflow
                ),
                title: const Text('Mayonesa'),
                subtitle: const Text('Se usa para untar'),
                enabled: true,
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: alertDialog,
                ),
                onTap: () {}),
            ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child:
                      Text('M'), // no matter how big it is, it won't overflow
                ),
                title: const Text('Mayonesa'),
                subtitle: const Text('Se usa para untar'),
                enabled: true,
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                ),
                onTap: () {})
          ]).toList(),
        ),*/
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> alertDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar'),
          content: Text(
              'Se borrará el producto y no podrá ser devuelto. Los materiales asociados a este producto no se verán afectados. También se borrará la imagen de este producto. ¿Estás de acuerdo?'),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.grey,
              child: Text('Rechazar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              textColor: Colors.red,
              child: Text('Aceptar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
