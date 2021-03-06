import 'package:flutter/material.dart';

class ReporteWeek extends StatefulWidget {
  ReporteWeek({Key key}) : super(key: key);

  @override
  _ReporteWeekState createState() => _ReporteWeekState();
}

class _ReporteWeekState extends State<ReporteWeek> {
  List<String> ingreso;
  List<String> refrigerio;
  List<String> retorno;
  List<String> salida;

  @override
  void initState() {
    ingreso = [];
    refrigerio = [];
    retorno = [];
    salida = [];
    consultarHoras();
    super.initState();
  }

  consultarHoras() {
    ingreso.add('I');
    ingreso.add('09:00'); //L
    ingreso.add('09:00'); //M
    ingreso.add('09:00'); //M
    ingreso.add('09:00'); //J
    ingreso.add('09:00'); //V
    ingreso.add('09:00'); //S
    refrigerio.add('R');
    refrigerio.add('13:00'); //L
    refrigerio.add('13:00'); //M
    refrigerio.add('13:00'); //M
    refrigerio.add('13:00'); //J
    refrigerio.add('13:00'); //V
    refrigerio.add('13:00'); //S
    retorno.add('R');
    retorno.add('14:00'); //L
    retorno.add('14:00'); //M
    retorno.add('14:00'); //M
    retorno.add('14:00'); //J
    retorno.add('14:00'); //V
    retorno.add('14:00'); //S
    salida.add('S');
    salida.add('18:00'); //L
    salida.add('18:00'); //M
    salida.add('18:00'); //M
    salida.add('18:00'); //J
    salida.add('18:00'); //V
    salida.add('18:00'); //S
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              tablaSemanal(ingreso, refrigerio, retorno, salida),
              Text('Horas total semanales : 48 h'),
            ],
          ),
        ),
      ),
    ));
  }

  timeContain(String tiempo) {
    return Container(
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Text(tiempo, textAlign: TextAlign.center),
    );
  }

  tablaSemanal(List<String> listIngreso, List<String> listRefrigerio,
      List<String> listRetorno, List<String> listSalida) {
    return Table(border: TableBorder.all(color: Colors.black), children: [
      TableRow(children: [
        CircleAvatar(child: Icon(Icons.weekend)),
        Container(child: CircleAvatar(child: Text('L'))),
        Container(child: CircleAvatar(child: Text('M'))),
        Container(child: CircleAvatar(child: Text('M'))),
        Container(child: CircleAvatar(child: Text('J'))),
        Container(child: CircleAvatar(child: Text('V'))),
        Container(child: CircleAvatar(child: Text('S'))),
      ]),
      TableRow(children: [
        CircleAvatar(child: Text(listIngreso[0])),
        timeContain(listIngreso[1]),
        timeContain(listIngreso[2]),
        timeContain(listIngreso[3]),
        timeContain(listIngreso[4]),
        timeContain(listIngreso[5]),
        timeContain(listIngreso[6]),
      ]),
      TableRow(children: [
        CircleAvatar(child: Text(listRefrigerio[0])),
        timeContain(listRefrigerio[1]),
        timeContain(listRefrigerio[2]),
        timeContain(listRefrigerio[3]),
        timeContain(listRefrigerio[4]),
        timeContain(listRefrigerio[5]),
        timeContain(listRefrigerio[6]),
      ]),
      TableRow(children: [
        CircleAvatar(child: Text(listRetorno[0])),
        timeContain(listRetorno[1]),
        timeContain(listRetorno[2]),
        timeContain(listRetorno[3]),
        timeContain(listRetorno[4]),
        timeContain(listRetorno[5]),
        timeContain(listRetorno[6]),
      ]),
      TableRow(children: [
        CircleAvatar(child: Text(listSalida[0])),
        timeContain(listSalida[1]),
        timeContain(listSalida[2]),
        timeContain(listSalida[3]),
        timeContain(listSalida[4]),
        timeContain(listSalida[5]),
        timeContain(listSalida[6]),
      ]),
    ]);
  }
}
