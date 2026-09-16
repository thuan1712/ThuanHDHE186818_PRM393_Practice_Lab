import 'dart:async';

/// Lớp cơ sở Car
class Car {
  String brand;

  Car(this.brand);

  Car.unknown() : brand = 'Generic Brand';

  void displayInfo() {
    print('Car Brand: $brand');
  }
}

/// Lớp con ElectricCar kế thừa từ Car
class ElectricCar extends Car {
  int batteryCapacity;

  ElectricCar(super.brand, this.batteryCapacity);

  @override
  void displayInfo() {
    print('Electric Car: $brand | Battery: ${batteryCapacity}kWh');
  }
}

/// Hàm tính tổng 2 số nguyên
int calcSum(int a, int b) {
  return a + b;
}

/// Hàm nhân đôi một số nguyên
int multiplyByTwo(int x) => x * 2;

/// Generator hàm tạo Stream phát ra chuỗi số nguyên
Stream<int> generateStream(int count) async* {
  for (int i = 1; i <= count; i++) {
    yield i;
  }
}
