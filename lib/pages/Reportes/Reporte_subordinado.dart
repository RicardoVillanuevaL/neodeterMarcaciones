import 'package:flutter/material.dart';
import 'package:neodeter_marcaciones/models/VerMarcacionesModel.dart';
import 'package:neodeter_marcaciones/models/subordinados_model.dart';
import 'package:neodeter_marcaciones/services/subordinados_services.dart';

class ReporteSubordinadoPage extends StatefulWidget {
  ReporteSubordinadoPage({Key key}) : super(key: key);

  @override
  _ReporteSubordinadoPageState createState() => _ReporteSubordinadoPageState();
}

class _ReporteSubordinadoPageState extends State<ReporteSubordinadoPage> {
  _ReporteSubordinadoPageState createState() => _ReporteSubordinadoPageState();
  DateTime _dateTime;
  bool ver = false;
  @override
  Widget build(BuildContext context) {
    SubordinadosModel subordinado = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Reporte del Subordinado')),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.assignment_ind,
              size: 35.0,
            ),
            title: Text(
                '${subordinado.empleadoApellido}, ${subordinado.empleadoNombre}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            trailing: Text('${subordinado.empleadoDni}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          _calendario(),
          SizedBox(height: 10.0),
          ver ? _marcaciones(subordinado) : Container(),
        ],
      ),
    );
  }

  Widget _calendario() {
    return ElevatedButton(
      child: Text(
          _dateTime == null
              ? 'Seleccionar fecha'
              : '${_dateTime.year} - ${_dateTime.month} - ${_dateTime.day}',
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold)),
      onPressed: () {
        final year = DateTime.now().year;
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2001),
                lastDate: DateTime(year + 1))
            .then((date) {
          _dateTime = date;
          ver = true;
          setState(() {});
        });
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))),
    );
  }

  Widget _marcaciones(SubordinadosModel subordi) {
    return FutureBuilder(
        future: subordinadosService.listarMarcaciones(
            subordi.empleadoDni, _dateTime),
        builder: (BuildContext context,
            AsyncSnapshot<List<VerMarcacionesModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _listarMarcaciones(snapshot.data);
          }
        });
  }

  Widget _listarMarcaciones(List<VerMarcacionesModel> listMarcaiones) {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listMarcaiones.length,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
              title: Text('${listMarcaiones[i].marcadoTipo}'),
              trailing: Text('${listMarcaiones[i].marcadoTiempo}'),
            );
          }),
    );
  }
}
