import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/model/country_and_states.dart';
import 'package:theaware_screen/screen/place_picker.dart';
import 'package:theaware_screen/widgets/a_text_field.dart';

import '../../test_main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final countryController = TextEditingController();
  final stateController = TextEditingController();

  final widget = TestMain(
    home: PlacePicker(
        stateController: stateController,
        countryController: countryController,
        allCountries: [
          CountryAndStates(country: 'India', states: ['Delhi', 'Karnataka']),
          CountryAndStates(country: 'USA', states: ['California', 'Texas']),
        ]),
  );

  group('PlacePicker', () {
    testWidgets('PlacePicker displays country and state fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      // Verify that both the country and state fields are displayed
      expect(find.byType(ATextField), findsNWidgets(2));
      expect(find.text('Country'), findsOneWidget);
      expect(find.text('State'), findsOneWidget);
    });

    testWidgets('PlacePicker updates state field on state selection',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      // Input text into the country field
      await tester.enterText(find.byType(TextField).first, 'United States');
      await tester.pump();

      // Tap on the country option
      await tester.tap(find.text('United States'));
      await tester.pump();

      // Input text into the state field
      await tester.enterText(find.byType(TextField).at(1), 'California');
      await tester.pump();

      // Tap on the state option
      await tester.tap(find.text('California'));
      await tester.pump();

      // Verify that the state field is updated
      expect(stateController.text, 'California');
    });

    testWidgets('PlacePicker filters countries based on input',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      final countryFieldFinder = find.byKey(const Key('Country'));
      expect(countryFieldFinder, findsOneWidget);

      final countryField = tester.widget<TextField>(countryFieldFinder);

      await tester.enterText(countryFieldFinder, 'India');
      expect(countryField.controller?.text, 'India');

      await tester.tap(countryFieldFinder);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final countryListFinder = find.byKey(const Key('filteredCountries'));
      expect(countryListFinder, findsOneWidget);

      expect(find.text('Canada'), findsNothing);

      expect(find.text('India'), findsAtLeastNWidgets(1));
    });

    testWidgets('PlacePicker updates state options based on selected country',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      // Input text into the country field
      await tester.enterText(find.byType(TextField).first, 'USA');
      await tester.pump();

      // Tap on the country option
      await tester.tap(find.text('USA').last);
      await tester.pump(const Duration(seconds: 2));

      // Verify that the state options are displayed
      expect(find.text('California'), findsOneWidget);
      expect(find.text('New York'), findsNothing);
    });
  });
}
