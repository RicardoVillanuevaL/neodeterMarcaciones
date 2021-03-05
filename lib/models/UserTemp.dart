

import 'dart:convert';

UserTemp userTempFromJson(String str) => UserTemp.fromJson(json.decode(str));

String userTempToJson(UserTemp data) => json.encode(data.toJson());

class UserTemp {
    UserTemp({
        this.idRuc,
        this.idCargo,
        this.idArea,
        this.idTurno,
        this.dniJefe,
    });

    String idRuc;
    int idCargo;
    int idArea;
    int idTurno;
    String dniJefe;

    factory UserTemp.fromJson(Map<String, dynamic> json) => UserTemp(
        idRuc: json["id_ruc"],
        idCargo: json["id_cargo"],
        idArea: json["id_area"],
        idTurno: json["id_turno"],
        dniJefe: json["dni_jefe"],
    );

    Map<String, dynamic> toJson() => {
        "id_ruc": idRuc,
        "id_cargo": idCargo,
        "id_area": idArea,
        "id_turno": idTurno,
        "dni_jefe": dniJefe,
    };
}
