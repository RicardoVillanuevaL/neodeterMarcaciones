import 'package:http/http.dart' as http;
import 'package:neodeter_marcaciones/models/MarcationModel.dart';
import 'package:neodeter_marcaciones/preferencias_usuarios/preferencias_usuario.dart';

class _MarcationServices {
  final _prefs = new PreferenciasUsuario();
  //esto cambia
  final String url = 'https://neodeterasist.herokuapp.com';
  Map<dynamic, dynamic> header = {};
  _MarcationServices() {
    header = {
      "Content-Type": "application/json",
      "authorization": _prefs.token
    };
  }

  Future<bool> registrarMarcacion(MarcationModel marcation) async {
    final urlTemp = '$url/registro/registroMarcado';
    final response = await http.post(urlTemp,
        body: marcationModelToJson(marcation),
        headers: {"Content-Type": "application/json"});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> registrarMarcacionTiempo(
      MarcationModel marcation, String horaatual) async {
    marcation.marcadoTiempo = horaatual;
    final urlTemp =
        'https://neodeterasist.herokuapp.com/registro/registroMarcadoSpecial';

    final response = await http.post(urlTemp,
        body: marcationModelToJson(marcation),
        headers: {"Content-Type": "application/json"});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 201 || response.statusCode == 200) {
      return 'correcto';
    } else {
      return 'error # ${response.statusCode}';
    }
  }

  Future<String> registrarMarcacionEspecial(MarcationModel marcation) async {
    final urlTemp = '$url/registro/registroMarcado';
    final response = await http.post(urlTemp,
        body: marcationModelToJson(marcation),
        headers: {"Content-Type": "application/json"});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 201 || response.statusCode == 200) {
      return 'correcto';
    } else {
      return 'error # ${response.statusCode}';
    }
  }
}

final marcationProvider = _MarcationServices();
