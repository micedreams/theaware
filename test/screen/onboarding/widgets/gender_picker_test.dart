import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/helper/a_constants.dart';
import 'package:theaware_screen/helper/string_extension.dart';
import 'package:theaware_screen/model/gender.dart';
import 'package:theaware_screen/screen/onboarding/widgets/gender_picker.dart';

void main() {
  group('GenderPicker', () {
    testWidgets('renders all gender options', (WidgetTester tester) async {
      // Setup
      final selectedGenderNotifier = ValueNotifier<Gender?>(null);

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GenderPicker(
              selectedGenderNotifier: selectedGenderNotifier,
            ),
          ),
        ),
      );

      // Verify all gender options are rendered
      for (final gender in Gender.values) {
        expect(find.text(gender.name.splitCamelCaseToString().capitalize()),
            findsOneWidget);
      }
    });

    testWidgets('updates selected gender and styles correctly',
        (WidgetTester tester) async {
      // Setup
      final selectedGenderNotifier = ValueNotifier<Gender?>(null);

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GenderPicker(
              selectedGenderNotifier: selectedGenderNotifier,
            ),
          ),
        ),
      );

      // Tap on a gender item
      final genderToSelect = Gender.values[1];
      await tester.tap(
          find.text(genderToSelect.name.splitCamelCaseToString().capitalize()));
      await tester.pump();

      // Verify that the selected gender is updated
      expect(selectedGenderNotifier.value, genderToSelect);

      // Verify that the correct item is styled as selected
      final selectedItemFinder = find.byWidgetPredicate((widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color ==
              AConstants.genderPickerBoxColorActive &&
          (widget.decoration as BoxDecoration).border!.top.color ==
              AConstants.genderPickerBoxBorderColorActive);

      expect(selectedItemFinder, findsOneWidget);

      // Verify that other items are styled as not selected
      for (final gender in Gender.values) {
        if (gender != genderToSelect) {
          final unselectedItemFinder = find.byWidgetPredicate((widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).color ==
                  AConstants.genderPickerBoxColor &&
              (widget.decoration as BoxDecoration).border!.top.color ==
                  AConstants.genderPickerBoxBorderColor);

          expect(unselectedItemFinder,
              findsAtLeastNWidgets(Gender.values.length - 1));
        }
      }
    });

    testWidgets('renders items with correct styles and text',
        (WidgetTester tester) async {
      // Setup
      final selectedGenderNotifier = ValueNotifier<Gender?>(null);

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GenderPicker(
              selectedGenderNotifier: selectedGenderNotifier,
            ),
          ),
        ),
      );

      // Verify item styles
      for (final gender in Gender.values) {
        final itemFinder = find.byWidgetPredicate((widget) =>
            widget is Container &&
            widget.child is Text &&
            (widget.child as Text).data ==
                gender.name.splitCamelCaseToString().capitalize());

        expect(itemFinder, findsOneWidget);

        final container = tester.widget<Container>(itemFinder);
        final decoration = container.decoration as BoxDecoration;

        expect(decoration.color, equals(AConstants.genderPickerBoxColor));
        expect(decoration.border!.top.color,
            equals(AConstants.genderPickerBoxBorderColor));
      }
    });
  });
}
