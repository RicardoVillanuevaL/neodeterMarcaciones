import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neodeter_marcaciones/preferencias_usuarios/preferencias_usuario.dart';

class NotiProvider {
  final _prefs = new PreferenciasUsuario();
  final urlp = 'https://asistenciasendnotification.herokuapp.com';

  Future<dynamic> buscarusuarios(String dni, String mensaje) async {
    final url = '$urlp/buscarjefe/$dni';

    final resp = await http.get(url, headers: {'authorization': _prefs.token});

    final decodedData = json.decode(resp.body);

    if (decodedData[0].containsKey('usuario_dni_jefe')) {
      final dnijefe = decodedData[0]['usuario_dni_jefe'];
      _prefs.dnijefe = decodedData[0]['usuario_dni_jefe'];

      final usnombre = decodedData[0]['empleado_nombre'] +
          ' ' +
          decodedData[0]['empleado_apellido'];

      encontrarnoti(dnijefe, usnombre, mensaje);
    }
  }

  Future<dynamic> encontrarnoti(String dni, usunombre, mensaje) async {
    final url = '$urlp/token/$dni';

    final resp = await http.get(url, headers: {'authorization': _prefs.token});
    final decodedData = json.decode(resp.body);

    decodedData.forEach((dni) {
      print(dni);

      if (dni.containsKey('empleado_tokencelular')) {
        mandarnoti(
            dni['empleado_tokencelular'], 'Control de Asistencia', mensaje, '');
      }
    });
  }

  Future<bool> mandarnoti(
      String token, String titulo, String mensaje, String data) async {
    final url = '$urlp/enviarnotificacion';
    final body = {
      'token': token,
      'title': titulo,
      'body': mensaje,
      'data': data
    };
    final resp = await http.post(url,
        headers: {
          'authorization': _prefs.token,
          "Content-Type": "application/json",
        },
        body: json.encode(body));

    print('funciono');
    print(resp);
    final decodedData1 = json.decode(resp.body);
    print(decodedData1);
    return true;
  }
}
