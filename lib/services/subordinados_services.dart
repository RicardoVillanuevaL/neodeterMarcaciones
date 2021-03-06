import 'package:http/http.dart' as http;
import 'package:neodeter_marcaciones/models/VerMarcacionesModel.dart';
import 'package:neodeter_marcaciones/models/subordinados_model.dart';
import 'package:neodeter_marcaciones/preferencias_usuarios/preferencias_usuario.dart';

class Subordinados {
  final String url = 'https://neodeterasist.herokuapp.com';
  final _prefs = new PreferenciasUsuario();

  Future<List<SubordinadosModel>> listarSubordinados() async {
    final urlTemp = '$url/consulta/selectSubordinados/${_prefs.dni}';
    final response = await http.get(
      urlTemp,
      headers: {
        "Content-Type": "application/json",
        "authorization": _prefs.token
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List<SubordinadosModel> listSubordinados =
        subordinadosModelFromJson(response.body);
    if (response.statusCode == 200) {
      return listSubordinados;
    } else {
      return [];
    }
  }

  Future<List<VerMarcacionesModel>> listarMarcaciones(
      String idSubordi, DateTime fecha) async {
    final urlTemp =
        '$url/consulta/selectReporteCell/$idSubordi/${fecha.year}-${fecha.month}-${fecha.day}';
    final response = await http.get(
      urlTemp,
      headers: {
        "Content-Type": "application/json",
        "authorization": _prefs.token
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List<VerMarcacionesModel> listMarcaciones =
        verMarcacionesModelFromJson(response.body);
    if (response.statusCode == 200) {
      return listMarcaciones;
    } else {
      return [];
    }
  }
}

final subordinadosService = Subordinados();
