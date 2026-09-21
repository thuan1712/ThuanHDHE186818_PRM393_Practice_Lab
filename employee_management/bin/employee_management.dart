import 'package:employee_management/employee_management.dart';

void main() {
  print('=== HỆ THỐNG QUẢN LÝ NHÂN VIÊN VỚI MIXIN & SPREAD OPERATOR ===\n');

  List<Developer> teamA = [Developer('An'), Developer('Bình')];
  List<Developer> teamB = [Developer('Cường')];

  print('Danh sách teamA: ${teamA.map((e) => e.name).toList()}');
  print('Danh sách teamB: ${teamB.map((e) => e.name).toList()}\n');

  // TODO 3: Dùng Spread Operator (...) để gộp teamA và teamB vào allStaff
  List<Developer> allStaff = [...teamA, ...teamB];
  print('Tổng số nhân sự sau khi gộp bằng Spread Operator (...): ${allStaff.length}\n');

  // TODO 4: Dùng vòng lặp gọi hàm checkIn() cho tất cả nhân sự trong allStaff
  print('-- TIẾN HÀNH ĐIỂM DANH VÀ LÀM VIỆC --');
  for (var staff in allStaff) {
    staff.checkIn();
    staff.work();
    print('---');
  }
}
