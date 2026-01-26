// This is a basic Flutter widget test.

import 'package:flutter_test/flutter_test.dart';

import 'package:memory_palace/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MemoryPalaceApp());

    // Verify that loading screen appears
    expect(find.text('기억의 궁전'), findsOneWidget);
  });
}
