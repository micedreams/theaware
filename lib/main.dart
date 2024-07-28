import 'package:flutter/material.dart';

import 'helper/theme_data.dart';
import 'screen/home.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'theaware',
        theme: themeData(),
        home: const Home(),
      );
}

