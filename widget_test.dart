import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_counter_app/main.dart';

void main() {
  testWidgets('Counter starts at 0', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });

  testWidgets('Increment button increases the counter',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('Decrement is disabled at 0 and works afterwards',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    IconButton decrementButton() =>
        tester.widget<IconButton>(find.widgetWithIcon(IconButton, Icons.remove));

    expect(decrementButton().onPressed, isNull);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(decrementButton().onPressed, isNotNull);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('Reset sets the counter back to 0', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    for (var i = 0; i < 3; i++) {
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
    }
    expect(find.text('3'), findsOneWidget);

    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
    expect(find.text('3'), findsNothing);
  });
}
