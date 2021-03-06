import 'package:animate_do/animate_do.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:intl/intl.dart';
import 'package:neodeter_marcaciones/models/subordinados_model.dart';
import 'package:neodeter_marcaciones/preferencias_usuarios/preferencias_usuario.dart';
import 'package:neodeter_marcaciones/services/subordinados_services.dart';
import 'package:neodeter_marcaciones/services/tareas_services.dart';
import 'package:neodeter_marcaciones/models/tareasModel.dart';

class AppoinTask extends StatelessWidget {
  Widget _listSubordinados() {
    return FutureBuilder(
        future: subordinadosService.listarSubordinados(),
        builder: (BuildContext context,
            AsyncSnapshot<List<SubordinadosModel>> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeInRight(
                      child: cardTrabajador(context, snapshot.data[index]));
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget dialogBoxTareas(BuildContext context, String dni, String nombre) {
    return FutureBuilder(
      future: tareasServices.listarTareas(dni),
      builder:
          (BuildContext context, AsyncSnapshot<List<TareasModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length != 0) {
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  TareasModel tarea = snapshot.data[index];
                  String tarea1 = comprobardata(tarea.tarea1);
                  String tarea2 = comprobardata(tarea.tarea2);
                  String tarea3 = comprobardata(tarea.tarea3);
                  String fecha = comprobardata(DateFormat(
                    'dd-MM-yyyy',
                  ).format(tarea.fecha));
                  return CustomDialog(
                      tarea1: tarea1,
                      tarea2: tarea2,
                      tarea3: tarea3,
                      nombre: nombre,
                      fecha: fecha,
                      dni: dni);
                });
          } else {
            return CustomDialog(
              tarea1: ' ',
              tarea2: ' ',
              tarea3: ' ',
              nombre: nombre,
              fecha: ' ',
              dni: dni,
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget cardTrabajador(BuildContext context, SubordinadosModel model) {
    String nombre = nombreCard(model);
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => dialogBoxTareas(
                  context, model.empleadoDni, model.empleadoNombre));
        },
        child: Card(
          margin: EdgeInsets.all(5.0),
          elevation: 4.0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                          height: 60,
                          child: Image.asset('assets/logos/gil-men.png')),
                    ),
                    FittedBox(
                      child: Text(nombre,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  String nombreCard(SubordinadosModel model) {
    String nombreCompleto = '';
    try {
      var text_1 = model.empleadoApellido.split(' ');
      nombreCompleto = '${model.empleadoNombre}  ${text_1[0]}';
    } catch (e) {
      nombreCompleto = '${model.empleadoNombre} ${model.empleadoApellido}';
    }
    return nombreCompleto;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: _listSubordinados(),
      ),
    );
  }
}

String comprobardata(String texto) {
  String result;
  try {
    if (texto.isNotEmpty || texto.length > 1) {
      result = texto;
    }
  } catch (e) {
    result = ' ';
  }
  return result;
}

void showDefaultSnackbar(BuildContext context, String tarea, String title) {
  Flushbar(
    title: title,
    message: tarea,
    icon: Icon(
      Icons.info_outline,
      size: 28,
      color: Colors.red,
    ),
    leftBarIndicatorColor: Colors.green.shade300,
    duration: Duration(seconds: 5),
  )..show(context);
}

//POP UP DIALOG BOX BELOW
class CustomDialog extends StatefulWidget {
  final String tarea1, tarea2, tarea3, nombre, fecha, dni;
  CustomDialog(
      {this.tarea1,
      this.tarea2,
      this.tarea3,
      this.nombre,
      this.fecha,
      this.dni});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  int cont = 0;
  String tarea1, tarea2, tarea3, nombre, fecha, dni;

  TareasModel model = new TareasModel();

  final _prefs = new PreferenciasUsuario();

  final _formKey = GlobalKey<FormState>();

  final format = new DateFormat("dd-MM-yyyy");

  String texto = '';

  bool ver = false;

  @override
  void initState() {
    tarea1 = this.widget.tarea1;
    tarea2 = this.widget.tarea2;
    tarea3 = this.widget.tarea3;
    nombre = this.widget.nombre;
    fecha = this.widget.fecha;
    dni = this.widget.dni;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          backgroundColor: Colors.transparent,
          child: Form(key: _formKey, child: dialogContent(context))
          //dialogContent(context),
          ),
    );
  }

  itemTarea1(String item) {
    if (item != ' ') {
      return Column(
        children: <Widget>[
          Text('Tarea 1',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(item, style: TextStyle(fontSize: 16)),
        ],
      );
    } else {
      cont++;
      return TextFormField(
        obscureText: false,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Tarea 1',
            fillColor: Color(0xfff3f3f4),
            filled: true),
        onChanged: (value) => model.tarea1 = value,
      );
    }
  }

  itemTarea2(String item) {
    if (item != ' ') {
      return Column(
        children: <Widget>[
          Text('Tarea 2',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(item, style: TextStyle(fontSize: 16)),
        ],
      );
    } else {
      cont++;
      return TextFormField(
        obscureText: false,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Tarea 2',
            fillColor: Color(0xfff3f3f4),
            filled: true),
        onChanged: (value) => model.tarea2 = value,
      );
    }
  }

  itemTarea3(String item) {
    if (item != ' ') {
      return Column(
        children: <Widget>[
          Text('Tarea 3',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(item, style: TextStyle(fontSize: 16))
        ],
      );
    } else {
      cont++;
      return TextFormField(
        obscureText: false,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Tarea 3',
            fillColor: Color(0xfff3f3f4),
            filled: true),
        onChanged: (value) => model.tarea3 = value,
      );
    }
  }

  listTareas() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Fecha',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(
              width: 200,
              alignment: Alignment.center,
              child: fechaPicker(widget.fecha)),
          SizedBox(height: 10.0),
          itemTarea1(widget.tarea1),
          SizedBox(height: 15.0),
          itemTarea2(widget.tarea2),
          SizedBox(height: 15.0),
          itemTarea3(widget.tarea3),
          Text(
            texto,
            style: TextStyle(color: Colors.red),
          )
        ],
      ),
    );
  }

  String titleCount() {
    String result;
    if (cont == 0) {
      result = 'Cerrar';
    } else if (cont == 3) {
      result = 'Registrar';
    } else {
      result = 'Actualizar';
    }
    return result;
  }

  Widget fechaPicker(String data) {
    if (data != ' ') {
      return Text(
        data,
        style: TextStyle(fontSize: 16),
      );
    } else {
      return DateTimeField(
        initialValue: DateTime.now(),
        format: format,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.calendar_today,
            size: 27.0,
            color: Colors.blue,
          ),
          labelText: 'Fecha',
          hintText: 'Fecha de la Tarea',
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0)),
        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              initialDate: currentValue ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));
        },
        onChanged: (value) => model.fecha = value,
      );
    }
  }

  dialogContent(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
              padding:
                  EdgeInsets.only(top: 100, bottom: 16, left: 16, right: 16),
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    )
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Tareas de ${widget.nombre}',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  listTareas(),
                  SizedBox(height: 24.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(color: Colors.blue)),
                      onPressed: () async {
                        if (cont == 0) {
                          //result = 'Cerrar';
                        } else if (cont == 3) {
                          if (_formKey.currentState.validate()) {
                            //result = 'Registrar';
                            //print(model.fecha);
                            if (model.fecha == null) {
                              model.fecha = DateTime.now();
                            }
                            model.jefe = _prefs.dni;
                            model.trabajador = widget.dni;
                            await tareasServices.registrarTask(model);
                          }
                        } else {
                          //result = 'Actualizar';
                          Navigator.pop(context);
                        }
                        Navigator.pop(context);
                      },
                      child: Text(titleCount()),
                    ),
                  )
                ],
              )),
          Positioned(
              top: 0,
              left: 16,
              right: 16,
              child: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 50,
                child: Container(
                  child: Image.asset('assets/logos/job.png'),
                ),
              ))
        ],
      ),
    );
  }

  void showDefaultSnackbar(BuildContext context, String tarea, String title) {
    Flushbar(
      title: title,
      message: tarea,
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.red,
      ),
      leftBarIndicatorColor: Colors.green.shade300,
      duration: Duration(seconds: 5),
    )..show(context);
  }
}
