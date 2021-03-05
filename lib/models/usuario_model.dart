import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  String dni;
  String nombre;
  String apellido;
  String telefono;
  String correo;
  String contrasea;

  Usuario({
    this.dni,
    this.nombre,
    this.apellido,
    this.telefono,
    this.correo,
    this.contrasea,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    dni: json["dni"],
    nombre: json["nombre"],
    apellido: json["apellido"],
    telefono: json["telefono"],
    correo: json["correo"],
    contrasea: json["contraseña"],
  );

  Map<String, dynamic> toJson() => {
    "dni": dni,
    "nombre": nombre,
    "apellido": apellido,
    "telefono": telefono,
    "correo": correo,
    "contraseña": contrasea,
  };
}
