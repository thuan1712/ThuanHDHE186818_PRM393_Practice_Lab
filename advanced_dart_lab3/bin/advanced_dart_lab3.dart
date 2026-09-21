import 'dart:async';
import 'package:advanced_dart_lab3/advanced_dart_lab3.dart';

// -------------------------------------------------------------
// Bài 1: Product Model & Repository (Futures & Streams)
// -------------------------------------------------------------
Future<void> exercise1() async {
  final repo = ProductRepository();

  final subscription = repo.liveAdded().listen((product) {
    print('  [Stream Event] Sản phẩm mới được thêm: $product');
  });

  print('1. Đang tải danh sách sản phẩm ban đầu...');
  final initialProducts = await repo.getAll();
  print('   Danh sách hiện có:');
  for (var p in initialProducts) {
    print('   - $p');
  }

  print('\n2. Thêm 2 sản phẩm mới vào repository:');
  repo.addProduct(Product(id: 3, name: 'iPad Air M2', price: 599.99));
  repo.addProduct(Product(id: 4, name: 'AirPods Pro 2', price: 249.99));

  await Future.delayed(const Duration(milliseconds: 100));
  await subscription.cancel();
  repo.dispose();
}

// -------------------------------------------------------------
// Bài 2: User Repository với JSON (Serialization / Deserialization)
// -------------------------------------------------------------
Future<void> exercise2() async {
  final userRepo = UserRepository();
  print('Đang lấy và chuyển đổi dữ liệu JSON từ API giả lập...');
  final users = await userRepo.fetchUsers();

  print('Kết quả sau khi parse JSON thành các đối tượng User:');
  for (var user in users) {
    print('  - $user');
  }
}

// -------------------------------------------------------------
// Bài 3: Async + Microtask Debugging (Event Loop Order)
// -------------------------------------------------------------
Future<void> exercise3() async {
  print('1. [Đồng bộ] Bắt đầu thực thi');

  Future(() {
    print('4. [Event Queue] Future callback chạy');
  });

  scheduleMicrotask(() {
    print('3. [Microtask Queue] scheduleMicrotask chạy');
  });

  print('2. [Đồng bộ] Kết thúc thực thi đồng bộ');

  await Future.delayed(const Duration(milliseconds: 100));

  print('\n-- Giải thích nguyên lý Event Loop của Dart --');
  print('1. Code đồng bộ (Synchronous) luôn được thực hiện ngay lập tức.');
  print('2. Microtask Queue có độ ưu tiên cao hơn Event Queue.');
  print('3. Sau khi code đồng bộ chạy xong, Dart giải quyết toàn bộ tác vụ trong Microtask Queue.');
  print('4. Khi Microtask Queue hoàn toàn trống, Dart mới lấy tác vụ từ Event Queue để xử lý.');
}

// -------------------------------------------------------------
// Bài 4: Stream Transformation (map & where)
// -------------------------------------------------------------
Future<void> exercise4() async {
  final Stream<int> numbersStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  print('Dữ liệu Stream ban đầu: [1, 2, 3, 4, 5]');

  final Stream<int> transformedStream = transformNumbers(numbersStream);

  print('Kết quả sau khi biến đổi map(x^2) và lọc where(chẵn):');
  await for (final val in transformedStream) {
    print('  -> Emitted: $val');
  }
}

// -------------------------------------------------------------
// Bài 5: Factory Constructor & Cache (Singleton Pattern)
// -------------------------------------------------------------
void exercise5() {
  final settingsA = Settings();
  final settingsB = Settings();

  print('settingsA: $settingsA');
  print('settingsB: $settingsB');

  final isSame = identical(settingsA, settingsB);
  print('Kiểm tra identical(settingsA, settingsB): $isSame');

  settingsA.theme = 'Light Mode';
  print('\nThay đổi settingsA.theme = "Light Mode"');
  print('Kiểm tra lại settingsB.theme: ${settingsB.theme}');
  print('-> Cả 2 biến cùng dùng chung một vùng nhớ Singleton.');
}

// -------------------------------------------------------------
// Hàm main thực thi tuần tự các bài tập
// -------------------------------------------------------------
void main() async {
  print('=== LAB 3: ADVANCED DART PRACTICE EXERCISES ===\n');

  print('--- EXERCISE 1: PRODUCT MODEL & REPOSITORY ---');
  await exercise1();

  print('\n--- EXERCISE 2: USER REPOSITORY WITH JSON ---');
  await exercise2();

  print('\n--- EXERCISE 3: ASYNC + MICROTASK DEBUGGING ---');
  await exercise3();

  print('\n--- EXERCISE 4: STREAM TRANSFORMATION ---');
  await exercise4();

  print('\n--- EXERCISE 5: FACTORY CONSTRUCTORS & CACHE ---');
  exercise5();

  print('\n[SUCCESS] Hoàn thành toàn bộ bài tập Lab 3!');
}
