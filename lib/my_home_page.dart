import 'dart:convert';
import 'dart:math';

import 'package:costos_operativos/class/producto.dart';
import 'package:costos_operativos/config/flavor_config.dart';
import 'package:costos_operativos/details.dart';
import 'package:costos_operativos/photo_hero.dart';
import 'package:costos_operativos/service/productos_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  final String title = 'Productos';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Cerrar Sesión'),
              onTap: () {
                Provider.of<AuthService>(context, listen: false).logout();
              },
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
              print('newBuild');
              String imageUrl =
                  '${FlavorConfig.instance.flavorValues.baseUrl + ServerConstants.getProducts}/file/download?a=${Random().nextInt(100)}&token=${Provider.of<AuthService>(context).token}';
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
                                        onPressed: alertDialog,
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
