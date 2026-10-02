import 'package:ex1_6/ex1_6.dart';

void main() {
  print('=== BÀI 1.6 (Ex1.6): XỬ LÝ NULL SAFETY & FACTORY CONSTRUCTOR ===\n');

  // Giả lập dữ liệu JSON trả về từ API
  Map<String, dynamic> rawData1 = {
    "id": 1,
    "name": "Nam",
    "email": "nam@fpt.edu.vn",
  };
  Map<String, dynamic> rawData2 = {
    "id": 2,
    "name": null,
    "email": null,
  };

  // TODO 4: Khởi tạo user1 và user2 từ 2 Map trên bằng User.fromJson và gọi showProfile()
  print('1. Thông tin người dùng 1 (Dữ liệu đầy đủ):');
  User user1 = User.fromJson(rawData1);
  user1.showProfile();

  print('\n--------------------------------------------------------------\n');

  print('2. Thông tin người dùng 2 (Dữ liệu null/thiếu):');
  User user2 = User.fromJson(rawData2);
  user2.showProfile();
}
