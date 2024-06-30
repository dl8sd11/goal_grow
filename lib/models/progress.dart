import 'package:goal_grow_flutter/models/check.dart';
import 'package:goal_grow_flutter/models/goal.dart';

class Progress {
  final Goal goal;
  final List<Check> checks;

  Progress({
    required this.goal,
    required this.checks,
  });

  String report() {
    return goal.description.replaceAll("?", total().toString());
  }

  double total() {
    double sum = 0;
    for (Check check in checks) {
      sum += check.amount;
    }
    return sum;
  }
}
