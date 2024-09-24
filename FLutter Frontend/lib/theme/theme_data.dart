import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      primarySwatch: Colors.amber,
      scaffoldBackgroundColor: Colors.transparent,
      fontFamily: 'Montserrat',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.blue,
        ),
      ));
}
