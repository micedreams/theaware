import 'package:flutter_test/flutter_test.dart';

import 'package:theaware_screen/screen/home.dart';

import '../test_main.dart';

void main() {
  const testMain = TestMain(home: Home());

  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(testMain);

    expect(find.text('hi'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
