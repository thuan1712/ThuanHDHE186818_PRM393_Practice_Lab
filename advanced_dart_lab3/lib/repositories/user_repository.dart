import 'dart:convert';
import '../models/user.dart';

class UserRepository {
  final String _mockApiResponse = '''
  [
    {"name": "Hoang Duc Thuan", "email": "thuanhdhe186818@fpt.edu.vn"},
    {"name": "Nguyen Van A", "email": "anguyen@fpt.edu.vn"},
    {"name": "Tran Thi B", "email": "btran@fpt.edu.vn"}
  ]
  ''';

  Future<List<User>> fetchUsers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final List<dynamic> jsonList = jsonDecode(_mockApiResponse) as List<dynamic>;
    return jsonList
        .map((item) => User.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
