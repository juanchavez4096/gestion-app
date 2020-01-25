import 'package:flutter/material.dart';

enum Flavor {
  DEV,
  QA,
  PRODUCTION
}

class FlavorValues {
  FlavorValues({@required this.baseUrl});
  final String baseUrl;
}

class FlavorConfig {
  final Flavor flavor;
  final Color color;
  final FlavorValues flavorValues;
  static FlavorConfig _flavorConfig;

  factory FlavorConfig({@required Flavor flavor, Color color: Colors.blue, @required FlavorValues flavorValues}){
    _flavorConfig ??= FlavorConfig._internal( flavor, color, flavorValues);
    return _flavorConfig;
  }

  FlavorConfig._internal(this.flavor, this.color, this.flavorValues);
  static FlavorConfig get instance  { return _flavorConfig;}
  static bool isProduction() => _flavorConfig.flavor == Flavor.PRODUCTION;
  static bool isDevelopment() => _flavorConfig.flavor == Flavor.DEV;
  static bool isQA() => _flavorConfig.flavor == Flavor.QA;



}

class ServerConstants{
  static const String getUsers = '/api/usuario';
  static const String getProducts = '/api/productos';
  static const String getMateriales = '/api/materiales';
  static const String getProductoMaterial = '/api/productoMaterial';
  static const String getEmpresa = '/api/empresa';
  static const String getPdf = '/api/pdf';
}