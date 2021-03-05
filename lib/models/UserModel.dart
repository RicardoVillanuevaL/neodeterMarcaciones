// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.empleadoApellido,
        this.empleadoNombre,
        this.empleadoFoto,
    });

    String empleadoApellido;
    String empleadoNombre;
    String empleadoFoto;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        empleadoApellido: json["empleado_apellido"],
        empleadoNombre: json["empleado_nombre"],
        empleadoFoto: json["empleado_foto"],
    );

    Map<String, dynamic> toJson() => {
        "empleado_apellido": empleadoApellido,
        "empleado_nombre": empleadoNombre,
        "empleado_foto": empleadoFoto,
    };
}
