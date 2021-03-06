import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neodeter_marcaciones/models/NotificationModel.dart';
import 'package:neodeter_marcaciones/pages/Notificaciones/Notification_Detail.dart';
import 'package:neodeter_marcaciones/services/notification_services.dart';

class NotificationPage extends StatelessWidget {
  Widget _crearLista() {
    return FutureBuilder(
      future: notificationProvider.listarNotificaciones(),
      builder: (BuildContext context,
          AsyncSnapshot<List<NotificationModel>> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return FadeInLeft(
                  child: cardNotification(context, snapshot.data[index]));
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget cardNotification(BuildContext context, NotificationModel model) {
    var fechaHora = model.fechahora.split('T');
    DateTime f = DateTime.parse(fechaHora[0]);
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String fechaLimpia = dateFormat.format(f).toString();
    String tituloNotificacion = '${model.titulo} / $fechaLimpia';
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyDetailPage(model)));
        },
        child: Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              tituloNotificacion,
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(Icons.mail_outline),
            trailing: Icon(Icons.navigate_next),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: _crearLista(),
      ),
    );
  }
}
