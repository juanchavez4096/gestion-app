import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()

class User {
  User(this.nombre, this.email, this.rol);

  String nombre;
  String email;
  int rol;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}