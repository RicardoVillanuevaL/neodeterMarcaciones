// To parse this JSON data, do
//
//     final verMarcacionesModel = verMarcacionesModelFromJson(jsonString);

import 'dart:convert';

List<VerMarcacionesModel> verMarcacionesModelFromJson(String str) => List<VerMarcacionesModel>.from(json.decode(str).map((x) => VerMarcacionesModel.fromJson(x)));

String verMarcacionesModelToJson(List<VerMarcacionesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VerMarcacionesModel {
    VerMarcacionesModel({
        this.marcadoTipo,
        this.marcadoTiempo,
    });

    String marcadoTipo;
    String marcadoTiempo;

    factory VerMarcacionesModel.fromJson(Map<String, dynamic> json) => VerMarcacionesModel(
        marcadoTipo: json["marcado_tipo"],
        marcadoTiempo: json["marcado_tiempo"],
    );

    Map<String, dynamic> toJson() => {
        "marcado_tipo": marcadoTipo,
        "marcado_tiempo": marcadoTiempo,
    };
}
