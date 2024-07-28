import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/helper/string_extension.dart';
import 'package:theaware_screen/model/gender.dart';

import 'package:flutter/material.dart';
import 'package:theaware_screen/screen/gender_picker.dart';

import '../../test_main.dart';

void main() {
  final selectedGenderNotifier = ValueNotifier<Gender?>(null);
  final testMain = TestMain(
    home: Scaffold(
      body: CustomScrollView(slivers: [
        GenderPicker(selectedGenderNotifier: selectedGenderNotifier)
      ]),
    ),
  );

  testWidgets('GenderPicker widget test', (WidgetTester tester) async {
    await tester.pumpWidget(testMain);

    for (var gender in Gender.values) {
      expect(find.text(gender.name.splitCamelCaseToString().capitalize()),
          findsOneWidget);
    }

    await tester.tap(
        find.text(Gender.values[0].name.splitCamelCaseToString().capitalize()));
    await tester.pumpAndSettle();

    expect(selectedGenderNotifier.value, Gender.values[0]);

    await tester.tap(
        find.text(Gender.values[1].name.splitCamelCaseToString().capitalize()));
    await tester.pumpAndSettle();

    expect(selectedGenderNotifier.value, Gender.values[1]);
  });
}
