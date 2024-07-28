import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/widgets/a_sliver_list.dart';

import '../test_main.dart';

void main() {
  const int childCount = 3;
  final List<String> labels = ['Label 0', 'Label 1', 'Label 2'];
  final List<int> tappedIndexes = [];

  final testMain = TestMain(
    home: Scaffold(
      body: Column(
        children: [
          ASliverList(
            childCount: childCount,
            buildLabel: (index) => labels[index],
            onTap: (index) => tappedIndexes.add(index),
          ),
        ],
      ),
    ),
  );

  testWidgets(
      'ASliverList displays the correct labels and triggers onTap callback',
      (WidgetTester tester) async {
    await tester.pumpWidget(testMain);

    expect(find.byType(ListTile), findsNWidgets(childCount));
    for (int i = 0; i < childCount; i++) {
      expect(find.text(labels[i]), findsOneWidget);
    }

    expect(find.byType(Divider), findsNWidgets(childCount - 1));

    for (int i = 0; i < childCount; i++) {
      await tester.tap(find.text('Label $i'));
      await tester.pump(); // Rebuild the widget
    }

    expect(tappedIndexes, equals(List.generate(childCount, (index) => index)));
  });
}
