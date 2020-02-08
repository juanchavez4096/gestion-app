
import 'package:json_annotation/json_annotation.dart';

part 'producto.g.dart';

@JsonSerializable()
class Producto{
  int productoId;
  String costoProduccion;
  String nombre;
  double depreciacion;
  bool imageLoaded;
  DateTime fechaCreacion;

  Producto(this.productoId, this.costoProduccion, this.nombre, this.depreciacion,
      this.imageLoaded, this.fechaCreacion);


  factory Producto.fromJson(Map<String, dynamic> json) => _$ProductoFromJson(json);
  Map<String, dynamic> toJson() => _$ProductoToJson(this);
}