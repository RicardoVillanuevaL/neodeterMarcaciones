import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neodeter_marcaciones/models/NotificationModel.dart';
import 'package:neodeter_marcaciones/preferencias_usuarios/preferencias_usuario.dart';

class _NotificacionServices {
  final _prefs = new PreferenciasUsuario();
  final String url = 'https://neodeterasist.herokuapp.com';
  Map<dynamic, dynamic> header = {};
  _NotificacionServices() {
    header = {
      "Content-Type": "application/json",
      "authorization": _prefs.token
    };
  }

  Future<NotificationModel> registrarNotification(
      NotificationModel model) async {
    final urlTemp = '$url/registro/registroNotificacion';
    final response = await http.post(urlTemp,
        body: notificationModelToJson(model),
        headers: {
          "Content-Type": "application/json",
          "authorization": _prefs.token
        });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return null;
  }

  Future<List<NotificationModel>> listarNotificaciones() async {
    final response = await http.get(
        '$url/consulta/consultaNotificaciones/${_prefs.telefono}',
        headers: {"authorization": _prefs.token});
    final List<dynamic> decodedData = json.decode(response.body);
    final List<NotificationModel> listNotificaciones = [];
    print(decodedData);

    if (decodedData == null) return [];
    decodedData.forEach((resp) {
      final temp = NotificationModel.fromJson(resp);
      listNotificaciones.add(temp);
    });
    return listNotificaciones;
  }
}

final notificationProvider = _NotificacionServices();
