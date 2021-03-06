// To parse this JSON data, do
//
//     final helperModel = helperModelFromJson(jsonString);

import 'dart:convert';

List<HelperModel> helperModelFromJson(String str) => List<HelperModel>.from(json.decode(str).map((x) => HelperModel.fromJson(x)));

String helperModelToJson(List<HelperModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HelperModel {
    HelperModel({
        this.empleadoEmail,
        this.empleadoContrasea,
        this.empleadoNombre,
        this.empleadoApellido,
    });

    String empleadoEmail;
    String empleadoContrasea;
    String empleadoNombre;
    String empleadoApellido;

    factory HelperModel.fromJson(Map<String, dynamic> json) => HelperModel(
        empleadoEmail: json["empleado_email"],
        empleadoContrasea: json["empleado_contraseña"],
        empleadoNombre: json["empleado_nombre"],
        empleadoApellido: json["empleado_apellido"],
    );

    Map<String, dynamic> toJson() => {
        "empleado_email": empleadoEmail,
        "empleado_contraseña": empleadoContrasea,
        "empleado_nombre": empleadoNombre,
        "empleado_apellido": empleadoApellido,
    };
}
