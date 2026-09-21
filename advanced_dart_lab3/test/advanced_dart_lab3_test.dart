import 'package:advanced_dart_lab3/advanced_dart_lab3.dart';
import 'package:test/test.dart';

void main() {
  group('Lab 3 Unit Tests', () {
    test('Exercise 1: ProductRepository Future và Stream', () async {
      final repo = ProductRepository();
      final initial = await repo.getAll();
      expect(initial.length, equals(2));

      final newProduct = Product(id: 99, name: 'Test Product', price: 99.0);
      expectLater(repo.liveAdded(), emits(newProduct));

      repo.addProduct(newProduct);
      repo.dispose();
    });

    test('Exercise 2: User JSON Deserialization', () async {
      final repo = UserRepository();
      final users = await repo.fetchUsers();
      expect(users.isNotEmpty, isTrue);
      expect(users.first.name, equals('Hoang Duc Thuan'));
    });

    test('Exercise 4: Stream Transformation (map x^2 & where even)', () async {
      final source = Stream.fromIterable([1, 2, 3, 4, 5]);
      final transformed = transformNumbers(source);
      final result = await transformed.toList();
      // 1^2=1 (odd), 2^2=4 (even), 3^2=9 (odd), 4^2=16 (even), 5^2=25 (odd)
      expect(result, equals([4, 16]));
    });

    test('Exercise 5: Factory Constructor Singleton Pattern', () {
      final s1 = Settings();
      final s2 = Settings();
      expect(identical(s1, s2), isTrue);
    });
  });
}
