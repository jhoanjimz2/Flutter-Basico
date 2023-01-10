import 'package:flutter/material.dart';

import '../models/rutas_option.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home_design';

  static final rutasOption = <RutasOption>[
    RutasOption(route: 'basic_design', screen: const BasicDesignScreen()),
    RutasOption(route: 'scroll_design', screen: const ScrollDesignScreen()),
    RutasOption(route: 'home_design', screen: const HomeScreen()),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (final option in rutasOption) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const AlertScreen());
  }
}
