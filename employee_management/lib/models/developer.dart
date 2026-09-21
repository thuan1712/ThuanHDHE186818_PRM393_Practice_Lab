import 'employee.dart';
import '../mixins/check_in_ability.dart';

// TODO 2: Tích hợp mixin CheckInAbility vào class này
class Developer extends Employee with CheckInAbility {
  Developer(super.name);

  @override
  void work() => print('$name đang viết code.');
}
