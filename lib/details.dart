import 'package:costos_operativos/photo_hero.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Details extends StatefulWidget {
  Details({Key key, this.tagId}) : super(key: key);
  final String tagId;
  final String title = 'Producto';

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int _act = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.

          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          PhotoHero(
              tagId: 'images/flippers-alpha.png',
              name: 'Mayonesa',
              width: 200.0,
              radius: 100,
              onTap: () {})
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
