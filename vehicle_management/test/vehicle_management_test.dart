import 'package:test/test.dart';
import 'package:vehicle_management/vehicle_management.dart';

void main() {
  group('Vehicle & Car OOP Tests', () {
    test('Vehicle base class khá»Ÿi táº¡o thuá»™c tÃ­nh Ä‘Ãºng', () {
      final v = Vehicle('Honda', 2020);
      expect(v.brand, equals('Honda'));
      expect(v.year, equals(2020));
    });

    test('Car káº¿ thá»«a Vehicle vá»›i constructor máº·c Ä‘á»‹nh', () {
      final car = Car('Toyota', 2021, isElectric: false);
      expect(car.brand, equals('Toyota'));
      expect(car.year, equals(2021));
      expect(car.isElectric, isFalse);
      expect(car, isA<Vehicle>());
    });

    test('Car.tesla named constructor tá»± Ä‘á»™ng gÃ¡n brand=Tesla vÃ  isElectric=true', () {
      final tesla = Car.tesla(2024);
      expect(tesla.brand, equals('Tesla'));
      expect(tesla.year, equals(2024));
      expect(tesla.isElectric, isTrue);
      expect(tesla, isA<Vehicle>());
    });
  });
}
