import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neodeter_marcaciones/pages/Login%20y%20Perfil/HelperLogin_page.dart';
import 'package:neodeter_marcaciones/services/login/login.dart';
import 'package:neodeter_marcaciones/utilities/contants.dart';
import 'package:flutter/cupertino.dart';
import 'package:neodeter_marcaciones/services/util/notificaciones_util.dart'
    as dialog;

class LoginPage extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  Login log = new Login();
  var email = TextEditingController();
  var contra = TextEditingController();
  var _isFetching = false;
  bool obscure;

  @override
  void initState() {
    obscure = true;
    super.initState();
  }

  widgetBuildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Ingrese su Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        )
      ],
    );
  }

  widgetBuildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Contraseña',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: contra,
                  obscureText: obscure,
                  style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      hintText: 'Ingrese su contraseña',
                      hintStyle: kHintTextStyle),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  color: obscure ? Colors.black : Colors.white,
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  })
            ],
          ),
        )
      ],
    );
  }

  widgetBuildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (email.text.isNotEmpty && contra.text.isNotEmpty) {
            if (_isFetching) return;
            setState(() {
              _isFetching = true;
            });
            print(email.text + " " + contra.text);

            final resp = await log.login(email.text, contra.text);
            print(resp);

            if (resp['ok']) {
              setState(() {
                _isFetching = false;
              });
              //_mensaje(context, resp['mensaje']);
              dialog.alertWaitDialog(context, 'Bienvenido',
                  '${resp['mensaje']}', 'assets/logos/connectionSuccess.png');
              await Future.delayed(Duration(seconds: 3));
              Navigator.pop(context);
              //Navigator.pushNamedAndRemoveUntil(context, 'videocall', (_)=>false);
              Navigator.pushNamed(context, 'splash');
            } else {
              setState(() {
                _isFetching = false;
              });
              dialog.alertaImagen(context, 'Oh no!', '${resp['mensaje']}',
                  'assets/logos/connectionError.png');
              //_mensaje(context, resp['mensaje']);
            }
          } else {
            dialog.alertaImagen(
                context,
                'Datos imcompletos',
                'Por favor digite su correo y su contraseña.\nEn caso de no recordarlos o no saber si esta registrado, toqué en Ayuda.',
                'assets/logos/connectionError.png');
          }
        },
        style: ElevatedButton.styleFrom(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            primary: Colors.white,
            padding: EdgeInsets.all(15.0)),
        child: Text(
          'INGRESAR',
          style: TextStyle(
            color: Color(0xFF43A047),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget rememberAcount() {
    final color1 = Colors.white;
    return Column(
      children: [
        Divider(
          color: color1,
          height: 2,
          indent: 20,
          endIndent: 20,
        ),
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                '¿Tiene problemas al ingresar?',
                style: TextStyle(color: color1, fontSize: 18),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HelperLoginPage())),
              child: FittedBox(
                child: Text(
                  'Ayuda',
                  style: TextStyle(
                      color: color1, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF43A047),
                      Color(0xFF66BB6A),
                      Color(0xFF4CAF50),
                      Color(0xFF388E3C),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Tower & Tower S.A',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      widgetBuildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      widgetBuildPasswordTF(),
                      widgetBuildLoginBtn(),
                      rememberAcount(),
                    ],
                  ),
                ),
              ),
              _isFetching
                  ? Positioned.fill(
                      child: Container(
                      color: Colors.black45,
                      child: Center(
                        child: CupertinoActivityIndicator(
                          radius: 15,
                        ),
                      ),
                    ))
                  : Container(),
//aqui va
            ],
          ),
        ),
      ),
    );
  }
}
