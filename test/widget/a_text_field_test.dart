import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/widgets/a_text_field.dart';

void main() {
  group('ATextField', () {
    testWidgets('renders with provided label and controller',
        (WidgetTester tester) async {
      // Setup
      final controller = TextEditingController();
      const label = 'Test Label';

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ATextField(
              label: label,
              controller: controller,
            ),
          ),
        ),
      );

      // Verify the label is rendered
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byWidgetPredicate((widget) {
        return widget is TextField && widget.decoration?.hintText == label;
      }), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      // Setup
      bool tapped = false;
      final controller = TextEditingController();

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ATextField(
              label: 'Test Label',
              controller: controller,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      // Simulate a tap
      await tester.tap(find.byType(TextField));
      await tester.pump();

      // Verify onTap callback is called
      expect(tapped, true);
    });

    testWidgets('is read-only when onTap is provided',
        (WidgetTester tester) async {
      // Setup
      final controller = TextEditingController();

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ATextField(
              label: 'Test Label',
              controller: controller,
              onTap: () {},
            ),
          ),
        ),
      );

      // Verify the TextField is read-only
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.readOnly, true);
    });

    testWidgets('is not read-only when onTap is null',
        (WidgetTester tester) async {
      // Setup
      final controller = TextEditingController();

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ATextField(
              label: 'Test Label',
              controller: controller,
            ),
          ),
        ),
      );

      // Verify the TextField is not read-only
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.readOnly, false);
    });
  });
}
