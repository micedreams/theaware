import 'package:flutter/material.dart';

import '../main.dart';
import '../screen/home.dart';
import '../screen/login.dart';
import '../screen/onboarding/onboarding.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/Home':
      return MaterialPageRoute(builder: (_) => Home(config: settings.arguments as HomeConfig));
    case '/Login':
      return MaterialPageRoute(builder: (_) => const Login());
    case '/Onboarding':
      return MaterialPageRoute(
          builder: (_) => Onboarding(allCountries: allCountries));

    default:
      return MaterialPageRoute(builder: (_) => const Login());
  }
}
