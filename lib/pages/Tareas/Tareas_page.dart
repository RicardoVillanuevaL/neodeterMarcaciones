import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neodeter_marcaciones/models/tareasModel.dart';
import 'package:neodeter_marcaciones/services/tareas_services.dart';
import 'package:neodeter_marcaciones/preferencias_usuarios/preferencias_usuario.dart';

class TareasPage extends StatefulWidget {
  @override
  _TareasPageState createState() => _TareasPageState();
}

class _TareasPageState extends State<TareasPage> {
  final _prefs = new PreferenciasUsuario();

  String fecha = DateTime.now().toString();

  final _formKey = GlobalKey<FormState>();

  TareasModel model = new TareasModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas Pendientes $fecha'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _crearLista(_prefs.dni, _prefs.dnijefe, _formKey, model),
      ),
    );
  }
}

String comprobarNull(String cadena) {
  if (cadena == null) {
    return cadena = ' ';
  } else {
    return cadena;
  }
}

Widget _crearLista(String dni, String jefe, Key _formKey, TareasModel model) {
  return FutureBuilder(
    future: tareasServices.listarTareas(dni),
    builder: (BuildContext context, AsyncSnapshot<List<TareasModel>> snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data.length != 0) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              TareasModel asd = new TareasModel();
              asd = snapshot.data[index];
              asd.tarea1 = (comprobarNull(asd.tarea1));
              asd.tarea2 = (comprobarNull(asd.tarea2));
              asd.tarea3 = (comprobarNull(asd.tarea3));
              return card(context, asd);
            },
          );
        } else {
          return ingreseTareas(context, _formKey, model, dni, jefe);
        }
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

Widget ingreseTareas(BuildContext context, Key _formKey, TareasModel model,
    String dni, String jefe) {
  return Form(
    key: _formKey,
    child: SingleChildScrollView(
      child: Column(children: <Widget>[
        Text('Ingrese sus Tareas de hoy',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 25.0,
        ),
        TextFormField(
          obscureText: false,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.note_add),
              border: InputBorder.none,
              hintText: 'Tarea 1',
              fillColor: Color(0xfff3f3f4),
              filled: true),
          onChanged: (value) => model.tarea1 = value,
        ),
        SizedBox(
          height: 15.0,
        ),
        TextFormField(
          obscureText: false,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.note_add),
              border: InputBorder.none,
              hintText: 'Tarea 2',
              fillColor: Color(0xfff3f3f4),
              filled: true),
          onChanged: (value) => model.tarea2 = value,
        ),
        SizedBox(
          height: 15.0,
        ),
        TextFormField(
          obscureText: false,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.note_add),
              border: InputBorder.none,
              hintText: 'Tarea 3',
              fillColor: Color(0xfff3f3f4),
              filled: true),
          onChanged: (value) => model.tarea3 = value,
        ),
        SizedBox(
          height: 15.0,
        ),
        ElevatedButton.icon(
          icon: Icon(
            Icons.add_circle,
            color: Colors.white,
          ),
          onPressed: () async {
            if (model.tarea1 != null &&
                model.tarea2 != null &&
                model.tarea3 != null) {
              model.fecha = DateTime.now();
              model.trabajador = dni;
              model.jefe = jefe;
              await tareasServices.registrarTask(model);
              Navigator.pushNamedAndRemoveUntil(context, 'home', (_) => false);
            } else {
              showDefaultSnackbar(context, 'Alerta',
                  'Necesita completar sus 3 tareas diarias', false);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
            primary: Color(0xFF43A047),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
          ),
          label: Text(
            'Registrar',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ]),
    ),
  );
}

Widget itemTarea(BuildContext context, String tarea, int i) {
  if (tarea != ' ') {
    return GestureDetector(
      onTap: () {
        showDefaultSnackbar(context, tarea, 'Tarea $i', true);
      },
      child: Card(
          margin: EdgeInsets.all(6),
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Tarea $i',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        tarea,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.navigate_next, color: Colors.black38),
              ],
            ),
          )),
    );
  } else {
    return SizedBox(
      height: 10,
    );
  }
}

void showDefaultSnackbar(
    BuildContext context, String tarea, String title, bool go) {
  if (go) {
    Navigator.pushNamedAndRemoveUntil(context, 'home', (_) => false);
  }
  Flushbar(
    title: title,
    message: tarea,
    icon: Icon(
      Icons.info_outline,
      size: 28,
      color: Colors.green.shade300,
    ),
    leftBarIndicatorColor: Colors.green.shade300,
    duration: Duration(seconds: 5),
  )..show(context);
}

Widget card(BuildContext context, TareasModel model) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      itemTarea(context, model.tarea1, 1),
      itemTarea(context, model.tarea2, 2),
      itemTarea(context, model.tarea3, 3),
    ],
  );
}
