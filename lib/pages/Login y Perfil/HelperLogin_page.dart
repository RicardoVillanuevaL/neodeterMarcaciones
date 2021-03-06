import 'package:flutter/material.dart';
import 'package:neodeter_marcaciones/models/PerfilModel.dart';
import 'package:neodeter_marcaciones/services/loginHelper.dart';
import 'package:neodeter_marcaciones/services/util/notificaciones_util.dart'
    as dialog;

class HelperLoginPage extends StatefulWidget {
  static const String routeName = '/helperLogin';

  @override
  _HelperLoginPageState createState() => _HelperLoginPageState();
}

class _HelperLoginPageState extends State<HelperLoginPage> {
  int stateView;
  String dni;
  PerfilModel helperModel = PerfilModel();
  bool correoSet;
  @override
  void initState() {
    correoSet = false;
    stateView = 0;
    super.initState();
  }

  Widget estadoBusqueda() {
    final color1 = Colors.white;
    if (stateView == 0) {
      //////////-ESTADO INICIAL-///////////
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'POR FAVOR INGRESE SU DNI',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Container(
            width: 200,
            child: TextField(
              textAlign: TextAlign.center,
              maxLines: 1,
              maxLength: 8,
              onChanged: (value) => dni = value,
            ),
            padding: EdgeInsets.only(top: 20, bottom: 40),
          ),
          ElevatedButton(
            // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            // color: Colors.green,
            // shape:
            //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                primary: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
            onPressed: () => validarDNI(),
            child: Text(
              'Buscar',
              style: TextStyle(color: color1, fontSize: 18),
            ),
          ),
          logo()
        ],
      );
    } else if (stateView == 1) {
      //////////////- ESTADO EXITOSO -///////////////
      final style1 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'VALIDAR DATOS',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text('Nombre : ${helperModel.empleadoNombre}', style: style1),
              SizedBox(height: 10),
              Text('Apellido : ${helperModel.empleadoApellido}', style: style1),
              SizedBox(height: 10),
              correoSet
                  ? Text('Correo : ${convertSec(helperModel.empleadoEmail)}',
                      style: style1)
                  : Text(
                      'ESTA CUENTA NO TIENE UN CORREO REGISTRADO POR FAVOR COMUNIQUESÉ CON SOPORTE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
              SizedBox(height: 20),
              logo()
            ],
          ),
        ),
      );
    } else if (stateView == 2) {
      //////////////- ESTADO ERRONEO -///////////////
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'NO EXISTEN DATOS',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'EL USUARIO CON DNI: $dni NO ESTA REGISTRADO POR FAVOR COMUNIQUESÉ CON SOPORTE',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          logo()
        ],
      );
    } else {
      return Container();
    }
  }

  String convertSec(String cadena) {
    final cont = cadena.length;
    final arroba = cadena.indexOf('@');
    final obscure = '*' * (arroba - 4);
    print('$cont  ${obscure.length}');
    final result =
        '${cadena.substring(0, 2)}$obscure${cadena.substring(arroba - 2, cont)}';
    return result;
  }

  Widget logo() {
    return Column(
      children: [
        Divider(),
        SizedBox(height: 20),
        Image.asset(
          'assets/logos/logo_toweramdtower.png',
          height: 100,
          fit: BoxFit.fill,
        )
      ],
    );
  }

  void validarDNI() async {
    if (dni.length == 8) {
      final res = await helper.consultarCorreo(dni);
      if (res != null) {
        if (res.empleadoEmail.trim().length > 1) {
          correoSet = true;
        } else {
          correoSet = false;
        }
        print(correoSet);
        setState(() {
          helperModel = res;
          stateView = 1;
        });
      } else {
        setState(() => stateView = 2);
      }
    } else {
      dialog.alertaImagen(context, 'Aviso', 'El DNI debe tener 8 digitos',
          'assets/logos/connectionError.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ayuda al Trabajador'),
        ),
        body: estadoBusqueda());
  }
}
