
import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    NotificationModel({
        this.idTelefono,
        this.fechahora,
        this.latitud,
        this.longitud,
        this.titulo,
        this.cuerpo,
    });

    String idTelefono;
    String fechahora;
    String latitud;
    String longitud;
    String titulo;
    String cuerpo;

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        idTelefono: json["dni_user_notification"],
        fechahora: json["fecha_notification"],
        latitud: json["latitud_notification"],
        longitud: json["longitud_notification"],
        titulo: json["titulo_notification"],
        cuerpo: json["cuerpo_notification"],
    );

    Map<String, dynamic> toJson() => {
        "idTelefono": idTelefono,
        "fechahora": fechahora,
        "latitud": latitud,
        "longitud": longitud,
        "titulo": titulo,
        "cuerpo": cuerpo,
    };
}
