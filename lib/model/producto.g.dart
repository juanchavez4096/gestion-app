// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Producto _$ProductoFromJson(Map<String, dynamic> json) {
  return Producto(
    json['productoId'] as int,
    json['costoProduccion'] as String,
    json['nombre'] as String,
    (json['depreciacion'] as num)?.toDouble(),
    json['imageLoaded'] as bool,
    json['fechaCreacion'] == null
        ? null
        : DateTime.parse(json['fechaCreacion'] as String),
  );
}

Map<String, dynamic> _$ProductoToJson(Producto instance) => <String, dynamic>{
      'productoId': instance.productoId,
      'costoProduccion': instance.costoProduccion,
      'nombre': instance.nombre,
      'depreciacion': instance.depreciacion,
      'imageLoaded': instance.imageLoaded,
      'fechaCreacion': instance.fechaCreacion?.toIso8601String(),
    };
