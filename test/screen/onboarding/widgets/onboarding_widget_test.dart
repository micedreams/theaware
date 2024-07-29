import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/screen/onboarding/widgets/onboarding_progress_bar.dart';
import 'package:theaware_screen/screen/onboarding/widgets/onboarding_widget.dart';
import 'package:theaware_screen/widgets/a_button.dart';

void main() {
  group('OnboardingWidget', () {
    late ValueNotifier<int> pageNotifier;
    late String title;
    late String subtitle;
    late Widget child;
    late VoidCallback? onSkip;

    setUp(() {
      pageNotifier = ValueNotifier<int>(1);
      title = 'Test Title';
      subtitle = 'Test Subtitle';
      child = const Text('Test Child');
      onSkip = () {}; // Dummy callback function
    });

    testWidgets('renders initial state correctly', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnboardingWidget(
              pageNotifier: pageNotifier,
              title: title,
              subtitle: subtitle,
              onSkip: onSkip,
              showNext: true,
              child: child,
            ),
          ),
        ),
      );

      // Verify initial UI components
      expect(find.text(title), findsOneWidget);
      expect(find.text(subtitle), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);
      expect(find.byType(OnboardingProgressBar), findsOneWidget);
      expect(find.byType(AButton), findsNWidgets(2)); // Next and Skip buttons
    });

    testWidgets('back button triggers goToLastPage', (WidgetTester tester) async {
      pageNotifier.value = 2;

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnboardingWidget(
              pageNotifier: pageNotifier,
              title: title,
              subtitle: subtitle,
              onSkip: onSkip,
              showNext: true,
              child: child,
            ),
          ),
        ),
      );

      // Simulate tapping the back button
      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pump(); // Rebuild the widget to reflect changes

      // Verify pageNotifier value decreased
      expect(pageNotifier.value, 1);
    });

    testWidgets('next button triggers goToNextPage', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnboardingWidget(
              pageNotifier: pageNotifier,
              title: title,
              subtitle: subtitle,
              onSkip: onSkip,
              showNext: true,
              child: child,
            ),
          ),
        ),
      );

      // Simulate tapping the next button
      await tester.tap(find.text('Next'));
      await tester.pump(); // Rebuild the widget to reflect changes

      // Verify pageNotifier value increased
      expect(pageNotifier.value, 2);
    });

    testWidgets('skip button triggers onSkip callback', (WidgetTester tester) async {
      bool skipButtonPressed = false;
      onSkip = () {
        skipButtonPressed = true;
      };

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnboardingWidget(
              pageNotifier: pageNotifier,
              title: title,
              subtitle: subtitle,
              onSkip: onSkip,
              showNext: true,
              child: child,
            ),
          ),
        ),
      );

      // Simulate tapping the skip button
      await tester.tap(find.text('Skip'));
      await tester.pump(); // Rebuild the widget to reflect changes

      // Verify onSkip callback was triggered
      expect(skipButtonPressed, isTrue);
    });

    testWidgets('displays disabled next button when showNext is false', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnboardingWidget(
              pageNotifier: pageNotifier,
              title: title,
              subtitle: subtitle,
              onSkip: onSkip,
              showNext: false,
              child: child,
            ),
          ),
        ),
      );

      // Verify next button is disabled
      expect(find.text('Next'), findsOneWidget);
      expect(find.byKey(const Key('disabledButton')), findsOneWidget);
    });
  });
}
