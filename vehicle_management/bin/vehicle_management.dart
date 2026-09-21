import 'package:vehicle_management/vehicle_management.dart';

void main() {
  print('=== HỆ THỐNG QUẢN LÝ PHƯƠNG TIỆN GIAO THÔNG (OOP & KẾ THỪA) ===\n');

  // TODO 5: Khởi tạo một xe Car bình thường và gọi startEngine()
  print('1. Khởi tạo xe xăng thông thường:');
  Car regularCar = Car('Toyota Camry', 2022, isElectric: false);
  print('Xe: ${regularCar.brand}, Năm sản xuất: ${regularCar.year}, Xe điện: ${regularCar.isElectric}');
  regularCar.startEngine();

  print('\n--------------------------------------------------------------\n');

  // TODO 6: Khởi tạo một xe Car bằng Named Constructor (Car.tesla) và gọi startEngine()
  print('2. Khởi tạo xe điện bằng Named Constructor Car.tesla:');
  Car teslaCar = Car.tesla(2024);
  print('Xe: ${teslaCar.brand}, Năm sản xuất: ${teslaCar.year}, Xe điện: ${teslaCar.isElectric}');
  teslaCar.startEngine();
}
