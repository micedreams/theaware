import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theaware_screen/widgets/a_text_field.dart';

import '../test_main.dart';

void main() {
  final TextEditingController controller = TextEditingController();

  final testMain = TestMain(
      home: Scaffold(
    body: ATextField(label: 'Name', controller: controller),
  ));
  testWidgets('AaiTextField has a label and reacts to input',
      (WidgetTester tester) async {
    await tester.pumpWidget(testMain);

    // Verify the label is displayed.
    expect(find.text('Name'), findsOneWidget);

    // Enter text into the TextField.
    await tester.enterText(find.byType(TextField), 'John Doe');
    expect(controller.text, 'John Doe');
  });
}
