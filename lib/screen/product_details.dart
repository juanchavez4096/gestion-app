import 'package:costos_operativos/widget/photo_hero.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Details({Key key, @required this.id, @required this.imageUrl})
      : super(key: key);
  final int id;
  final String imageUrl;
  final String title = 'Producto';

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
            child: PhotoHero(
                id: widget.id,
                imageUrl: '${widget.imageUrl}&productoId=${widget.id}',
                name: 'Mayonesa',
                width: 150.0,
                radius: 75,
                onTap: () {}),
          ),
        ],
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
