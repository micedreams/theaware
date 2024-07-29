import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/widgets/a_button.dart';

void main() {
  group('AButton', () {
    testWidgets('renders with correct label and style',
        (WidgetTester tester) async {
      // Setup
      const label = 'Test Button';
      const backgroundColor = Color(0xff27AE60);
      const labelColor = Color(0xffffffff);

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AButton(
              label: label,
              backGroundColor: backgroundColor,
              labelColor: labelColor,
              onTap: () {},
            ),
          ),
        ),
      );

      // Verify the button displays the correct label
      expect(find.text(label), findsOneWidget);

      // Verify the button's text color
      final textFinder = find.byWidgetPredicate((widget) =>
          widget is Text &&
          widget.data == label &&
          widget.style?.color == labelColor);

      expect(textFinder, findsOneWidget);

      // Verify the button's background color
      final containerFinder = find.byWidgetPredicate((widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == backgroundColor);

      expect(containerFinder, findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      // Setup
      bool tapped = false;

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AButton(
              label: 'Test Button',
              backGroundColor: Color(0xff27AE60),
              labelColor: Color(0xffffffff),
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      // Simulate a tap
      await tester.tap(find.byType(AButton));
      await tester.pump();

      // Verify onTap callback is called
      expect(tapped, true);
    });

    testWidgets('renders primary button with correct colors',
        (WidgetTester tester) async {
      // Setup
      const label = 'Primary Button';
      const backgroundColor = Color(0xff27AE60);
      const labelColor = Color(0xffffffff);

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AButton.primary(
              label: label,
              onTap: () {},
            ),
          ),
        ),
      );

      // Verify the button's background and label color
      final buttonFinder = find.byWidgetPredicate((widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == backgroundColor);

      expect(buttonFinder, findsOneWidget);

      final textFinder = find.byWidgetPredicate((widget) =>
          widget is Text &&
          widget.data == label &&
          widget.style?.color == labelColor);

      expect(textFinder, findsOneWidget);
    });

    testWidgets('renders secondary button with correct colors',
        (WidgetTester tester) async {
      // Setup
      const label = 'Secondary Button';
      const backgroundColor = Color(0xffF2F2F5);
      const labelColor = Color(0xff3A3A3C);

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AButton.secondary(
              label: label,
              onTap: () {},
            ),
          ),
        ),
      );

      // Verify the button's background and label color
      final buttonFinder = find.byWidgetPredicate((widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == backgroundColor);

      expect(buttonFinder, findsOneWidget);

      final textFinder = find.byWidgetPredicate((widget) =>
          widget is Text &&
          widget.data == label &&
          widget.style?.color == labelColor);

      expect(textFinder, findsOneWidget);
    });

    testWidgets('renders disabled button with correct colors',
        (WidgetTester tester) async {
      // Setup
      const label = 'Disabled Button';
      const backgroundColor = Color(0xffE3E3E3);
      const labelColor = Color(0xffffffff);

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AButton.disabled(
              label: label,
            ),
          ),
        ),
      );

      // Verify the button's background and label color
      final buttonFinder = find.byWidgetPredicate((widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == backgroundColor);

      expect(buttonFinder, findsOneWidget);

      final textFinder = find.byWidgetPredicate((widget) =>
          widget is Text &&
          widget.data == label &&
          widget.style?.color == labelColor);

      expect(textFinder, findsOneWidget);
    });
  });
}
