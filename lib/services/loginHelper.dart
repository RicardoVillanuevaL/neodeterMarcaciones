import 'package:neodeter_marcaciones/models/PerfilModel.dart';
import 'package:http/http.dart' as http;

import 'package:neodeter_marcaciones/models/helperModel.dart';

class LoginHelper {
  Future<PerfilModel> consultarCorreo(String dni) async {
    final response = await http.get(
        'https://neodeterasist.herokuapp.com/consulta/consultarPerfil/$dni',
        headers: {"Content-Type": "application/json"});
    final temp = helperModelFromJson(response.body);
    print(temp);
    if (temp.isEmpty) {
      return null;
    } else {
      final val = temp[0];
      PerfilModel result = PerfilModel(
        empleadoEmail: val.empleadoEmail,
        empleadoContrasea: val.empleadoContrasea,
        empleadoApellido: val.empleadoApellido,
        empleadoNombre: val.empleadoNombre,
      );
      return result;
    }
  }
}

final helper = LoginHelper();
