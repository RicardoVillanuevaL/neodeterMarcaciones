import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:neodeter_marcaciones/pages/Login%20y%20Perfil/Perfil_page.dart';
import 'package:neodeter_marcaciones/pages/Marcaciones/BoardHomeOffice.dart';
import 'package:neodeter_marcaciones/pages/Notificaciones/Notifications_page.dart';
import 'package:neodeter_marcaciones/pages/Reportes/Reportes_page.dart';
import 'package:neodeter_marcaciones/pages/Tareas/Appoint_Task.dart';
import 'package:neodeter_marcaciones/preferencias_usuarios/preferencias_usuario.dart';
import 'package:neodeter_marcaciones/provider/providerNoti.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PreferenciasUsuario prefs = new PreferenciasUsuario();
  var tabs = [];
  int cargo;

  @override
  void initState() {
    cargo = 0;
    cargarData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var titlePage = title(cargo);
    return Scaffold(
      appBar: AppBar(
        title: FadeInUp(child: Text(titlePage[_currentIndex])),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PerfilPage()));
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: vistaCargo(_currentIndex, cargo),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: itemsBottomNavigations(cargo),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  cargarData() {
    try {
      setState(() {
        cargo = prefs.cargo;
      });
    } catch (e) {
      setState(() {
        cargo = -1;
      });
    }
  }

  Widget vistaCargo(int current, int cargo) {
    if (cargo == -1) {
      return Center(
          child: Text(
        'COMUNIQUESÉ CON SU JEFE USTED NO CUENTA CON VISTAS DISPONIBLES',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
      ));
    } else if (cargo == 0) {
      return Center(
          child: Column(
        children: [
          CircularProgressIndicator(),
          Text(
            "Loading . . ",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ));
    } else if (cargo == 1) {
      //JEFE
      tabs = [
        BoardHomeOffice(),
        ReportesPage(),
        NotificationPage(),
        AppoinTask()
      ];
      return tabs[_currentIndex];
    } else if (cargo == 2) {
      //TRABAJADOR DE CASA ------------------PRIORIDAD
      tabs = [BoardHomeOffice(), NotificationPage()];
      return tabs[_currentIndex];
    } else if (cargo == 4) {
      //TRABAJADOR DE PLANTA------------------PRIORIDAD
      tabs = [BoardHomeOffice(), NotificationPage()];
      return tabs[_currentIndex];
    }
    return tabs[_currentIndex];
  }

  List<BottomNavigationBarItem> itemsBottomNavigations(int cargo) {
    List<BottomNavigationBarItem> itemsD;
    if (cargo == -1) {
      itemsD = [
        BottomNavigationBarItem(
            icon: Icon(Icons.do_not_disturb_alt),
            label: "Error :(",
            backgroundColor: Colors.red),
      ];
    } else if (cargo == 0) {
      itemsD = [
        BottomNavigationBarItem(
            icon: Icon(Icons.cached),
            label: "Cargando . . . ",
            backgroundColor: Colors.blue),
      ];
    } else if (cargo == 1) {
      itemsD = [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Marcar Ingreso",
            backgroundColor: Colors.green),
        BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file),
            label: "Reportes",
            backgroundColor: Colors.indigo),
        BottomNavigationBarItem(label: 'Notification', icon: bnbItem()),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Tareas",
            backgroundColor: Color(0xFF388E3C)),
      ];
      return itemsD;
    } else if (cargo == 2) {
      itemsD = [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Marcar Ingreso",
            backgroundColor: Colors.green),
        BottomNavigationBarItem(
            icon: bnbItem(),
            label: "Notificaciones",
            backgroundColor: Color(0xFF388E3C)),
      ];
      return itemsD;
    } else if (cargo == 4) {
      itemsD = [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Marcar Ingreso",
            backgroundColor: Colors.green),
        BottomNavigationBarItem(
            icon: bnbItem(),
            label: "Notificaciones",
            backgroundColor: Color(0xFF388E3C)),
      ];
      return itemsD;
    }
    return itemsD;
  }

  List<String> title(int cargo) {
    List<String> titles = [];
    if (cargo == -1) {
      titles = ['Error!'];
    } else if (cargo == 0) {
      titles = ['Cargando . . .'];
    } else if (cargo == 1) {
      titles = [
        "Marcar Asistencia",
        "Reportes",
        "Historial de Notificaciones",
        "Tareas"
      ];
    } else if (cargo == 2) {
      titles = ["Marcar Asistencia", "Historial de Notificaciones"];
    } else if (cargo == 3) {
      titles = [
        "Marcar Asistencia",
        'Marcar Asistencia Grupal',
        "Historial de Notificaciones"
      ];
    } else if (cargo == 4) {
      titles = ["Marcar Asistencia", "Historial de Notificaciones"];
    }
    return titles;
  }

  Widget bnbItem() {
    return context.watch<NotificationPending>().pending
        ? Stack(children: [
            Icon(Icons.notifications_on_outlined),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 12,
                width: 12,
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
            )
          ])
        : Icon(Icons.notifications_on_outlined);
  }
}
