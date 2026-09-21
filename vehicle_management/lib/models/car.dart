import 'vehicle.dart';

// TODO 2: Định nghĩa class Car kế thừa từ Vehicle.
// Thêm thuộc tính bool isElectric.
class Car extends Vehicle {
  bool isElectric;

  // TODO 3: Viết constructor mặc định cho Car (dùng super để truyền brand và year).
  Car(super.brand, super.year, {this.isElectric = false});

  // Viết Named Constructor: Car.tesla(int year) thiết lập sẵn brand="Tesla" và isElectric=true.
  Car.tesla(int year)
      : isElectric = true,
        super('Tesla', year);

  // TODO 4: Ghi đè (@override) hàm startEngine() để in ra thông báo chi tiết hơn.
  @override
  void startEngine() {
    if (isElectric) {
      print('$brand ($year) khởi động êm ái: Không có tiếng động cơ (Xe điện)!');
    } else {
      print('$brand ($year) khởi động: Vrooom! Động cơ xăng gầm rú!');
    }
  }
}
