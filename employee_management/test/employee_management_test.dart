import 'package:employee_management/employee_management.dart';
import 'package:test/test.dart';

void main() {
  group('Employee & Mixin Tests', () {
    test('Developer káº¿ thá»«a Employee vÃ  sá»Ÿ há»¯u mixin CheckInAbility', () {
      final dev = Developer('An');
      expect(dev.name, equals('An'));
      expect(dev, isA<Employee>());
      expect(dev, isA<CheckInAbility>());
    });

    test('Spread Operator gá»™p danh sÃ¡ch Developer chÃ­nh xÃ¡c', () {
      List<Developer> teamA = [Developer('An'), Developer('BÃ¬nh')];
      List<Developer> teamB = [Developer('CÆ°á»ng')];
      List<Developer> allStaff = [...teamA, ...teamB];

      expect(allStaff.length, equals(3));
      expect(allStaff.map((d) => d.name).toList(), equals(['An', 'BÃ¬nh', 'CÆ°á»ng']));
    });
  });
}
