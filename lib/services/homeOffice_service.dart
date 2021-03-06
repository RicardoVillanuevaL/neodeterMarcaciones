import 'dart:convert';

import 'package:neodeter_marcaciones/preferencias_usuarios/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class HomeOfficeService {
  final _prefs = new PreferenciasUsuario();
  final String url = 'https://neodeterasist.herokuapp.com';
  Map<dynamic, dynamic> header = {};
  HomeOfficeService() {
    header = {
      "Content-Type": "application/json",
      "authorization": _prefs.token
    };
  }

  Future<dynamic> registrarIngreso() async {
    final urlTemp =
        'https://neodeterasist.herokuapp.com/homeOffice/registroHomeOfficeInicio';
    final response =
        await http.post(urlTemp, headers: {"authorization": _prefs.token});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final decodeResponse = json.decode(response.body);
    print(decodeResponse);
  }

  Future<dynamic> registrarInterrupcion() async {
    final urlTemp =
        'https://neodeterasist.herokuapp.com/homeOffice/UpRegisterInicioInterrupcion';
    final response =
        await http.put(urlTemp, headers: {"authorization": _prefs.token});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final decodeResponse = json.decode(response.body);
    print(decodeResponse);
  }

  Future<dynamic> registrarFinInterrupcion() async {
    final urlTemp =
        'https://neodeterasist.herokuapp.com/homeOffice/ActualizarTiempoTrabajoHO';
    final response =
        await http.put(urlTemp, headers: {"authorization": _prefs.token});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final decodeResponse = json.decode(response.body);
    print(decodeResponse);
  }

  Future<dynamic> registrarFinTrabajo() async {
    final urlTemp =
        'https://neodeterasist.herokuapp.com/homeOffice/RegistrarFinTrabajo';
    final response =
        await http.put(urlTemp, headers: {"authorization": _prefs.token});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final decodeResponse = json.decode(response.body);
    print(decodeResponse);
  }
}

final homeOfficeService = HomeOfficeService();
