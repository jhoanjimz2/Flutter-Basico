import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = LoginScreen.routerName;

  static final rutasOption = <RutasOption>[
    RutasOption(route: CheckAuthScreen.routerName, screen: const CheckAuthScreen()),
    RutasOption(route: HomeScreen.routerName, screen: const HomeScreen()),
    RutasOption(route: LoginScreen.routerName, screen: const LoginScreen()),
    RutasOption(route: ProductScreen.routerName, screen: const ProductScreen()),
    RutasOption(route: LoadingScreen.routerName, screen: const LoadingScreen()),
    RutasOption(route: RegisterScreen.routerName, screen: const RegisterScreen()),
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
