import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neodeter_marcaciones/models/NotificationModel.dart';
import 'package:animate_do/animate_do.dart';

class MyDetailPage extends StatefulWidget {
  final NotificationModel _model;

  MyDetailPage(this._model);

  @override
  _MyDetailPageState createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  NotificationModel model;

  @override
  Widget build(BuildContext context) {
    model = this.widget._model;
    var fechaHora = model.fechahora.split('T');
    DateTime f = DateTime.parse(fechaHora[0]);
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String fechaLimpia = dateFormat.format(f).toString();
    String horaLimpia = fechaHora[1].substring(0, 5);

    return Scaffold(
      appBar: AppBar(
        title: Text(model.titulo),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FadeInLeft(
                      child: Container(
                        alignment: Alignment.center,
                        height: 100.0,
                        width: 100.0,
                        child: Image.asset("assets/logos/message.png"),
                      ),
                    ),
                    FadeInRight(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            FittedBox(
                              child: Text(
                                'Fecha : $fechaLimpia',
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10),
                            FittedBox(
                              child: Text(
                                'Hora : $horaLimpia',
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ZoomIn(
                  child: Text(
                    'Contenido de la notificación',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF388E3C),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                FadeInUp(
                  child: Card(
                      elevation: 8,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Titulo',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(model.titulo,
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18.0,
                                )),
                            SizedBox(height: 10),
                            Text('Cuerpo',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(model.cuerpo,
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18.0,
                                )),
                          ],
                        ),
                      )),
                ),
                SizedBox(height: 100),
              ],
            ),
          )),
    );
  }
}
