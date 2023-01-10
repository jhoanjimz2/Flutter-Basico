import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.indigo;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    //Color Primario
    primaryColor: primary,
    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.indigo
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary
    )
  );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    //Color Primario
    primaryColor: primary,
  );
}
