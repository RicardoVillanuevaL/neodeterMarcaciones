import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';
import 'package:neodeter_marcaciones/models/MarcationModel.dart';
import 'package:neodeter_marcaciones/models/NotificationModel.dart';
import 'package:neodeter_marcaciones/preferencias_usuarios/preferencias_usuario.dart';
import 'package:neodeter_marcaciones/provider/barcodeScanner.dart';
import 'package:neodeter_marcaciones/provider/notificacion_provider.dart';
import 'package:neodeter_marcaciones/services/homeOffice_service.dart';
import 'package:neodeter_marcaciones/services/marcacion_services.dart';
import 'package:neodeter_marcaciones/services/notification_services.dart';
import 'package:neodeter_marcaciones/services/util/notificaciones_util.dart'
    as util;
import 'package:neodeter_marcaciones/services/reporteMarcado.dart';

class BoardHomeOffice extends StatefulWidget {
  @override
  _BoardHomeOfficeState createState() => _BoardHomeOfficeState();
}

class _BoardHomeOfficeState extends State<BoardHomeOffice> {
  MarcationModel marcationModel;
  NotificationModel notificationModel;

  final prefs = PreferenciasUsuario();
  int stateWork;
  int stateLunch;
  int stateView;
  double altura;

  @override
  void initState() {
    stateView = 0;
    cargaState();
    marcationModel = MarcationModel();
    notificationModel = NotificationModel();
    rellenarDatosGenericos();
    super.initState();
  }

  cargaState() {
    String result = DateFormat("yyyy-MM-dd").format(DateTime.now());
    try {
      if (result != prefs.ultimoIngreso && prefs.idStateWorking == 5) {
        prefs.idStateWorking = 0;
      }
      if (prefs.idStateWorking == null) {
        prefs.idStateWorking = 0;
      }
      if (prefs.idLunch == null) {
        prefs.idLunch = 0;
      }
      setState(() {
        stateWork = prefs.idStateWorking;
        stateLunch = prefs.idLunch;
        stateView = 1;
      });
    } catch (e) {
      setState(() {
        stateWork = 0;
        stateLunch = 0;
        stateView = 1;
      });
    }
  }

  listaWidget() {
    List<Widget> listaRetorno = [];
    if (stateWork == 0) {
      listaRetorno.add(SpecialButton(
        title: 'Ingreso al trabajo',
        image: 'assets/logos/ingreso_marcatition.jpg',
        funtion: 0,
        marcaModel: marcationModel,
        notiModel: notificationModel,
        height: altura / 4,
      ));
    } else if (stateWork == 1) {
      listaRetorno.add(SpecialButton(
        title: 'Interrupción',
        image: 'assets/logos/salida_marcation.jpg',
        funtion: 1,
        marcaModel: marcationModel,
        notiModel: notificationModel,
        height: altura / 4,
      ));
      listaRetorno.add(SpecialButton(
        title: 'Refrigerio', // UNA VEZ AL DIA LA COMIDA
        image: 'assets/logos/LunchTime.jpg',
        funtion: 0,
        marcaModel: marcationModel,
        notiModel: notificationModel,
        height: altura / 4,
      ));
    } else if (stateWork == 2) {
      listaRetorno.add(SpecialButton(
        title: 'Fin de Refrigerio', // SOLO PASA UNA VEZ AL DIA
        image: 'assets/logos/Retorno_Work.png',
        funtion: 0,
        marcaModel: marcationModel,
        notiModel: notificationModel,
        height: altura / 4,
      ));
    } else if (stateWork == 3) {
      listaRetorno.add(SpecialButton(
        title: 'Regreso al trabajo',
        image: 'assets/logos/Retorno_Work.png',
        funtion: 0,
        marcaModel: marcationModel,
        notiModel: notificationModel,
        height: altura / 4,
      ));
    } else if (stateWork == 4) {
      listaRetorno.add(SpecialButton(
        title: 'Interrupción',
        image: 'assets/logos/salida_marcation.jpg',
        funtion: 1,
        marcaModel: marcationModel,
        notiModel: notificationModel,
        height: altura / 4,
      ));
      listaRetorno.add(SpecialButton(
        title: 'Fin del Dia',
        image: 'assets/logos/end.jpg',
        funtion: 0,
        marcaModel: marcationModel,
        notiModel: notificationModel,
        height: altura / 4,
      ));
    } else if (stateWork == 5) {
      listaRetorno.add(SpecialButton(
        title: 'Boton de Final',
        image: 'assets/logos/ingreso_marcatition.jpg',
        funtion: 0,
        marcaModel: marcationModel,
        notiModel: notificationModel,
        height: altura / 4,
      ));
    }
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: listaRetorno,
        ),
      ),
    );
  }

  vistaPrincipal() {
    if (stateView == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return FadeInDown(child: listaWidget());
    }
  }

  void rellenarDatosGenericos() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    marcationModel.marcadoIdTelefono = prefs.telefono;
    marcationModel.marcadoDni = prefs.dni;
    marcationModel.marcadoLatitud = position.latitude.toString();
    marcationModel.marcadoLongitud = position.longitude.toString();
    marcationModel.marcadoFechaHora = DateTime.now().toString();
    marcationModel.marcadoTemperatura = 0;
    notificationModel.idTelefono = prefs.telefono;
    notificationModel.fechahora = DateTime.now().toString();
    notificationModel.latitud = position.latitude.toString();
    notificationModel.longitud = position.longitude.toString();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    altura = screenSize.height;
    return vistaPrincipal();
  }
}

