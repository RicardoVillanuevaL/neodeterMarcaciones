import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    UsuarioModel({
        this.empleadoDni,
        this.empleadoNombre,
        this.empleadoApellido,
        this.empleadoTelefono,
        this.empleadoEmail,
        this.empleadoContrasea,
        this.empleadoImei,
        this.empleadoToken,
        this.empleadoFoto,
        this.empleadoUltimoIngreso,
        this.empleadoTokencelular,
        this.usuarioDniJefe,
        this.tipoIdCargo,
        this.idTurno,
        this.idArea,
        this.idEmpresa,
    });

    String empleadoDni;
    String empleadoNombre;
    String empleadoApellido;
    String empleadoTelefono;
    String empleadoEmail;
    String empleadoContrasea;
    dynamic empleadoImei;
    String empleadoToken;
    dynamic empleadoFoto;
    String empleadoUltimoIngreso;
    String empleadoTokencelular;
    String usuarioDniJefe;
    int tipoIdCargo;
    int idTurno;
    dynamic idArea;
    String idEmpresa;

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        empleadoDni: json["empleado_dni"],
        empleadoNombre: json["empleado_nombre"],
        empleadoApellido: json["empleado_apellido"],
        empleadoTelefono: json["empleado_telefono"],
        empleadoEmail: json["empleado_email"],
        empleadoContrasea: json["empleado_contraseña"],
        empleadoImei: json["empleado_imei"],
        empleadoToken: json["empleado_token"],
        empleadoFoto: json["empleado_foto"],
        empleadoUltimoIngreso: json["empleado_ultimo_ingreso"],
        empleadoTokencelular: json["empleado_tokencelular"],
        usuarioDniJefe: json["usuario_dni_jefe"],
        tipoIdCargo: json["tipo_id_cargo"],
        idTurno: json["id_turno"],
        idArea: json["id_area"],
        idEmpresa: json["id_empresa"],
    );

    Map<String, dynamic> toJson() => {
        "empleado_dni": empleadoDni,
        "empleado_nombre": empleadoNombre,
        "empleado_apellido": empleadoApellido,
        "empleado_telefono": empleadoTelefono,
        "empleado_email": empleadoEmail,
        "empleado_contraseña": empleadoContrasea,
        "empleado_imei": empleadoImei,
        "empleado_token": empleadoToken,
        "empleado_foto": empleadoFoto,
        "empleado_ultimo_ingreso": empleadoUltimoIngreso,
        "empleado_tokencelular": empleadoTokencelular,
        "usuario_dni_jefe": usuarioDniJefe,
        "tipo_id_cargo": tipoIdCargo,
        "id_turno": idTurno,
        "id_area": idArea,
        "id_empresa": idEmpresa,
    };
}
