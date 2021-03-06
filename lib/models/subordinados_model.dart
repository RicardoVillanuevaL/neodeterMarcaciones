import 'dart:convert';

List<SubordinadosModel> subordinadosModelFromJson(String str) => List<SubordinadosModel>.from(json.decode(str).map((x) => SubordinadosModel.fromJson(x)));

String subordinadosModelToJson(List<SubordinadosModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubordinadosModel {
    SubordinadosModel({
        this.empleadoDni,
        this.empleadoNombre,
        this.empleadoApellido,
    });

    String empleadoDni;
    String empleadoNombre;
    String empleadoApellido;

    factory SubordinadosModel.fromJson(Map<String, dynamic> json) => SubordinadosModel(
        empleadoDni: json["empleado_dni"],
        empleadoNombre: json["empleado_nombre"],
        empleadoApellido: json["empleado_apellido"],
    );

    Map<String, dynamic> toJson() => {
        "empleado_dni": empleadoDni,
        "empleado_nombre": empleadoNombre,
        "empleado_apellido": empleadoApellido,
    };
}
