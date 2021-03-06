import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    new Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(context,'home',(_)=>false);
    });
    return Center(child: CircularProgressIndicator(),
    );
  }
}
