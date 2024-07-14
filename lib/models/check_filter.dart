import 'package:goal_grow_flutter/models/check.dart';
import 'package:goal_grow_flutter/models/goal.dart';

class CheckFilter {
  final List<Check> checks;

  CheckFilter({required this.checks});

  List<Check> filterByGoal(Goal goal) {
    return checks.where((element) => element.goalId == goal.id).toList();
  }
}
