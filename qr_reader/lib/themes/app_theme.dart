import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.deepPurple;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    //Color Primario
    primaryColor: primary,
    //AppBarTheme
    appBarTheme: const AppBarTheme(
      color: primary,
    ),
    //floatingActionButtonTheme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
    ),
    //BottomNavigationBarTheme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primary,
    ),
  );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    //Color Primario
    primaryColor: primary,
    //AppBarTheme
    appBarTheme: const AppBarTheme(
      color: primary,
    ),
    scaffoldBackgroundColor: Colors.black,
  );
}
