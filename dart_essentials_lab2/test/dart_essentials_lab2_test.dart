import 'package:dart_essentials_lab2/dart_essentials_lab2.dart';
import 'package:test/test.dart';

void main() {
  group('Lab 2 Unit Tests', () {
    test('Exercise 3: Hàm tính toán calcSum và multiplyByTwo', () {
      expect(calcSum(10, 25), equals(35));
      expect(multiplyByTwo(8), equals(16));
    });

    test('Exercise 4: Lớp Car và Named Constructor Car.unknown()', () {
      final car = Car('Toyota');
      expect(car.brand, equals('Toyota'));

      final genericCar = Car.unknown();
      expect(genericCar.brand, equals('Generic Brand'));
    });

    test('Exercise 4: Lớp con ElectricCar kế thừa và thêm thuộc tính', () {
      final ev = ElectricCar('Tesla Model 3', 75);
      expect(ev.brand, equals('Tesla Model 3'));
      expect(ev.batteryCapacity, equals(75));
      expect(ev, isA<Car>());
    });

    test('Exercise 5: Stream phát ra các giá trị tuần tự', () async {
      final stream = generateStream(3);
      final list = await stream.toList();
      expect(list, equals([1, 2, 3]));
    });
  });
}
