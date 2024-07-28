import 'package:flutter/material.dart';
import 'package:theaware_screen/helper/theme_data.dart';

class TestMain extends StatelessWidget {
  const TestMain({super.key, required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'theaware',
        theme: getThemeData(),
        home: home,
      );
}
