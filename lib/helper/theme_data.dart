import 'package:flutter/material.dart';

import 'a_constants.dart';

ThemeData getThemeData() => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff05A660)),
      useMaterial3: true,
      dividerColor: AConstants.dividerColor,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AConstants.inputDecorationThemeFillColor,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AConstants.inputDecorationThemeborderColor,
          ),
          borderRadius: BorderRadius.circular(
            AConstants.inputDecorationThemeborderRadius,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AConstants.inputDecorationThemeborderFocusedColor,
          ),
          borderRadius: BorderRadius.circular(
            AConstants.inputDecorationThemeborderRadius,
          ),
        ),
      ),
    );
