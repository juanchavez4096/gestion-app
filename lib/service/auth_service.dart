import 'dart:async';
import 'package:costos_operativos/config/flavor_config.dart';
import 'package:costos_operativos/model/user.dart';
import 'package:costos_operativos/service/user_service.dart';
import 'package:costos_operativos/widget/my_alert_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthService extends ChangeNotifier {
  static const String STORAGE_KEY = 'token';
  static const String FIELD_NAME_USER_EMAIL = 'email';
  static const String FIELD_NAME_USER_DISPLAY = 'nombre';
  static const String FIELD_NAME_USER_ROLE_ID = 'rol';
  final storage = new FlutterSecureStorage();
  User currentUser;
  var token;

  Dio _dio;

  Dio get dio{
    return _dio;
  }

  AuthService(){
    BaseOptions options = new BaseOptions(
      baseUrl: FlavorConfig.instance.flavorValues.baseUrl,
      headers: getHeadersJSON()
    );
    _dio = new Dio(options);
    
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options) async {
        // Do something before request is sent
        if(token != null){
          options.headers['Authorization'] = 'Bearer $token';
        }
        return options;
      },
    ));

  }

  getUser() {
    return Future.value(currentUser);
  }

  Future<bool> getToken() async {
    this.token = await storage.read(key: STORAGE_KEY);
    if (this.token == null) {
      return false;
    }
    String name = await storage.read(key: FIELD_NAME_USER_DISPLAY);
    String email = await storage.read(key: FIELD_NAME_USER_EMAIL);
    String rol = await storage.read(key: FIELD_NAME_USER_ROLE_ID);
    this.currentUser = new User(name, email, int.parse(rol));
    notifyListeners();
    return true;
  }

  logout() {

    this.currentUser = null;
    this.token = null;
    storage.deleteAll();
    notifyListeners();
  }

  setToken(BuildContext context,String token) async{
    storage.write(key: STORAGE_KEY, value: token);
    this.token = token;
    return await UserService().getCurrentUser(_dio).then( (value) async {
      print(value.data);
      User user = User.fromJson(value.data);
      user.rol = value.data['tipoUsuario']['tipoUsuarioId'];
      await storage.write(key: FIELD_NAME_USER_DISPLAY, value: user.nombre);
      await storage.write(key: FIELD_NAME_USER_EMAIL, value: user.email);
      await storage.write(key: FIELD_NAME_USER_ROLE_ID, value: user.rol.toString());
      this.currentUser = user;
    });
  }

  // logs in the user if password matches
  Future<void> loginUser({@required String email, @required String password, @required BuildContext context}) async {
    return UserService().login(email, password, _dio).then( (value) async {
      print(value.data);
        setToken(context, value.data['token']);
        notifyListeners();
    });


  }


  getHeadersJSON(){
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  getHeadersJSONNoToken(){
    return {
      'Content-Type': 'application/json',
    };
  }
}