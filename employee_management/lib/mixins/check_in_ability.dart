import '../models/employee.dart';

// TODO 1: Khai báo mixin CheckInAbility giới hạn cho Employee
mixin CheckInAbility on Employee {
  void checkIn() {
    print('$name đã điểm danh.');
  }
}
