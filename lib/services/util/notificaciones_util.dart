import 'package:animate_do/animate_do.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mostraralerta(BuildContext context, String header, String mensaje) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(header),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}

showInfoFlushbar(
    BuildContext context, String title, String message, Color color) {
  Flushbar(
    title: title,
    message: message,
    icon: Icon(
      Icons.info_outline,
      size: 28,
      color: color,
    ),
    leftBarIndicatorColor: color,
    duration: Duration(seconds: 3),
  )..show(context);
}

alertaRegistroMarcacion(BuildContext context, String title, String mensaje) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Column(
            children: [
              Container(
                child: Image.asset('assets/logos/connectionError.png'),
                height: 50,
                margin: EdgeInsets.only(top: 20, bottom: 20),
              ),
              Text(mensaje),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok'),
            )
          ],
        );
      });
}

alertaImagen(
    BuildContext context, String title, String mensaje, String imagen) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Column(
            children: [
              Container(
                child: Image.asset(imagen),
                height: 50,
                margin: EdgeInsets.only(top: 20, bottom: 20),
              ),
              Text(mensaje),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok'),
            )
          ],
        );
      });
}

alertWaitDialog(
    BuildContext context, String title, String mensaje, String image) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return FadeInUp(
          child: CupertinoAlertDialog(
            title: Text(title),
            content: Column(
              children: [
                Container(
                  child: Image.asset(image),
                  height: 50,
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                ),
                Text(mensaje),
              ],
            ),
          ),
        );
      });
  // en el codigo donde lo llamas le agregas
  // await Future.delayed(Duration(seconds: 3));
  // Navigator.pop(context);
}

mostraralerta2(BuildContext context, String header, String mensaje) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(header),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}

mostraralertaMetodo(BuildContext context, String header, String mensaje,
    VoidCallback onPressed) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(header),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(onPressed: () => onPressed, child: Text('Ok'))
          ],
        );
      });
}

mostrarAlertaVacia(String tittle) {
  return Center(
      child: Card(
    elevation: 5.0,
    child: Container(
        width: 300.0,
        height: 200.0,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.red,
              size: 50.0,
            ),
            SizedBox(height: 20.0),
            Text(tittle),
          ],
        ))),
  ));
}
