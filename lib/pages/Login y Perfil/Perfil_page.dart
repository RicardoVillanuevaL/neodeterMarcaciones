import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:neodeter_marcaciones/models/PerfilModel.dart';
import 'package:neodeter_marcaciones/preferencias_usuarios/preferencias_usuario.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final prefs = PreferenciasUsuario();
  int stateView;
  PerfilModel model = PerfilModel();

  @override
  void initState() {
    stateView = 0;
    cargarDatos();
    super.initState();
  }

  cargarDatos() {
    model.empleadoNombre = prefs.nombreUsuario;
    model.empleadoDni = prefs.dni;
    model.empleadoApellido = prefs.apellido;
    model.empleadoTelefono = prefs.telefono;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: informacionPerfil(context, model, size));
  }

  informacionPerfil(BuildContext context, PerfilModel model, Size size) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FadeInDown(
                child: fotoPerfil(size.width - 200),
              ),
              FadeInLeft(
                child: textInfo(model.empleadoDni, 'DNI'),
              ),
              FadeInRight(
                child: textInfo(model.empleadoNombre, 'Nombre'),
              ),
              FadeInLeft(
                child: textInfo(model.empleadoApellido, 'Apellido'),
              ),
              FadeInRight(
                child: textInfo(model.empleadoTelefono, 'Telefono'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  fotoPerfil(double ancho) {
    final _random = new Random();
    int next(int min, int max) => min + _random.nextInt(max - min);
    return Container(
      child: Image.asset(
        randomRuta(next(1, 7)),
        width: ancho,
      ),
    );
  }

  String randomRuta(int number) {
    List<String> listaImagenes = [];
    listaImagenes.add('assets/logos/nigga-men.png');
    listaImagenes.add('assets/logos/nigga-women.png');
    listaImagenes.add('assets/logos/old-men.png');
    listaImagenes.add('assets/logos/men.png');
    listaImagenes.add('assets/logos/woman.png');
    listaImagenes.add('assets/logos/white-women.png');
    listaImagenes.add('assets/logos/gil-men.png');
    print(listaImagenes[number]);
    return listaImagenes[number];
  }

  textInfo(String data, String tipo) {
    return ListTile(
      title: Text(
        data,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      ),
      subtitle: Text(tipo,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green[300],
              fontSize: 14)),
    );
  }
}
