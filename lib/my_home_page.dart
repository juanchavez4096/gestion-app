import 'package:costos_operativos/config/flavor_config.dart';
import 'package:costos_operativos/details.dart';
import 'package:costos_operativos/model/producto.dart';
import 'package:costos_operativos/model/selection.dart';
import 'package:costos_operativos/photo_hero.dart';
import 'package:costos_operativos/service/productos_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Selection selection = Selection.PRODUCTOS;

  Future<Null> scroll() async {
    setState(() {
      products = this.getProducts();
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    products = this.getProducts();
  }

  Future<List<Producto>> products;

  Future<List<Producto>> getProducts() async {
    Response response = await ProductosService().getProducts(context);
    List i = response.data['content'];
    return i.map((m) => Producto.fromJson(m)).toList();
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
              leading: const Icon(Icons.message),
              title: Text('Productos'),
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
              leading: const Icon(Icons.account_circle),
              title: Text('Materiales'),
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
              title: Text('Administración'),
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
              title: Text('Perfil'),
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
              title: Text('Configuración'),
              selected: selection == Selection.CONFIGURACION,
              onTap: () {
                if (selection != Selection.CONFIGURACION) {
                  setState(() {
                    selection = Selection.CONFIGURACION;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text('Cerrar Sesión'),
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<AuthService>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Buscar Producto',
                contentPadding: EdgeInsets.all(5)),
          ),
          FutureBuilder<List<Producto>>(
            future: products,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.active) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.none &&
                  snapshot.hasData == null) {
                //print('project snapshot data is: ${projectSnap.data}');
                return Container();
              }
              String imageUrl =
                  '${FlavorConfig.instance.flavorValues.baseUrl + ServerConstants.getProducts}/file/download?token=${Provider.of<AuthService>(context).token}';
              return Expanded(
                  child: RefreshIndicator(
                      onRefresh: () => scroll(),
                      child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, index) => Column(
                                children: <Widget>[
                                  ListTile(
                                      leading: PhotoHero(
                                          id: snapshot.data[index].productoId,
                                          name: snapshot.data[index].nombre,
                                          imageUrl:
                                              '$imageUrl&productoId=${snapshot.data[index].productoId}&size=128x128',
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute<void>(builder:
                                                    (BuildContext context) {
                                              return Details(
                                                id: snapshot
                                                    .data[index].productoId,
                                                imageUrl:
                                                    '$imageUrl&size=500x500',
                                              );
                                            }));
                                          }),
                                      title: Text(snapshot.data[index].nombre),
                                      subtitle: Text(snapshot
                                              .data[index].costoProduccion
                                              .toString() +
                                          "Bs"),
                                      enabled: true,
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () => alertDialog(),
                                      ),
                                      onTap: () {}),
                                  Divider(
                                    height: 0,
                                  )
                                ],
                              ))));
            },
          ),
        ],
      )), // This trailing comma makes auto-formatting nicer for build methods.
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