class SpecialButton extends StatefulWidget {
  final String title;
  final String image;
  final int funtion; // 0 -> Register  & 1-> Update
  final MarcationModel marcaModel;
  final NotificationModel notiModel;
  final double height;
  const SpecialButton(
      {Key key,
      @required this.title,
      @required this.image,
      @required this.funtion,
      @required this.marcaModel,
      @required this.notiModel,
      @required this.height});

  @override
  _SpecialButtonState createState() => _SpecialButtonState();
}

class _SpecialButtonState extends State<SpecialButton> {
  String horaActual;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50.0, left: 50, top: 20),
      child: GestureDetector(
        onTap: () async {
          action(widget.funtion, widget.marcaModel, widget.notiModel, context);
        },
        child: Card(
          elevation: 10,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Image.asset(widget.image),
                    height: this.widget.height,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validacionQR(String cadena, String validacion) {
    bool result;
    var temp = cadena.split('|');
    print(validacion);
    try {
      if (temp[2] == validacion) {
        result = true;
      } else {
        result = false;
      }
    } catch (e) {
      result = false;
    }
    return result;
  }

  Future<void> getTime() async {
    try {
      final response =
          await get('http://worldtimeapi.org/api/timezone/America/Lima');
      Map data = jsonDecode(response.body);
      //print(data);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].toString().substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: (-1) * int.parse(offset)));
      print(now.toString().substring(11, 19));
      horaActual = now.toString().substring(11, 19);
    } catch (e) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('kk:mm:ss').format(now);
      horaActual = formattedDate;
    }
  }

  action(int funtion, MarcationModel marca, NotificationModel notification,
      BuildContext context) async {
    PreferenciasUsuario _prefs = PreferenciasUsuario();
    NotiProvider pro = new NotiProvider();
    var resultBarCode = await barcodeScan.resultScanner();
    try {
      if (resultBarCode.exist == true) {
        await getTime();
        String futureString = resultBarCode.lectura;
        marca.marcadoDataQr = futureString;
        marca.marcadoTipo = widget.title;
        marca.marcadoMotivo = widget.title;
        marca.marcadoTiempo = horaActual;
        notification.titulo = widget.title;
        notification.cuerpo =
            'El trabajador ${_prefs.nombreUsuario} ${_prefs.apellido} acaba de marcar su ${widget.title}';
        if (validacionQR(futureString, _prefs.idEmpresa)) {
          String mensaje = await marcationProvider.registrarMarcacionTiempo(
              marca, horaActual);
          if (mensaje == 'correcto') {
            await notificationProvider.registrarNotification(notification);
            if (widget.title == "Ingreso al trabajo") {
              final result = await reporteMarcado.registrarMarcadoReporte(
                  marca.marcadoDni, horaActual);
              print('EL MARCADO DEL REPORTE RESULTO : $result');
              _prefs.idStateWorking = 1; //acá le damos el cambio de estado
              await pro.buscarusuarios(_prefs.dni, notification.cuerpo);
              await homeOfficeService.registrarIngreso();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'tareas', (_) => false);
            } else if (widget.title == "Interrupción") {
              _prefs.idStateWorking = 3;
              await pro.buscarusuarios(_prefs.dni, notification.cuerpo);
              await homeOfficeService.registrarInterrupcion();
              Navigator.pushNamed(context, 'load');
            } else if (widget.title == "Refrigerio") {
              // refriNotificacion(
              //     _prefs.dni, 'Recuerde marcar su fin de Refrigerio');
              final result =
                  await reporteMarcado.actualizarRefrigerioMarcadoReporte(
                      marca.marcadoDni, horaActual);
              print('EL MARCADO DEL REPORTE RESULTO : $result');
              _prefs.idStateWorking = 2;
              _prefs.idLunch = 1;
              Navigator.pushNamed(context, 'load');
            } else if (widget.title == "Fin de Refrigerio") {
              final result =
                  await reporteMarcado.actualizarFinRefrigerioMarcadoReporte(
                      marca.marcadoDni, horaActual);
              print('EL MARCADO DEL REPORTE RESULTO : $result');
              _prefs.idStateWorking = 4;
              Navigator.pushNamed(context, 'load');
            } else if (widget.title == "Regreso al trabajo" &&
                _prefs.idLunch == 0) {
              _prefs.idStateWorking = 1;
              await homeOfficeService.registrarFinInterrupcion();
              Navigator.pushNamed(context, 'load');
            } else if (widget.title == "Regreso al trabajo" &&
                _prefs.idLunch == 1) {
              _prefs.idStateWorking = 4;
              await homeOfficeService.registrarFinInterrupcion();
              Navigator.pushNamed(context, 'load');
            } else if (widget.title == "Fin del Dia") {
              final result = await reporteMarcado
                  .actualizarSalidaMarcadoReporte(marca.marcadoDni, horaActual);
              print('EL MARCADO DEL REPORTE RESULTO : $result');
              _prefs.idStateWorking = 5;
              _prefs.idLunch = 0;
              await homeOfficeService.registrarFinTrabajo();
              Navigator.pushNamed(context, 'load');
            }
          } else {
            util.alertaRegistroMarcacion(context, 'Registro fallido!',
                'Algo salió mal en el registro de la marcación\n$mensaje');
          }
        } else {
          util.alertaRegistroMarcacion(context, 'Algo no está bien',
              'El QR que acaba de leer no es de la empresa');
        }
      } else {
        util.alertaRegistroMarcacion(
            context, 'Error!', 'Algo paso con la lectura del QR');
      }
    } catch (e) {
      util.alertaRegistroMarcacion(
          context, 'Oh no!', 'Algo salio mal intentelo más tarde por favor');
    }
  }
}
