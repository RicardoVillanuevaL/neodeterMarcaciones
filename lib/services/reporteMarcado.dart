import 'package:http/http.dart' as http;

import 'dart:convert';

RegistroMarcado registroMarcadoFromJson(String str) =>
    RegistroMarcado.fromJson(json.decode(str));

String registroMarcadoToJson(RegistroMarcado data) =>
    json.encode(data.toJson());

class RegistroMarcado {
  RegistroMarcado({
    this.dni,
    this.tiempo,
  });

  String dni;
  String tiempo;

  factory RegistroMarcado.fromJson(Map<String, dynamic> json) =>
      RegistroMarcado(
        dni: json["dni"],
        tiempo: json["tiempo"],
      );

  Map<String, dynamic> toJson() => {
        "dni": dni,
        "tiempo": tiempo,
      };
}

class _ReporteMarcadoServices {
  Future<bool> registrarMarcadoReporte(String dni, String tiempo) async {
    final model = RegistroMarcado(dni: dni, tiempo: tiempo);
    final url =
        'https://asistenciasendnotification.herokuapp.com/reporte/registroMarcadoReporte';
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: registroMarcadoToJson(model));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> actualizarRefrigerioMarcadoReporte(
      String dni, String tiempo) async {
    final url =
        'https://asistenciasendnotification.herokuapp.com/reporte/UpdateReporteRefrigerio';
    final model = RegistroMarcado(dni: dni, tiempo: tiempo);
    final response = await http.put(url,
        headers: {"Content-Type": "application/json"},
        body: registroMarcadoToJson(model));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> actualizarFinRefrigerioMarcadoReporte(
      String dni, String tiempo) async {
    final url =
        'https://asistenciasendnotification.herokuapp.com/reporte/UpdateReporteFinRefrigerio';
    final model = RegistroMarcado(dni: dni, tiempo: tiempo);
    final response = await http.put(url,
        headers: {"Content-Type": "application/json"},
        body: registroMarcadoToJson(model));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> actualizarSalidaMarcadoReporte(String dni, String tiempo) async {
    final url =
        'https://asistenciasendnotification.herokuapp.com/reporte/UpdateReporteSalida';
    final model = RegistroMarcado(dni: dni, tiempo: tiempo);
    final response = await http.put(url,
        headers: {"Content-Type": "application/json"},
        body: registroMarcadoToJson(model));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
//IMPORTANTE PARA CONTINUAR VER SIGUIENTES LINKS
//https://pub.dev/packages/cron
//https://pub.dev/packages/timezone
//https://24timezones.com/Lima/hora

final reporteMarcado = _ReporteMarcadoServices();
