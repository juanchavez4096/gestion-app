import 'package:costos_operativos/config/flavor_config.dart';
import 'package:dio/dio.dart';

class UserService {
  Future<Response> login(String email, String password, Dio dio) async {
    return dio.post('${ServerConstants.getUsers}/login', data: {'email': email, 'password': password});
  }

  Future<Response> getCurrentUser(Dio dio) async {
    return dio.get('/${ServerConstants.getUsers}/currentUser');
  }
}