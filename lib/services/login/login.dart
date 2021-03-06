import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:neodeter_marcaciones/preferencias_usuarios/preferencias_usuario.dart';
import 'package:neodeter_marcaciones/services/util/session.dart';

class Login {
  final urlp = 'https://neodeterasist.herokuapp.com';
  final _session = Session();

  PreferenciasUsuario _prefs = new PreferenciasUsuario();
  final prefs = new PreferenciasUsuario();
  login(String email, String password) async {
    final cuerpo = {
      "correo": email,
      "password": password,
    };
    final url2 = '$urlp/Usuario/login';
    final resp = await http.post(url2, body: jsonEncode(cuerpo), headers: {
      "Content-Type": "application/json",
    });

    final decodedResp = jsonDecode(resp.body);

    if (resp.statusCode == 200) {
      if (decodedResp.containsKey('Status')) {
        print(decodedResp);
        return {'ok': false, 'mensaje': decodedResp['Status']};
      } else if (decodedResp.containsKey('token')) {
        final id = decodedResp['datos']['empleado_dni'];
        final token = decodedResp['token'];
        final tipous = decodedResp['datos']['tipoUsuarioId'];
        final cargo = decodedResp['datos']['tipo_id_cargo'];
        final telefono = decodedResp['datos']['empleado_telefono'];
        final nombre = decodedResp['datos']['empleado_nombre'];
        final apellido = decodedResp['datos']['empleado_apellido'];
        final dnijefe = decodedResp['datos']['usuario_dni_jefe'];
        final idEmpresa = decodedResp['datos']['id_empresa'];
        prefs.ultimoIngreso = DateTime.now();
        prefs.dni = id;
        prefs.telefono = telefono;
        prefs.nombreUsuario = nombre;
        prefs.apellido = apellido;
        prefs.tipoUsuario = tipous;
        prefs.token = token;
        prefs.cargo = cargo;
        prefs.dnijefe = dnijefe;
        prefs.idEmpresa = idEmpresa;
        await _registertoken(token, id);
        await _session.set(prefs.token, 86400);
        await guardartoken(id, prefs.celtoken);
        print(prefs.celtoken);
        return {'ok': true, 'mensaje': 'Ingreso exitoso'};
      }
    } else {
      return {'ok': false, 'mensaje': 'error al ingresar datos'};
    }
  }

  _registertoken(String token, String id) async {
    final url = "$urlp/registrartoken";
    final cuerpo = {'token': token, 'id': id};

    final resp = await http.post(url, body: jsonEncode(cuerpo), headers: {
      "Content-Type": "application/json",
      "authorization": _prefs.token
    });

    if (resp.statusCode == 200) {
      return resp;
    }
  }

  Future<dynamic> _refreshtoken(String token) async {
    try {
      final url = "$urlp/refrescartoken";
      final cuerpo = {'token': token};

      final resp = await http.post(url, body: jsonEncode(cuerpo), headers: {
        "Content-Type": "application/json",
        "authorization": _prefs.token
      });
      final parsed = jsonDecode(resp.body);
      if (parsed.containsKey('newtoken')) {
        return parsed;
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      print('ERROR+${e.code}:${e.message}');
      return;
    }
  }

  getAccessToken() async {
    try {
      final resp = await _session.get();

      if (resp != null) {
        final token = resp['token'] as String;
        final expiresIn = resp['expiresIn'] as int;
        final createAt = DateTime.parse(resp['createAd']);

        final currentDate = DateTime.now();

        final dif = currentDate.difference(createAt).inSeconds;

        if (expiresIn - dif >= 60) {
          return token;
        } else {
          final newData = await _refreshtoken(token);
          if (newData != null) {
            final newtoken = newData['newtoken'];
            //si no funciona traer el id usuario
            final id = newData['id'];
            prefs.token = newtoken;
            prefs.dni = id;
            final a = await _registertoken(newtoken, id);
            final e = await _session.set(newtoken, 86400);
            print('$a  - $e');
            return newtoken;
          } else {
            return null;
          }
        }
      }
    } on PlatformException catch (e) {
      print('ERROR+${e.code}:${e.message}');
    }
  }

  Future<bool> guardartoken(String id, String token) async {
    final cuerpo = {'id': id, 'token': token};
    final resp = await http.put('$urlp/actualizarTokenCelular',
        body: jsonEncode(cuerpo),
        headers: {
          "Content-Type": "application/json",
          "authorization": _prefs.token
        });
//final decodedResp = json.decode(resp.body);
    if (resp.body == 'Accepted') {
      print('actualizo el token');
      print('$token');
      return true;
    } else {
      return false;
    }
  }
}
