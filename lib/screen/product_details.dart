import 'package:costos_operativos/model/producto.dart';
import 'package:costos_operativos/service/productos_service.dart';
import 'package:costos_operativos/widget/photo_hero.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key key, @required this.id, @required this.imageUrl, @required this.name})
      : super(key: key);
  final int id;
  final String imageUrl;
  final String name;
  final String title = 'Producto';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  Future<Producto> _product;

  @override
  void initState() {
    super.initState();
    //_product = this.getProduct();
  }

  Future<Producto> getProduct(String search) async {
    Response response = await ProductosService().getProducts(context, search);
    return Producto.fromJson(response.data);
  }

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
                name: widget.name,
                width: 150.0,
                radius: 75,
                onTap: () {}),
          ),
        ],
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
