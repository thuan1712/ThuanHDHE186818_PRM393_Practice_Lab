class User {
  int id;
  String name;
  // TODO 1: Khai báo biến email có thể mang giá trị null (nullable variable)
  String? email;

  // Constructor
  User({required this.id, required this.name, this.email});

  // TODO 2: Khai báo factory User.fromJson(Map<String, dynamic> json)
  // - Lấy id từ json['id']
  // - Lấy name từ json['name']. Nếu null, dùng toán tử ?? để gán mặc định là "Khách"
  // - Lấy email từ json['email']
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: (json['name'] as String?) ?? 'Khách',
      email: json['email'] as String?,
    );
  }

  void showProfile() {
    // TODO 3: In ra thông tin. Dùng toán tử ?? để xử lý email nếu bị null.
    // Gợi ý chuỗi in ra: "ID: $id | Tên: $name | Email: ..."
    print('ID: $id | Tên: $name | Email: ${email ?? "Chưa cập nhật"}');
  }
}
