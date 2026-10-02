import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_lab5/main.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = TestHttpOverrides();
  });

  testWidgets('Home Screen displays movie list and search bar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MovieDetailApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Verify app bar title
    expect(find.text('Movies'), findsOneWidget);

    // Verify search bar
    expect(find.byType(TextField), findsOneWidget);

    // Verify movies from sample data
    expect(find.text('Dune: Part Two'), findsOneWidget);
    expect(find.text('Deadpool & Wolverine'), findsOneWidget);
  });

  testWidgets('Tapping a movie card navigates to MovieDetailScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MovieDetailApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Tap on Dune: Part Two
    await tester.tap(find.text('Dune: Part Two'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Verify Detail screen widgets
    expect(find.text('Trailers'), findsOneWidget);
    expect(find.text('Favorite'), findsOneWidget);
    expect(find.text('Rate'), findsOneWidget);
    expect(find.text('Share'), findsOneWidget);
    expect(find.text('Sci-Fi'), findsOneWidget);

    // Tap back button
    await tester.tap(find.byType(BackButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Verify returned to Home screen
    expect(find.text('Movies'), findsOneWidget);
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
