import 'dart:async';

// -------------------------------------------------------------
// Exercise 4: Classes, Constructors, Inheritance & Overriding
// -------------------------------------------------------------

// Lớp Car với thuộc tính brand và phương thức displayInfo
class Car {
  String brand;

  // Constructor tiêu chuẩn
  Car(this.brand);

  // Named constructor
  Car.unknown() : brand = 'Generic Brand';

  void displayInfo() {
    print('Car Brand: $brand');
  }
}

// Lớp ElectricCar kế thừa từ Car
class ElectricCar extends Car {
  int batteryCapacity;

  // Constructor gọi super của lớp cha
  ElectricCar(super.brand, this.batteryCapacity);

  // Ghi đè phương thức displayInfo của lớp cha
  @override
  void displayInfo() {
    print('Electric Car: $brand | Battery: ${batteryCapacity}kWh');
  }
}

// -------------------------------------------------------------
// Hàm main thực thi tuần tự 5 bài tập
// -------------------------------------------------------------
void main() async {
  print('====================================================');
  print('--- EXERCISE 1: BASIC SYNTAX & DATA TYPES ----------');
  print('====================================================');
  exercise1();

  print('\n====================================================');
  print('--- EXERCISE 2: COLLECTIONS & OPERATORS -------------');
  print('====================================================');
  exercise2();

  print('\n====================================================');
  print('--- EXERCISE 3: CONTROL FLOW & FUNCTIONS -----------');
  print('====================================================');
  exercise3();

  print('\n====================================================');
  print('--- EXERCISE 4: INTRO TO OOP -----------------------');
  print('====================================================');
  exercise4();

  print('\n====================================================');
  print('--- EXERCISE 5: ASYNC, FUTURE, NULL SAFETY & STREAMS');
  print('====================================================');
  await exercise5();

  print('\n[SUCCESS] Hoàn thành tất cả 5 bài tập mà không có lỗi!');
}

// -------------------------------------------------------------
// Exercise 1: Cú pháp cơ bản và các kiểu dữ liệu
// -------------------------------------------------------------
void exercise1() {
  // Khai báo các biến với các kiểu dữ liệu cơ bản
  int age = 22;
  double gpa = 3.65;
  String studentName = 'Hoang Duc Thuan';
  bool isEnrolled = true;

  // In ra màn hình sử dụng string interpolation ($var và ${expr})
  print('Student Name : $studentName');
  print('Student Age  : $age (In 5 years: ${age + 5})');
  print('Current GPA  : $gpa (Percentage: ${(gpa / 4.0 * 100).toStringAsFixed(1)}%)');
  print('Is Enrolled  : $isEnrolled');
}

// -------------------------------------------------------------
// Exercise 2: Thao tác với List, Set, Map và Operators
// -------------------------------------------------------------
void exercise2() {
  // Tạo List số nguyên, thêm và xóa phần tử
  List<int> numbers = [10, 20, 30, 40];
  numbers.add(50);
  numbers.remove(20);
  print('Updated List: $numbers');

  // Toán tử số học và so sánh
  int arithmeticResult = (numbers[0] + numbers[1]) * 2;
  bool isGreater = numbers[2] > numbers[0];
  print('Toán tử số học ((10 + 30) * 2): $arithmeticResult');
  print('Toán tử so sánh (numbers[2] > numbers[0]): $isGreater');

  // Set lưu các giá trị duy nhất (loại bỏ trùng lặp)
  Set<String> uniqueTags = {'Flutter', 'Dart', 'Mobile'};
  uniqueTags.add('Flutter');
  print('Unique Set Tags: $uniqueTags');

  // Map lưu dữ liệu theo cặp key - value
  Map<String, dynamic> studentRecord = {
    'id': 'HE186818',
    'major': 'Software Engineering',
    'credits': 3,
  };
  studentRecord['semester'] = 'Fall 2026';
  print('Student Map Record: $studentRecord');

  // Toán tử logic (&&) và toán tử ba ngôi (? :)
  bool isMajorValid = studentRecord['major'] == 'Software Engineering';
  bool isCreditValid = (studentRecord['credits'] as int) >= 3;
  String courseStatus = (isMajorValid && isCreditValid)
      ? 'Eligible for Specialization'
      : 'Requires Prerequisite';
  print('Toán tử logic & ba ngôi: $courseStatus');
}

