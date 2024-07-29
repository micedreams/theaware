import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/model/country_and_states.dart';
import 'package:theaware_screen/screen/onboarding/widgets/place_picker.dart';
import 'package:theaware_screen/widgets/a_sliver_list.dart';
import 'package:theaware_screen/widgets/a_text_field.dart';

void main() {
  group('PlacePicker', () {
    late TextEditingController stateController;
    late TextEditingController countryController;
    late List<CountryAndStates> allCountries;

    setUp(() {
      stateController = TextEditingController();
      countryController = TextEditingController();
      allCountries = [
        CountryAndStates(country: 'India', states: ['Delhi', 'Karnataka']),
        CountryAndStates(country: 'USA', states: ['California', 'Texas']),
      ];
    });

    testWidgets('renders initial state correctly', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlacePicker(
              stateController: stateController,
              countryController: countryController,
              allCountries: allCountries,
            ),
          ),
        ),
      );

      // Verify initial UI components
      expect(find.byType(ATextField),
          findsNWidgets(2)); // Country and State ATextField
      expect(find.byType(ASliverList),
          findsNothing); // No countries or states listed initially
    });

    testWidgets('filters countries based on input',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlacePicker(
              stateController: stateController,
              countryController: countryController,
              allCountries: allCountries,
            ),
          ),
        ),
      );

      // Simulate user input to filter countries
      countryController.text = 'India';
      await tester.pump(); // Rebuild the widget to reflect changes

      // Verify filtered countries are displayed
      expect(find.text('India'), findsAtLeast(2));
      expect(find.text('USA'), findsNothing);
    });

    testWidgets('filters states based on selected country',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlacePicker(
              stateController: stateController,
              countryController: countryController,
              allCountries: allCountries,
            ),
          ),
        ),
      );

      // Simulate user input to filter countries and select one
      countryController.text = 'India';
      await tester.pump(); // Rebuild the widget to reflect changes
      await tester.tap(find.text('India').last);
      await tester.pump(); // Rebuild the widget to reflect changes

      // Verify filtered states are displayed
      expect(find.text('Delhi'), findsOneWidget);
      expect(find.text('Karnataka'), findsOneWidget);
      expect(find.text('California'), findsNothing);
      expect(find.text('Texas'), findsNothing);
    });

    testWidgets('updates state controller on state selection',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlacePicker(
              stateController: stateController,
              countryController: countryController,
              allCountries: allCountries,
            ),
          ),
        ),
      );

      // Simulate user input to filter countries and select one
      countryController.text = 'India';
      await tester.pump(); // Rebuild the widget to reflect changes
      await tester.tap(find.text('India').last);
      await tester.pump(); // Rebuild the widget to reflect changes

      // Tap on a state
      await tester.tap(find.text('Delhi'));
      await tester.pump(); // Rebuild the widget to reflect changes

      // Verify the state controller text is updated
      expect(stateController.text, 'Delhi');
    });
  });
}
