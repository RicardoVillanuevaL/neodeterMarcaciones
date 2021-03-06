import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neodeter_marcaciones/pages/Reportes/ReporteDiario.dart';
import 'package:neodeter_marcaciones/pages/Reportes/Reporte_Week.dart';

class ReportesPage extends StatefulWidget {
  @override
  _ReportesPageState createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BotonCard('Reporte Diario', 'assets/logos/day reporte.png', 0),
            BotonCard('Reporte Semanal', 'assets/logos/work-schedule.png', 1)
          ],
        ),
      ),
    );
  }
}

class BotonCard extends StatelessWidget {
  final String texto;
  final String image;
  final int action;
  BotonCard(this.texto, this.image, this.action);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ruteador(context, action),
      child: Container(
        width: 300,
        height: 200,
        margin: EdgeInsets.symmetric(vertical: 30),
        child: FadeInDown(
          child: Card(
            elevation: 10,
            shadowColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(image),
                  height: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  this.texto,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ruteador(BuildContext context, int route) async {
    switch (route) {
      case 0:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => ReporteDiario()));
        break;
      case 1:
        // util.alertWaitDialog(context, 'En progreso', 'Esta opción aun falta terminar . . . ',
        //       'assets/logos/enProgreso.png');
        //   await Future.delayed(Duration(seconds: 2));
        //   Navigator.pop(context);
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => ReporteWeek()));
        break;
      default:
    }
  }
}
