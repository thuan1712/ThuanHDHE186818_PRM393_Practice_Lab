import 'package:ex1_6/ex1_6.dart';
import 'package:test/test.dart';

void main() {
  group('Bài 1.6 (Ex1.6) - Null Safety & Factory Constructor Tests', () {
    test('User.fromJson với dữ liệu đầy đủ', () {
      final json = {"id": 1, "name": "Nam", "email": "nam@fpt.edu.vn"};
      final user = User.fromJson(json);

      expect(user.id, equals(1));
      expect(user.name, equals('Nam'));
      expect(user.email, equals('nam@fpt.edu.vn'));
    });

    test('User.fromJson với name null sẽ fallback về "Khách"', () {
      final json = {"id": 2, "name": null, "email": "test@fpt.edu.vn"};
      final user = User.fromJson(json);

      expect(user.id, equals(2));
      expect(user.name, equals('Khách'));
      expect(user.email, equals('test@fpt.edu.vn'));
    });

    test('User.fromJson với email null được xử lý an toàn', () {
      final json = {"id": 3, "name": "Thuan", "email": null};
      final user = User.fromJson(json);

      expect(user.id, equals(3));
      expect(user.name, equals('Thuan'));
      expect(user.email, isNull);
    });
  });
}