// -------------------------------------------------------------
// Exercise 3: Control Flow (if/else, switch, loop) và Functions
// -------------------------------------------------------------
void exercise3() {
  // 1. If/else kiểm tra điểm số
  double score = 8.5;
  if (score >= 8.5) {
    print('Điểm $score: Xếp loại A (Xuất sắc)');
  } else if (score >= 7.0) {
    print('Điểm $score: Xếp loại B (Khá)');
  } else {
    print('Điểm $score: Xếp loại C (Trung bình)');
  }

  // 2. Switch case xác định thứ trong tuần
  int dayOfWeek = 4;
  switch (dayOfWeek) {
    case 1:
      print('Ngày $dayOfWeek: Thứ Hai');
      break;
    case 2:
      print('Ngày $dayOfWeek: Thứ Ba');
      break;
    case 3:
      print('Ngày $dayOfWeek: Thứ Tư');
      break;
    case 4:
      print('Ngày $dayOfWeek: Thứ Năm');
      break;
    default:
      print('Ngày $dayOfWeek: Ngày khác');
  }

  // 3. Duyệt collection bằng for, for-in, và forEach
  List<String> frameworks = ['Flutter', 'React Native', 'SwiftUI'];

  print('-- Vòng lặp for --');
  for (int i = 0; i < frameworks.length; i++) {
    print('Index $i: ${frameworks[i]}');
  }

  print('-- Vòng lặp for-in --');
  for (var fw in frameworks) {
    print('Item: $fw');
  }

  print('-- Phương thức forEach --');
  void printItem(String item) => print('forEach Item: $item');
  frameworks.forEach(printItem);

  // 4. Gọi hàm thông thường và hàm arrow syntax
  print('Hàm thông thường (calcSum 15 + 25): ${calcSum(15, 25)}');
  print('Hàm mũi tên (multiplyByTwo 12): ${multiplyByTwo(12)}');
}

// Hàm cú pháp thông thường
int calcSum(int a, int b) {
  return a + b;
}

// Hàm cú pháp mũi tên (arrow syntax)
int multiplyByTwo(int x) => x * 2;

// -------------------------------------------------------------
// Exercise 4: Chạy kiểm thử khởi tạo đối tượng Car & ElectricCar
// -------------------------------------------------------------
void exercise4() {
  // Khởi tạo bằng constructor thông thường
  Car standardCar = Car('Toyota Corolla');
  standardCar.displayInfo();

  // Khởi tạo bằng named constructor
  Car genericCar = Car.unknown();
  genericCar.displayInfo();

  // Khởi tạo lớp con kế thừa
  ElectricCar myEV = ElectricCar('Tesla Model 3', 75);
  myEV.displayInfo();
}

// -------------------------------------------------------------
// Exercise 5: Async/Await, Null Safety và Stream
// -------------------------------------------------------------
Future<void> exercise5() async {
  // Toán tử null safety: ?, ??, !
  String? nullableName;
  String resolvedName = nullableName ?? 'Tên mặc định';
  print('Null-safety (Toán tử ??): $resolvedName');

  String? nonNullGuaranteed = resolveNullableValue(true);
  String unwrappedValue = nonNullGuaranteed!;
  print('Null-safety (Toán tử !): $unwrappedValue');

  // Async / await và Future.delayed
  print('Đang tải dữ liệu...');
  String apiResponse = await fetchMockData();
  print('Kết quả: $apiResponse');

  // Stream số nguyên với await for
  print('Dữ liệu từ Stream:');
  Stream<int> intStream = generateStream(3);
  await for (int val in intStream) {
    print('  -> Stream: $val');
  }
}

String? resolveNullableValue(bool isValid) {
  return isValid ? 'Dữ liệu hợp lệ' : null;
}

// Giả lập bất đồng bộ với Future.delayed
Future<String> fetchMockData() async {
  await Future.delayed(const Duration(milliseconds: 1500));
  return '200 OK: Tải dữ liệu thành công.';
}

// Generator Stream phát số nguyên
Stream<int> generateStream(int count) async* {
  for (int i = 1; i <= count; i++) {
    await Future.delayed(const Duration(milliseconds: 500));
    yield i;
  }
}