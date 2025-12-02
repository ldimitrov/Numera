// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:numera/main.dart';

void main() {
  testWidgets('Calculator smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NumeraApp());

    // Verify that the text field is present.
    expect(find.text('Type math here...'), findsOneWidget);

    // Enter some text.
    await tester.enterText(find.byType(TextField), '2 + 2');
    await tester.pump();

    // Verify that the result is displayed.
    expect(find.text('4'), findsOneWidget);
  });
}
