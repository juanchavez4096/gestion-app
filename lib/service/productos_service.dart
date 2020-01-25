import 'package:costos_operativos/config/flavor_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../auth_service.dart';

class ProductosService {
  Future<Response> login(String email, String password, Dio dio) async {
    return dio.post('${ServerConstants.getUsers}/login', data: {'email': email, 'password': password});
  }

  Future<Response> getProducts(BuildContext context) async {
    return Provider.of<AuthService>(context, listen: false).dio.get('${ServerConstants.getProducts}/all');
  }
}