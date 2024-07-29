import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:theaware_screen/model/country_and_states.dart';
import 'package:theaware_screen/screen/onboarding/onboarding.dart';
import 'package:theaware_screen/screen/onboarding/widgets/gender_picker.dart';
import 'package:theaware_screen/screen/onboarding/widgets/place_picker.dart';
import 'package:theaware_screen/widgets/a_text_field.dart';

void main() {
  group('Onboarding', () {
    late List<CountryAndStates> allCountries;

    setUp(() {
      allCountries = [
        CountryAndStates(country: 'India', states: ['Delhi', 'Karnataka']),
        CountryAndStates(country: 'USA', states: ['California', 'Texas']),
      ];
    });

    testWidgets('displays the first onboarding page correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Onboarding(allCountries: allCountries),
        ),
      );

      expect(find.text('What should we call you?'), findsOneWidget);
      expect(
          find.text(
              "Pick a pen name, or use your real one, it's your adventure!"),
          findsOneWidget);
      expect(find.byType(ATextField), findsOneWidget);
    });

    testWidgets(
        'navigates to the second page on next button tap when name is entered',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Onboarding(allCountries: allCountries),
        ),
      );

      await tester.enterText(find.byType(ATextField), 'John Doe');
      await tester.pump();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('When’s your birthday?'), findsOneWidget);
      expect(
          find.text(
              "Just a little info to help us tailor your experience. No time travel required!"),
          findsOneWidget);
      expect(find.byType(ATextField), findsOneWidget);
    });

    testWidgets('opens date picker and sets date correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Onboarding(allCountries: allCountries),
        ),
      );

      await tester.enterText(find.byType(ATextField), 'John Doe');
      await tester.pump();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('When’s your birthday?'), findsOneWidget);

      await tester.tap(find.byType(ATextField));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pump();

      final selectedDate = DateFormat('d MMM yyyy').format(DateTime.now());
      expect(find.text(selectedDate), findsOneWidget);
    });

    testWidgets('navigates to the third page on next button tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Onboarding(allCountries: allCountries),
        ),
      );

      await tester.enterText(find.byType(ATextField), 'John Doe');
      await tester.pump();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('What gender do you identify with?'), findsOneWidget);
      expect(find.text('We celebrate diversity and respect your identity.'),
          findsOneWidget);
      expect(find.byType(GenderPicker), findsOneWidget);
    });

    testWidgets('navigates to the fourth page on next button tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Onboarding(allCountries: allCountries),
        ),
      );

      await tester.enterText(find.byType(ATextField), 'John Doe');
      await tester.pump();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Where are you from?'), findsOneWidget);
      expect(
          find.text(
              "Setting the scene for your story. Which part of the world are you joining us from?"),
          findsOneWidget);
      expect(find.byType(PlacePicker), findsOneWidget);
    });

    testWidgets('skips the current page when skip button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Onboarding(allCountries: allCountries),
        ),
      );

      await tester.enterText(find.byType(ATextField), 'John Doe');
      await tester.pump();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      expect(find.text('What gender do you identify with?'), findsOneWidget);
    });

    testWidgets('navigates back to the previous page on back button tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Onboarding(allCountries: allCountries),
        ),
      );

      await tester.enterText(find.byType(ATextField), 'John Doe');
      await tester.pump();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pumpAndSettle();

      expect(find.text('What should we call you?'), findsOneWidget);
    });
  });
}
