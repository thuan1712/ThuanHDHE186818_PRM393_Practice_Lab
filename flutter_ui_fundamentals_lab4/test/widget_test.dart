import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_fundamentals_lab4/main.dart';

void main() {
  testWidgets('Lab 4 Home Screen renders all 5 exercises', (WidgetTester tester) async {
    await tester.pumpWidget(const Lab4App());

    expect(find.text('Lab 4 – Flutter UI Fundamentals'), findsOneWidget);
    expect(find.text('Exercise 1 – Core Widgets Demo'), findsOneWidget);
    expect(find.text('Exercise 2 – Input Controls Demo'), findsOneWidget);
    expect(find.text('Exercise 3 – Layout Demo'), findsOneWidget);
    expect(find.text('Exercise 4 – App Structure & Theme'), findsOneWidget);
    expect(find.text('Exercise 5 – Common UI Fixes'), findsOneWidget);
  });

  testWidgets('Navigate to Exercise 1', (WidgetTester tester) async {
    await tester.pumpWidget(const Lab4App());

    await tester.tap(find.text('Exercise 1 – Core Widgets Demo'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Flutter UI'), findsOneWidget);
    expect(find.text('Movie Item'), findsOneWidget);
  });

  testWidgets('Navigate to Exercise 3 Layout Demo', (WidgetTester tester) async {
    await tester.pumpWidget(const Lab4App());

    await tester.tap(find.text('Exercise 3 – Layout Demo'));
    await tester.pumpAndSettle();

    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Avatar'), findsOneWidget);
  });
}
