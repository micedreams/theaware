import 'package:flutter/material.dart';
import 'package:theaware_screen/screen/onboarding/header.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../test_main.dart';

void main() {
  final pageNotifier = ValueNotifier<int>(2);

  final testMain = TestMain(
    home: Scaffold(
      body: Header(pageNotifier: pageNotifier),
    ),
  );
  testWidgets('Header widget test', (WidgetTester tester) async {
    await tester.pumpWidget(testMain);

    expect(find.byType(IconButton), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(pageNotifier.value, 1);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
  });
}
