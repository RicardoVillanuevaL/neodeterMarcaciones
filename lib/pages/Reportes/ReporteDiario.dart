import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:neodeter_marcaciones/models/subordinados_model.dart';
import 'package:neodeter_marcaciones/services/subordinados_services.dart';

class ReporteDiario extends StatefulWidget {
  ReporteDiario({Key key}) : super(key: key);

  @override
  _ReporteDiarioState createState() => _ReporteDiarioState();
}

class _ReporteDiarioState extends State<ReporteDiario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FadeInUp(
            child: Text('Lista de Subordinados'),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: futureList(),
        ));
  }

  futureList() {
    return FutureBuilder(
        future: subordinadosService.listarSubordinados(),
        builder: (BuildContext context,
            AsyncSnapshot<List<SubordinadosModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return listarReportes(snapshot.data);
          }
        });
  }

  Widget listarReportes(List<SubordinadosModel> subordinados) {
    return ListView.builder(
        itemCount: subordinados.length,
        itemBuilder: (BuildContext context, int i) {
          return FadeInRight(
            child: ListTile(
              title: Text(
                  '${subordinados[i].empleadoApellido}, ${subordinados[i].empleadoNombre}',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, 'reporteSubor',
                    arguments: subordinados[i]);
              },
            ),
          );
        });
  }
}
