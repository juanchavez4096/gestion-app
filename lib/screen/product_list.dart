import 'package:costos_operativos/config/flavor_config.dart';
import 'package:costos_operativos/model/producto.dart';
import 'package:costos_operativos/service/productos_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/auth_service.dart';
import 'product_details.dart';
import '../widget/my_alert_dialog.dart';
import '../widget/my_list_tile.dart';

class ProductList extends StatefulWidget{
  @override
  _ProductListState createState() => _ProductListState();

}

class _ProductListState extends State<ProductList>{
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
    return Center(
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
                                MyListTile(
                                  id: snapshot.data[index].productoId,
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute<void>(builder:
                                            (BuildContext context) {
                                          return Details(
                                            id: snapshot.data[index].productoId,
                                            imageUrl:
                                            '$imageUrl&size=500x500',
                                          );
                                        }));
                                  }, //goToDetails(snapshot.data[index].productoId, imageUrl),
                                  onDelete: () async {
                                    await MyAlertDialog.confirmDialog(context, 'Confirmar', 'Se borrará el producto y no podrá ser devuelto. Los materiales asociados a este producto no se verán afectados. También se borrará la imagen de este producto. ¿Estás de acuerdo?');
                                  },
                                  imageUrl: '$imageUrl&productoId=${snapshot.data[index].productoId}&size=128x128',
                                  name: snapshot.data[index].nombre,
                                  description: snapshot
                                      .data[index].costoProduccion
                                      .toString() +
                                      "Bs",
                                ),
                                Divider(
                                  height: 0,
                                )
                              ],
                            ))));
              },
            ),
          ],
        )
    );
  }
}