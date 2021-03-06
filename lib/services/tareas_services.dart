import 'package:neodeter_marcaciones/preferencias_usuarios/preferencias_usuario.dart';
import 'package:neodeter_marcaciones/models/tareasModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tareas {
  final String url = 'https://neodeterasist.herokuapp.com';
  final _prefs = new PreferenciasUsuario();

  Future<List<TareasModel>> listarTareas(String dni) async {
    final urlTemp = '$url/consulta/selectTareas/$dni';
    final response = await http.get(
      urlTemp,
      headers: {
        "Content-Type": "application/json",
        "authorization": _prefs.token
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List<dynamic> decodedData = json.decode(response.body);
    print(decodedData);
    List<TareasModel> listaTareas = tareasModelFromJson(response.body);
    if (response.statusCode == 200) {
      return listaTareas;
    } else {
      return null;
    }
  }

  Future<TareasModel> registrarTask(TareasModel model) async {
    final urlTemp = '$url/registro/registroTareas';
    final response = await http.post(urlTemp,
        body: tareasModelToJson(model),
        headers: {
          "Content-Type": "application/json",
          "authorization": _prefs.token
        });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return null;
  }
}

final tareasServices = Tareas();
