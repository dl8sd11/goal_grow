import 'package:flutter/material.dart';
import 'package:goal_grow_flutter/models/check.dart';
import 'package:goal_grow_flutter/models/goal.dart';
import 'package:goal_grow_flutter/models/progress.dart';

class ProgressesOfGoal {
  final Goal goal;
  final List<Check> checks;

  ProgressesOfGoal({required this.goal, required this.checks});

  List<Progress> report() {
    Map<DateTime, List<Check>> groupedChecks = {};
    for (Check check in checks) {
      var group = groupedChecks.putIfAbsent(
          DateUtils.dateOnly(check.createdAt), () => []);
      group.add(check);
    }

    var progresses = groupedChecks.entries.toList();
    progresses.sort(((a, b) => a.key.compareTo(b.key)));
    return progresses
        .map((e) => Progress(goal: goal, checks: e.value))
        .toList();
  }
}
