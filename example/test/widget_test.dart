import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:use_state_utils_example/main.dart'; // Needed for stream testing

void main() {
  testWidgets('DemoPage smoke test', (WidgetTester tester) async {
    // Render the DemoPage
    await tester.pumpWidget(const MaterialApp(home: DemoPage()));

    // Verify some basic elements
    expect(find.text('UseStateMixin Demo'), findsOneWidget);
    expect(find.text('Fade Transition'), findsOneWidget);
    expect(find.text('Timer count: 0'), findsOneWidget);
  });

  testWidgets('DemoPage toggles animation', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DemoPage()));

    final button = find.text('Toggle Animation');
    expect(find.byKey(const Key('background')), findsOneWidget);
    expect(
        (tester.firstWidget(find.byKey(const Key('background'))) as Material)
            .color,
        Colors.cyan);

    // Tap the button
    await tester.tap(button);
    await tester.pump();

    expect(
        (tester.firstWidget(find.byKey(const Key('background'))) as Material)
            .color,
        Colors.deepOrange);

    // Tap again to reverse
    await tester.tap(button);
    await tester.pump();

    expect(
        (tester.firstWidget(find.byKey(const Key('background'))) as Material)
            .color,
        Colors.cyan);

    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('DemoPage increments counter', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DemoPage()));

    expect(find.text('Timer count: 0'), findsOneWidget);

    // Wait for a second (timer updates counter)
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Timer count: 1'), findsOneWidget);
  });
}
