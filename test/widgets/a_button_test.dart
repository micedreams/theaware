import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/widgets/a_button.dart';

import '../test_main.dart';

void main() {
  const primary = 'Primary Button';
  const secondary = 'Secondary Button';
  const disabled = 'Disabled Button';
  bool tapped = false;

  onTap(){}

  final primaryButton = AButton.primary(label: primary, onTap: onTap);
  final secondaryButton = AButton.secondary(label: secondary, onTap: onTap);
  final disabledButton = AButton.disabled(label: disabled);
  final primaryButtonTapped =
      AButton.primary(label: primary, onTap: () => tapped = true);

  testMain(button) => TestMain(home: Scaffold(body: button));
  group('AButton Widget Tests', () {
    testWidgets('renders primary button with correct label and colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(testMain(primaryButton));

      final buttonFinder = find.text(primary);
      expect(buttonFinder, findsOneWidget);

      final inkWell = tester.widget<InkWell>(find.byType(InkWell));
      final container = tester.widget<Container>((find.byType(Container)));

      expect(inkWell.onTap, equals(onTap));
      expect(
          container.decoration,
          equals(
            BoxDecoration(
              color: const Color(0xff27AE60),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ));
      final text = tester.widget<Text>(find.text(primary));
      expect(text.style!.color, equals(const Color(0xffffffff)));
    });

    testWidgets('renders secondary button with correct label and colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(testMain(secondaryButton));

      final buttonFinder = find.text(secondary);
      expect(buttonFinder, findsOneWidget);

      final inkWell = tester.widget<InkWell>(find.byType(InkWell));
      final container = tester.widget<Container>((find.byType(Container)));

      expect(inkWell.onTap, equals(onTap));
      expect(
          container.decoration,
          equals(
            BoxDecoration(
              color: const Color(0xffF2F2F5),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ));
      final text = tester.widget<Text>(find.text(secondary));
      expect(text.style!.color, equals(const Color(0xff3A3A3C)));
    });

    testWidgets('renders disabled button with correct label and colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(testMain(disabledButton));

      final buttonFinder = find.text(disabled);
      expect(buttonFinder, findsOneWidget);

      final inkWell = tester.widget<InkWell>(find.byType(InkWell));
      final container = tester.widget<Container>((find.byType(Container)));

      expect(inkWell.onTap, isNull);
      expect(
          container.decoration,
          equals(
            BoxDecoration(
              color: const Color(0xffE3E3E3),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ));
      final text = tester.widget<Text>(find.text(disabled));
      expect(text.style!.color, equals(const Color(0xffffffff)));
    });

    testWidgets('calls onTap when primary button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(testMain(primaryButtonTapped));

      await tester.tap(find.text(primary));
      expect(tapped, isTrue);
    });
  });
}
