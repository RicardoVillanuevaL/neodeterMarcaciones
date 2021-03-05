
import 'dart:convert';

List<TareasModel> tareasModelFromJson(String str) => List<TareasModel>.from(json.decode(str).map((x) => TareasModel.fromJson(x)));

String tareasModelToJson(TareasModel data) => json.encode(data.toJson());

class TareasModel {
    TareasModel({
        this.jefe,
        this.trabajador,
        this.tarea1,
        this.tarea2,
        this.tarea3,
        this.fecha
    });

    String jefe;
    String trabajador;
    String tarea1;
    String tarea2;
    String tarea3;
    DateTime fecha;

    factory TareasModel.fromJson(Map<String, dynamic> json) => TareasModel(
        tarea1: json["tarea_1"],
        tarea2: json["tarea_2"],
        tarea3: json["tarea_3"],
        fecha : DateTime.parse(json["tarea_fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "jefe": jefe,
        "trabajador": trabajador,
        "tarea1": tarea1,
        "tarea2": tarea2,
        "tarea3": tarea3,
        "fecha":"${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}"
    };
}
