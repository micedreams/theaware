import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/widgets/a_sliver_list.dart';

void main() {
  group('ASliverList', () {
    testWidgets('renders with the correct number of children',
        (WidgetTester tester) async {
      // Setup
      const int childCount = 3;
      final List<String> labels =
          List.generate(childCount, (index) => 'Item $index');

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ASliverList(
                  childCount: childCount,
                  buildLabel: (index) => labels[index],
                  onTap: (_) {},
                ),
              ],
            ),
          ),
        ),
      );

      // Verify the number of items
      expect(find.byType(Text), findsNWidgets(childCount));
    });

    testWidgets('displays the correct labels', (WidgetTester tester) async {
      // Setup
      const int childCount = 2;
      final List<String> labels = ['First Item', 'Second Item'];

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ASliverList(
                  childCount: childCount,
                  buildLabel: (index) => labels[index],
                  onTap: (_) {},
                ),
              ],
            ),
          ),
        ),
      );

      // Verify labels
      for (var i = 0; i < childCount; i++) {
        expect(find.text(labels[i]), findsOneWidget);
      }
    });

    testWidgets('calls onTap with correct index when tapped',
        (WidgetTester tester) async {
      // Setup
      const int childCount = 2;
      int tappedIndex = -1;

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ASliverList(
                  childCount: childCount,
                  buildLabel: (index) => 'Item $index',
                  onTap: (index) {
                    tappedIndex = index;
                  },
                ),
              ],
            ),
          ),
        ),
      );

      // Tap the first item
      await tester.tap(find.text('Item 0'));
      await tester.pump();

      // Verify onTap callback was called with the correct index
      expect(tappedIndex, 0);

      // Tap the second item
      await tester.tap(find.text('Item 1'));
      await tester.pump();

      // Verify onTap callback was called with the correct index
      expect(tappedIndex, 1);
    });

    testWidgets('shows dividers between items', (WidgetTester tester) async {
      // Setup
      const int childCount = 2;

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ASliverList(
                  childCount: childCount,
                  buildLabel: (index) => 'Item $index',
                  onTap: (_) {},
                ),
              ],
            ),
          ),
        ),
      );

      // Verify dividers between items
      expect(find.byType(Divider), findsNWidgets(childCount - 1));
    });
  });
}
