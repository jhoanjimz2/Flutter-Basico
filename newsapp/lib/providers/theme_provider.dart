

import 'package:newsapp/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  
  
  ThemeData currentTheme;
  ThemeProvider({
    required bool isDarkmode
  }): currentTheme = isDarkmode ? AppTheme.darkTheme : AppTheme.lightTheme;


  setLightMode() {
    currentTheme = AppTheme.lightTheme; 
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = AppTheme.darkTheme; 
    notifyListeners();
  }


  /* 
  FUNCION PARA UTILIZAR EL CAMBIO DE TEMA EN LA APLICACION
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  value ? themeProvider.setDarkMode() : themeProvider.setLightMode();
  setState(() {}); 
  */

}