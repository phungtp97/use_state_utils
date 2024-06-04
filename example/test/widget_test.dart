// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:use_state_utils_example/main.dart';

void main() {
  testWidgets('Integration Test for UseStateMixin', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    // Trigger the animation
    await tester.tap(find.text('Start Animation'));
    await tester.pumpAndSettle();

    // Test that the animation started
    final FadeTransition fadeTransition = tester.widget(find.byType(FadeTransition));
    expect(fadeTransition.opacity.value, greaterThan(0));

    // Send data through the stream
    await tester.tap(find.text('Send Stream Data'));
    await tester.pumpAndSettle();

    // Verify the alert dialog is shown with the correct text
    expect(find.text('Stream Alert'), findsOneWidget);
    expect(find.text('Stream sent: 99'), findsOneWidget);

    // Dismiss the dialog
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verify timer increases
    expect(find.text('Timer count: 1'), findsOneWidget);
    // You may need to wait more than one second or mock the timer to properly test this.
  });
}
