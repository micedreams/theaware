import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'helper/read_from_file.dart';
import 'helper/theme_data.dart';
import 'model/country_and_states.dart';
import 'screen/home.dart';

final allCountries = <CountryAndStates>[];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  allCountries.addAll(await readFromFile(rootBundle));
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'theaware',
        theme: getThemeData(),
        home: const Home(),
      );
}
