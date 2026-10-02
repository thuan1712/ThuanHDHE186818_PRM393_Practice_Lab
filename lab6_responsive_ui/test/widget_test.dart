import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab6_responsive_ui/main.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = TestHttpOverrides();
  });

  testWidgets('GenreScreen renders heading, search bar, genre chips and movies',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ResponsiveMovieApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify Title
    expect(find.text('Find a Movie'), findsOneWidget);

    // Verify Search bar
    expect(find.byType(TextField), findsOneWidget);

    // Verify Genre chips
    expect(find.widgetWithText(FilterChip, 'Action'), findsOneWidget);
    expect(find.widgetWithText(FilterChip, 'Drama'), findsOneWidget);
    expect(find.widgetWithText(FilterChip, 'Sci-Fi'), findsOneWidget);

    // Verify sample movies rendered on screen
    expect(find.text('Dune: Part Two'), findsOneWidget);
    expect(find.text('Deadpool & Wolverine'), findsOneWidget);
  });

  testWidgets('Filtering by search query updates movie list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ResponsiveMovieApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Type "Dune" into search bar
    await tester.enterText(find.byType(TextField), 'Dune');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Should find Dune, but not Oppenheimer
    expect(find.text('Dune: Part Two'), findsOneWidget);
    expect(find.text('Oppenheimer'), findsNothing);
  });

  testWidgets('Tapping genre chip filters movies by genre',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ResponsiveMovieApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Tap on Animation chip
    await tester.tap(find.widgetWithText(FilterChip, 'Animation'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Spider-Man & Spirited Away are Animation
    expect(find.text('Spider-Man: Across the Spider-Verse'), findsOneWidget);
    expect(find.text('Spirited Away'), findsOneWidget);
    expect(find.text('Oppenheimer'), findsNothing);
  });

  testWidgets('Wide viewport adapts to 2-column GridView',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ResponsiveMovieApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Should find GridView in tablet/web mode
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Tablet (2 Cột)'), findsOneWidget);
  });
}

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _MockHttpClient();
  }
}

class _MockHttpClient implements HttpClient {
  @override
  bool autoUncompress = false;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _MockHttpClientRequest();

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _MockHttpClientRequest implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async => _MockHttpClientResponse();

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _MockHttpClientResponse implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => _transparentImage.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.value(_transparentImage).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

final Uint8List _transparentImage = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
  0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
  0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
  0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
  0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42,
  0x60, 0x82,
]);
