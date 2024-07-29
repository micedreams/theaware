import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/screen/onboarding/widgets/onboarding_progress_bar.dart';

void main() {
  group('OnboardingProgressBar', () {
    late VoidCallback onBack;
    late double progressBar;

    setUp(() {
      onBack = () {}; // Dummy callback function
      progressBar = 100.0;
    });

    testWidgets('renders initial state correctly', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnboardingProgressBar(
              onBack: onBack,
              progressBar: progressBar,
            ),
          ),
        ),
      );

      // Verify initial UI components
      expect(find.byType(Divider), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
    });

    testWidgets('progress bar width updates with progressBar value',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnboardingProgressBar(
              onBack: onBack,
              progressBar: progressBar,
            ),
          ),
        ),
      );

      // Verify initial progress bar width
      final initialDivider = tester.widget<Divider>(find.byType(Divider));
      final initialEndIndent = initialDivider.endIndent;

      // Update progressBar value
      progressBar = 50.0;

      // Rebuild the widget with updated progressBar value
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnboardingProgressBar(
              onBack: onBack,
              progressBar: progressBar,
            ),
          ),
        ),
      );

      // Verify updated progress bar width
      final updatedDivider = tester.widget<Divider>(find.byType(Divider));
      final updatedEndIndent = updatedDivider.endIndent;

      expect(updatedEndIndent, isNot(equals(initialEndIndent)));
    });

    testWidgets('back button triggers onBack callback',
        (WidgetTester tester) async {
      bool backButtonPressed = false;
      onBack = () {
        backButtonPressed = true;
      };

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnboardingProgressBar(
              onBack: onBack,
              progressBar: progressBar,
            ),
          ),
        ),
      );

      // Simulate tapping the back button
      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pump(); // Rebuild the widget to reflect changes

      // Verify onBack callback was triggered
      expect(backButtonPressed, isTrue);
    });
  });
}
