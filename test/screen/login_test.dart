import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/screen/login.dart';
import 'package:theaware_screen/widgets/a_button.dart'; // Adjust the import based on your project structure

void main() {
  testWidgets('Login widget test', (WidgetTester tester) async {
    // Build the Login widget
    await tester.pumpWidget(
      MaterialApp(
        home: const Login(),
        routes: {
          '/Onboarding': (context) =>
              const Scaffold(), // Mock route for navigation
        },
      ),
    );

    // Verify that the welcome text is present
    expect(find.text('Welcome'), findsOneWidget);

    // Verify that the description texts are present
    expect(
        find.text(
            'Mirror is your compass on the journey of personal development.'),
        findsOneWidget);
    expect(
        find.text(
            'Reflect on experiences, gain insightful perspectives, and walk the path of self-discovery with awareness.'),
        findsOneWidget);

    // Verify that the buttons are present and have the correct labels
    expect(
        find.widgetWithText(AButton, 'Continue with Google'), findsOneWidget);
    expect(find.widgetWithText(AButton, 'Continue with Apple'), findsOneWidget);

    // Tap the Google button and verify navigation
    await tester.tap(find.widgetWithText(AButton, 'Continue with Google'));
    await tester.pumpAndSettle(); // Wait for navigation

    // Check if the navigation happened to the '/Onboarding' route
    expect(find.byType(Scaffold),
        findsOneWidget); // Assuming the /Onboarding route has a Scaffold
  });
}
