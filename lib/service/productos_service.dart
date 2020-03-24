import 'package:costos_operativos/config/flavor_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';

class ProductosService {

  Future<Response> getProducts(BuildContext context, String search) async {
    return Provider.of<AuthService>(context, listen: false).dio.get('${ServerConstants.getProducts}/all?search=$search');
  }

  Future<Response> getProduct(BuildContext context, int id) async {
    return Provider.of<AuthService>(context, listen: false).dio.get('${ServerConstants.getProducts}/byId?id=$id');
  }
}