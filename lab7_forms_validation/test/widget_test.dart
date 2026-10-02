import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab7_forms_validation/main.dart';

void main() {
  testWidgets('SignupScreen renders all input fields and submit button',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SignupApp());

    expect(find.text('Đăng ký tài khoản mới'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.text('Đăng ký tài khoản'), findsOneWidget);
  });

  testWidgets('Empty form submission triggers validation errors',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SignupApp());

    // Tap submit button with empty form
    await tester.ensureVisible(find.byType(FilledButton));
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    // Verify error messages
    expect(find.text('Vui lòng nhập họ và tên'), findsOneWidget);
    expect(find.text('Vui lòng nhập địa chỉ email'), findsOneWidget);
    expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);
    expect(find.text('Bạn cần đồng ý với điều khoản để tiếp tục đăng ký'),
        findsOneWidget);
  });

  testWidgets('Password strength and confirmation mismatch validation',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SignupApp());

    final textFields = find.byType(TextFormField);

    // Enter name
    await tester.enterText(textFields.at(0), 'Hoàng Đức Thuận');

    // Enter valid email
    await tester.enterText(textFields.at(1), 'thuanhd@fpt.edu.vn');

    // Enter short password without numbers
    await tester.enterText(textFields.at(2), 'abc');
    await tester.pumpAndSettle();
    expect(find.text('Mật khẩu phải có tối thiểu 8 ký tự'), findsOneWidget);

    // Enter 8 chars without digit
    await tester.enterText(textFields.at(2), 'abcdefgh');
    await tester.pumpAndSettle();
    expect(find.text('Mật khẩu phải chứa ít nhất 1 chữ số (0-9)'), findsOneWidget);

    // Enter valid password
    await tester.enterText(textFields.at(2), 'SecurePass123');

    // Enter mismatching confirm password
    await tester.enterText(textFields.at(3), 'DifferentPass123');
    await tester.pumpAndSettle();
    expect(find.text('Mật khẩu xác nhận không trùng khớp'), findsOneWidget);
  });

  testWidgets('Async validation detects taken email',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SignupApp());

    final textFields = find.byType(TextFormField);

    await tester.enterText(textFields.at(0), 'Hoàng Đức Thuận');
    await tester.enterText(textFields.at(1), 'taken.user@domain.com');
    await tester.enterText(textFields.at(2), 'Secure123Pass');
    await tester.enterText(textFields.at(3), 'Secure123Pass');

    // Accept terms
    await tester.ensureVisible(find.byType(Checkbox));
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    // Tap submit
    await tester.ensureVisible(find.byType(FilledButton));
    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    // Verifies loading state
    expect(find.text('Đang kiểm tra email...'), findsOneWidget);

    // Wait for the async 2-second check
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Verify taken email error
    expect(find.textContaining('đã được sử dụng'), findsOneWidget);
  });

  testWidgets('Valid submission displays success dialog',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SignupApp());

    final textFields = find.byType(TextFormField);

    await tester.enterText(textFields.at(0), 'Hoàng Đức Thuận');
    await tester.enterText(textFields.at(1), 'thuanhdhe186818@fpt.edu.vn');
    await tester.enterText(textFields.at(2), 'MatKhau123');
    await tester.enterText(textFields.at(3), 'MatKhau123');

    // Accept terms
    await tester.ensureVisible(find.byType(Checkbox));
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    // Submit
    await tester.ensureVisible(find.byType(FilledButton));
    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    // Fast-forward 2 seconds
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Verify success dialog
    expect(find.text('Đăng ký thành công!'), findsOneWidget);
    expect(find.textContaining('Hoàng Đức Thuận'), findsWidgets);
    expect(find.textContaining('thuanhdhe186818@fpt.edu.vn'), findsWidgets);
  });
}
