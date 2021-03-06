import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neodeter_marcaciones/services/login/login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _authApi = Login();

  @override
  void initState() {
    super.initState();
    this.check();
  }

  check() async {
    final token = await _authApi.getAccessToken();
    if (token != null) {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (_) => false);
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(
            radius: 15,
          ),
        ),
      ),
    );
  }
}
