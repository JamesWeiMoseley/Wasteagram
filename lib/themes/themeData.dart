import 'package:flutter/material.dart';

class AppTheme {
  ThemeData buildThemeData() {
    return ThemeData(
        primarySwatch: Colors.yellow, //bottom bar
        primaryColor: Colors.limeAccent[400], //appbar
        accentColor: Colors.yellow, //button

        textTheme: TextTheme(
          subtitle1: TextStyle(
              fontSize: 24.0,
              color: Colors.green[400],
              fontWeight: FontWeight.bold), //title
          caption: TextStyle(fontSize: 2.0, color: Colors.red), //subtitle
          bodyText2: TextStyle(
            fontSize: 30.0,
            // color: Colors.greenAccent[400]
          ), //trailing and normal text
        ));
  }
}
